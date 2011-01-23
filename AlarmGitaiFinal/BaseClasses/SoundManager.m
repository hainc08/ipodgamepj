#import "SoundManager.h"
#import	"AlarmConfig.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>

static SoundManager *SoundManagerInst;

@implementation SoundManager

+ (SoundManager*)getInstance
{
	return SoundManagerInst;
}

+ (void)initManager;
{
	SoundManagerInst = [SoundManager alloc];
	[SoundManagerInst reset];
}

- (void)reset
{
	if(curAlarmPlayer != nil)
	{
	[curAlarmPlayer dealloc];
	curAlarmPlayer = nil;
	}

}

-(void)closeManager
{
	[curAlarmPlayer stop];
	[curAlarmPlayer dealloc];
}

-(void)stopSound
{
	if (curAlarmPlayer != nil)
	{
		[curAlarmPlayer stop];
		[curAlarmPlayer setCurrentTime:0];
	}
}

-(void)playSound:(NSString *) _inSoundName 
{
	
	if (curAlarmPlayer != nil)
	{
		[ self stopSound];
	}
	
	// make file URL
	NSString* filePath = [NSString stringWithFormat: @"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], _inSoundName];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];
	
	// checkfile ex
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:filePath];
	if(!success) {
		NSLog(@"sound file does not exist");
		return;
	}
	
	curAlarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
	[curAlarmPlayer prepareToPlay];
	[curAlarmPlayer setDelegate:self];	
	[filePath release];
	[fileURL release];
	
	[curAlarmPlayer setVolume:1.f];
	[curAlarmPlayer setNumberOfLoops:-1];
	
	[curAlarmPlayer play];

}

-(void)playAlarm:(AlarmDate *)_inData 
{
	// make file URL
	NSString* SoundName;
	
	int index = [[AlarmConfig getInstance] getSoundRow:_inData.Sound];
	if(index == 0)
		SoundName = @"alarm01";
	else 
		SoundName  = [NSString stringWithFormat:@"bgm%02d", index];

	
	NSString* filePath = [NSString stringWithFormat: @"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], SoundName];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];
	
	// checkfile ex
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:filePath];
	if(!success) {
		NSLog(@"sound file does not exist");
		return;
	}
	[ self stopAlarm];
	
	curAlarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
	[curAlarmPlayer prepareToPlay];
	[curAlarmPlayer setDelegate:self];	
	[filePath release];
	[fileURL release];
	
	//[curAlarmPlayer setVolume: _inData.SoundVolume];
	[curAlarmPlayer setVolume: 1];
	[curAlarmPlayer setNumberOfLoops:-1];

	[curAlarmPlayer play];
	
	if(_inData.VibrationONOFF)
	{
		[self resumeTimer];
	}
}

-(void) setAlarmVolume : (float) level 
{
	if (curAlarmPlayer != nil) [curAlarmPlayer setVolume: level];
}


-(void)stopAlarm
{
	if (curAlarmPlayer != nil)
	{
		[curAlarmPlayer stop];
		[curAlarmPlayer setCurrentTime:0];
	}
	if( VibrationONOFF)
	{
		VibrationONOFF =FALSE;
		[vibrationTimer invalidate]; 
		[vibrationTimer release];
	}
	
}

- (void)vibration
{
	
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
- (void)resumeTimer
{
	VibrationONOFF =TRUE;
	vibrationTimer = [[NSTimer scheduledTimerWithTimeInterval: (0.5f)
													target: self
												  selector: @selector(vibration)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag
{
    // This is protocol's callback function. But we do not use this.
}

@end
