#import "SoundEffect.h"

@implementation SoundEffect

@synthesize isPlaying;
@synthesize hasReserve;

+ (id)soundEffectWithContentsOfFile:(NSString *)aPath {
    if (aPath) {
        return [[[SoundEffect alloc] initWithContentsOfFile:aPath] autorelease];
    }
    return nil;
}

- (id)initWithContentsOfFile:(NSString *)path reserve:(int)reserveCount{
	[self initWithContentsOfFile:path];
	if (reserveCount > 0)
	{
		self.hasReserve = TRUE;
		reserve = [[SoundEffect alloc] initWithContentsOfFile:path reserve:reserveCount-1];
	}
	return self;
}

- (id)initWithContentsOfFile:(NSString *)path {
    self = [super init];
	self.isPlaying = FALSE;
	self.hasReserve = FALSE;
    
    if (self != nil) {
        NSURL *aFileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        if (aFileURL != nil)  {
            SystemSoundID aSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
            
            if (error == kAudioServicesNoError) { // success
                _soundID = aSoundID;
            } else {
                NSLog(@"Error %d loading sound at path: %@", error, path);
                [self release], self = nil;
            }
        } else {
            NSLog(@"NSURL is nil for path: %@", path);
            [self release], self = nil;
        }
    }
    return self;
}

-(void)dealloc {
    AudioServicesDisposeSystemSoundID(_soundID);
    [super dealloc];
}

-(void)play {
	if (isPlaying)
	{
		if (hasReserve) [reserve play];
	}
	else
	{
		AudioServicesAddSystemSoundCompletion (_soundID,NULL,NULL,completionCallback,(void*) self);
		self.isPlaying = TRUE;
		AudioServicesPlaySystemSound(_soundID);
	}
}

-(void)stop {
	self.isPlaying = FALSE;
	AudioServicesRemoveSystemSoundCompletion (_soundID);
}

static void completionCallback (SystemSoundID  mySSID, void* myself) {
	[(SoundEffect*)myself stop];
}

@end
