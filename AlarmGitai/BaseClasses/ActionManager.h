@interface ActionManager : NSObject
{
	UINavigationController *navigationController;
}

+ (ActionManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)playAction:(NSString*)action param:(NSMutableArray*)actionParam;
- (void)setNavigationController:(UINavigationController*)nController;

//- (void)setRootAction:(int) actionParam;
-(void)setRootAction:(int)_inType value:(NSObject *)_inValue;
@end