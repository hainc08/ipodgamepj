#import "Object.h"

@interface Box : Object {
	IBOutlet UIImageView* imgView;
    int floor;
}
@property (readwrite ) int floor;
- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;

@end
