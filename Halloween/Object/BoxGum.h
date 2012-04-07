#import "Box.h"

@interface Gum : UIImageView {
	float damage;
	CGPoint pos;
	int speed;
}

@property (readwrite) float damage;

- (id)initWithPos:(CGPoint)p speed:(int)s;
- (bool)update;

@end

@interface BoxGum : Box {
	float shotDelay;
	float shotWait;
	float waitStep;
	
	IBOutlet UIImageView* nozzle;

	NSMutableArray* gums;
	NSMutableIndexSet *discardedGums;
}

- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;

@end
