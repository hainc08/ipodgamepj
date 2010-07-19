#import <AVFoundation/AVFoundation.h>

@interface SoundManager : NSObject <AVAudioPlayerDelegate> {
	AVAudioPlayer* bgmPlayer;
	AVAudioPlayer* fxPlayer;
	
	float bgmVolume;
	float fxVolume;
	
	NSString* lastFX;
	bool lastFXRepeat;
	NSString* lastBGM;
}

+ (SoundManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

-(void) stopAll;

-(void) setFxVolume : (float) level;
-(void) setBGMVolume : (float) level; 

-(void)playBGM:(NSString*)name;
-(void)playFX:(NSString*)name repeat:(bool)repeat;
-(void)stopBGM;
-(void)stopFX;

-(void)restart;
@end
