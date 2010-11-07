#import "ActionManager.h"
#import "MainView.h"
#import "MenuController.h"

static ActionManager *actionManagerInst;

@implementation ActionManager

+ (ActionManager*)getInstance
{
	return actionManagerInst;
}

+ (void)initManager
{
	actionManagerInst = [ActionManager alloc];
}

- (void)closeManager
{

}

- (void)playAction:(NSString*)action param:(NSMutableArray*)actionParam
{
	if ([action compare:@"GameStart"] == NSOrderedSame)
	{
//		int type = [(NSString*)[actionParam objectAtIndex:0] intValue];
//		int iconIdx = [(NSString*)[actionParam objectAtIndex:1] intValue];
//		NSString* iconName = (NSString*)[actionParam objectAtIndex:2];
		
		MainView* mainView = [[MainView alloc] init];
		[navigationController initWithRootViewController:mainView];
	}
}

- (void)setRootAction:(int)_inType value:(NSObject *)_inValue
{
	NSArray *ctlarr = navigationController.viewControllers;
	
	for (id oneObject in ctlarr)
		if ([oneObject isKindOfClass:[MainView class]])
		{
			MainView *root = (MainView *)oneObject;
			[root reset:_inType value:_inValue];
			break;
		}
	
}

- (void)setNavigationController:(UINavigationController*)nController
{
	navigationController = nController;
}

@end
