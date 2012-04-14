#import "Box.h"
#import "DefaultInfo.h"
@interface Gum : UIImageView {
	CGPoint     pos;
    GumAttactInfo* attack;
	bool isPop;
	int popTime;
	int gumColor;
	bool attackDir;
}

- (id)initWithPos:(CGPoint)p attack:(GumAttactInfo*)a;
- (bool)update;

@end

@interface BoxGum : Box {
	float shotDelay;
	float shotWait;
	float waitStep;
    BOX_TYPE   boxtype;
	IBOutlet UIImageView* nozzle;

	NSMutableArray* gums;
	NSMutableIndexSet *discardedGums;

	GumAttactInfo attackInfo;
}

- (id)init;
- (void)reset;
- (bool)update:(UInt32)tick;

@end
