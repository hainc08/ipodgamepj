#import <AVFoundation/AVFoundation.h>

@interface SoundManager : NSObject <AVAudioPlayerDelegate> {
	NSString* bgmName;
	
	AVAudioPlayer* curBgmPlayer;
	AVAudioPlayer* curFxPlayer;

	AVAudioPlayer* bgmPlayer[35];
	AVAudioPlayer* fxPlayer[216];

	AVAudioPlayer* otherFxPlayer;
	
	float bgmVolume;
	float fxVolume;
}

+ (SoundManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

-(void) stopAll;

-(void) setFxVolume : (float) level;
-(void) setBGMVolume : (float) level; 

-(void)playBGM:(NSString*)name idx:(int)idx;
-(void)playFX:(NSString*)name repeat:(bool)repeat;
-(void)playFX2:(NSString*)name idx:(int)idx repeat:(bool)repeat;
-(void)stopBGM;
-(void)stopFX;
@end
