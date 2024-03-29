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
	if (bgmPlayer != nil)
	{
		[bgmPlayer stop];
		[bgmPlayer release];
		bgmPlayer = nil;
	}

	if (fxPlayer != nil)
	{
		[fxPlayer stop];
		[fxPlayer release];
		fxPlayer = nil;
	}
}

-(void)playBGM:(NSString*)name idx:(int)idx
{
	if ([name compare:bgmName] == NSOrderedSame) return;

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

	bgmPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil] retain];
	[bgmPlayer prepareToPlay];
	[bgmPlayer setDelegate:self];
	
	[bgmPlayer setVolume: bgmVolume];
	[bgmPlayer setNumberOfLoops:-1];

	[bgmPlayer play];

	if (bgmName != nil) [bgmName release];
	bgmName = [[NSString stringWithFormat:@"%@", name] retain];

	[filePath release];
	[fileURL release];
}

-(void)playFX:(NSString*)name repeat:(bool)repeat
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
	
	[self stopFX];
	
	fxPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil] retain];
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
		[bgmPlayer release];
		bgmPlayer = nil;
	}
}

-(void)stopFX
{
	if (fxPlayer != nil)
	{
		[fxPlayer stop];
		[fxPlayer release];
		fxPlayer = nil;
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
	if (player == fxPlayer)
	{
		[fxPlayer release];
		fxPlayer = nil;
	}
	else if (player == bgmPlayer)
	{
		[bgmPlayer release];
		bgmPlayer = nil;
	}
}

@end
