#import "Object.h"

@interface Candy : Object {
	IBOutlet UIImageView* imgView;
}

- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

