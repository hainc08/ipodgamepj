#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject {
    SystemSoundID _soundID;

	SoundEffect *reserve;

	bool isPlaying;
	bool hasReserve;
}

@property (nonatomic) bool isPlaying;
@property (nonatomic) bool hasReserve;

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath;
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfFile:(NSString *)path reserve:(int)reserveCount;
- (void)play;
- (void)stop;

static void completionCallback (SystemSoundID  mySSID, void* myself);

@end
