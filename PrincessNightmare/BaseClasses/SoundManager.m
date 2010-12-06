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
#ifdef __SIMUL
	return;
#endif
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

	[bgmPlayer setVolume: bgmVolume];
	[bgmPlayer setNumberOfLoops:-1];
	[bgmPlayer play];

	[filePath release];
	[fileURL release];
}
	
-(void)playFX:(NSString*)name repeat:(bool)repeat
{
#ifdef __SIMUL
	return;
#endif
	
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
	if (bgmPlayer != nil) [bgmPlayer setVolume: bgmVolume];
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
	[self stopBGM];
	[self stopFX];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag
{
    // This is protocol's callback function. But we do not use this.
}

@end
