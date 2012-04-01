#import "Object.h"

@interface Ghost : Object {

}

- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

