#import "BaseView.h"

@interface ErrorManager : NSObject
{

}

+ (ErrorManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)ERROR:(char*)msg value:(int)val;

@end
