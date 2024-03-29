#import <AVFoundation/AVFoundation.h>

@interface SoundManager : NSObject <AVAudioPlayerDelegate> {
	NSString* bgmName;
	
	AVAudioPlayer* bgmPlayer;
	AVAudioPlayer* fxPlayer;
	
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
-(void)stopBGM;
-(void)stopFX;
@end
