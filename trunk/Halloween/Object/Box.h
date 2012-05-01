#import "Object.h"

@interface Box : Object {
	IBOutlet UIImageView* imgView;
	UIImageView* effectView;

	float fallSpeed;
	float fallYpos;
	bool isFall;
	
	int popEffect;
}

@property (readonly) float fallYpos;
@property (readonly) bool isFall;

- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;
- (void)drop:(int)xPos :(int)yPos :(int)yPos2;

@end
