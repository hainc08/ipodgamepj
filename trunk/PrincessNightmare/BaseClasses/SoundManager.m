#import "SoundManager.h"

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
	bgmPlayer = nil;
	fxPlayer = nil;

	lastFX = @"";
	lastBGM = @"";

	fxVolume = bgmVolume = 1; // default 설정
}

-(void)closeManager
{
	[bgmPlayer stop];
	[bgmPlayer dealloc];

	[fxPlayer stop];
	[fxPlayer dealloc];
}

-(void)playBGM:(NSString*)name
{
	lastBGM = name;

	// make file URL
	NSString* filePath = [NSString stringWithFormat: @"%@/%@", [[NSBundle mainBundle] resourcePath], name];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];
	
	// checkfile exist
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:filePath];
	if(!success) {
		NSLog(@"sound file does not exist");
		return;
	}

	[self stopBGM];
	
	bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
	[bgmPlayer prepareToPlay];
	[bgmPlayer setDelegate:self];

	[bgmPlayer setVolume: fxVolume];
	[bgmPlayer setNumberOfLoops:-1];
	[bgmPlayer play];

	[filePath release];
	[fileURL release];
}
	
-(void)playFX:(NSString*)name repeat:(bool)repeat
{
	lastFXRepeat = repeat;
	lastFX = name;
	
	NSString* filePath = [NSString stringWithFormat: @"%@/%@", [[NSBundle mainBundle] resourcePath], name];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:filePath];
	if(!success) {
		NSLog(@"sound file does not exist");
		return;
	}
	
	[self stopFX];
	
	fxPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	[fxPlayer prepareToPlay];
	[fxPlayer setDelegate:self];
	
	[fxPlayer setVolume: fxVolume];
	if (repeat)
		[fxPlayer setNumberOfLoops:-1];
	else
		[fxPlayer setNumberOfLoops:0];
	[fxPlayer play];
	
	[filePath release];
	[fileURL release];
}

-(void) setFxVolume : (float) level 
{
    fxVolume = level; // 볼륨 설정
}

-(void) setBGMVolume : (float) level 
{
    bgmVolume = level; // 볼륨 설정
}

-(void)stopBGM
{
	if (bgmPlayer != nil)
	{
		[bgmPlayer stop];
		[bgmPlayer setCurrentTime:0];
	}
}

-(void)stopFX
{
	if (fxPlayer != nil)
	{
		[fxPlayer stop];
		[fxPlayer setCurrentTime:0];
	}
}

-(void) stopAll
{
	lastFX = @"";
	lastBGM = @"";

	[self stopBGM];
	[self stopFX];
}

-(void) pause
{
	[self stopBGM];
	[self stopFX];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag
{
    // This is protocol's callback function. But we do not use this.
}

-(void)restart
{
	if ([lastBGM length] > 0) [self playBGM:lastBGM];
	if ([lastFX length] > 0) [self playFX:lastFX repeat:lastFXRepeat];
}

@end
