#import <AVFoundation/AVFoundation.h>

@class AlarmDate;

@interface SoundManager : NSObject <AVAudioPlayerDelegate> {
	AVAudioPlayer* curAlarmPlayer;
	NSTimer *vibrationTimer;
	BOOL VibrationONOFF;
}

+ (SoundManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

-(void) setAlarmVolume : (float) level; 

-(void)playAlarm:(AlarmDate *)_inData;
-(void)stopAlarm;
- (void)resumeTimer;
- (void)vibration;

-(void)playSound:(NSString *) _inSoundName ;
-(void)stopSound;

@end
