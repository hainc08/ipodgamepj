#import "Object.h"

enum GHOST_TYPE {
    GHOST_NONE = 0,
    GHOST_CANDY,
    GHOST_DIE,
    GHOST_SUCESS,
    GHOST_END
};

@interface Ghost : Object {

	UIImage* img[4];
	
	IBOutlet UIImageView* imgView;
	int imgIdx;
    int ghost_type;
}

- (id)initWithType:(int)type;
- (void)reset;
- (bool)update:(UInt32)tick;

@end

