#import "Ghost.h"

@interface GhostSparta : Ghost {
	IBOutlet id Shield;
	float shieldHealth;
	float shieldAlpha;
}

- (id)initWithType:(int)type;
- (void)hit:(float)damage :(int)type :(bool)dir;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

