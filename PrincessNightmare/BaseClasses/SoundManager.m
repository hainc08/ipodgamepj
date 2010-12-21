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
	for (int i=0; i<35; ++i)
	{
		bgmPlayer[i] = nil;
	}
	for (int i=0; i<216; ++i)
	{
		fxPlayer[i] = nil;
	}

	curBgmPlayer = nil;
	curFxPlayer = nil;
	otherFxPlayer = nil;

	fxVolume = bgmVolume = 1; // default 설정
}

-(void)closeManager
{
	for (int i=0; i<35; ++i)
	{
		[bgmPlayer[i] stop];
		[bgmPlayer[i] dealloc];
	}

	for (int i=0; i<216; ++i)
	{
		[fxPlayer[i] stop];
		[fxPlayer[i] dealloc];
	}
}

-(void)playBGM:(NSString*)name idx:(int)idx
{
	if ([name compare:bgmName] == NSOrderedSame) return;

	if (bgmPlayer[idx] == nil)
	{
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
		
		bgmPlayer[idx] = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
		[bgmPlayer[idx] prepareToPlay];
		[bgmPlayer[idx] setDelegate:self];
		
		[filePath release];
		[fileURL release];
	}

	[self stopBGM];

	curBgmPlayer = bgmPlayer[idx];
	
	[curBgmPlayer setVolume: bgmVolume];
	[curBgmPlayer setNumberOfLoops:-1];

	[curBgmPlayer play];

	if (bgmName != nil) [bgmName release];
	bgmName = [[NSString stringWithFormat:@"%@", name] retain];
}

-(void)playFX2:(NSString*)name idx:(int)idx repeat:(bool)repeat
{
	if (fxPlayer[idx] == nil)
	{
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
		
		fxPlayer[idx] = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: nil];
		[fxPlayer[idx] prepareToPlay];
		[fxPlayer[idx] setDelegate:self];
		
		[filePath release];
		[fileURL release];
	}
	
	[self stopFX];

	curFxPlayer = fxPlayer[idx];

	[curFxPlayer setVolume: fxVolume];
	if (repeat)
		[curFxPlayer setNumberOfLoops:-1];
	else
		[curFxPlayer setNumberOfLoops:0];
	[curFxPlayer play];
}

-(void)playFX:(NSString*)name repeat:(bool)repeat
{
	NSString* filePath = [NSString stringWithFormat: @"%@/%@", [[NSBundle mainBundle] resourcePath], name];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:filePath];
	if(!success) {
		NSLog(@"sound file does not exist");
		return;
	}
	
	[self stopFX];
	
	otherFxPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
	[otherFxPlayer prepareToPlay];
	[otherFxPlayer setDelegate:self];
	
	[otherFxPlayer setVolume: fxVolume];
	if (repeat)
		[otherFxPlayer setNumberOfLoops:-1];
	else
		[otherFxPlayer setNumberOfLoops:0];
	[otherFxPlayer play];

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
	if (curBgmPlayer != nil) [curBgmPlayer setVolume: bgmVolume];
}

-(void)stopBGM
{
	if (curBgmPlayer != nil)
	{
		if (bgmName != nil) [bgmName release];
		bgmName = nil;
		[curBgmPlayer stop];
		[curBgmPlayer setCurrentTime:0];
	}
}

-(void)stopFX
{
	if (curFxPlayer != nil)
	{
		[curFxPlayer stop];
		[curFxPlayer setCurrentTime:0];
	}

	if (otherFxPlayer != nil)
	{
		[otherFxPlayer stop];
		[otherFxPlayer setCurrentTime:0];
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
