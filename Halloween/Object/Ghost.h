#import "Object.h"

@interface Ghost : Object {
	UIImage* img[4];
	
	IBOutlet UIImageView* imgView;
	int imgIdx;
}

- (id)initWithType:(int)type;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

