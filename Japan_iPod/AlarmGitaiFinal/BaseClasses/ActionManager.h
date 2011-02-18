@interface ActionManager : NSObject
{
	UINavigationController *navigationController;
}

+ (ActionManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)playAction:(NSString*)action param:(NSMutableArray*)actionParam;
- (void)setNavigationController:(UINavigationController*)nController;

@end
