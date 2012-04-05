#import "Ghost.h"

@interface GhostSparta : Ghost {
	IBOutlet id Shield;
}

- (id)initWithType:(int)type;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

