#import <QuartzCore/QuartzCore.h>
#import "SoundEffect.h" 

enum
{
	Logo_Sound = 0,
	Max_Sound
};

@interface SoundManager : NSObject
{
    SoundEffect *sounds[Max_Sound];
	int requestCount[Max_Sound];
	bool mute;
}

+ (SoundManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)setSound:(int)idx sound:(SoundEffect*)sound;
- (void)playSound:(int)idx;
- (void)soundRequest:(int)idx;
- (void)playRequest;
- (void)setMute:(bool)m;
- (bool)getMute;

@end
