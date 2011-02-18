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

- (void)setNavigationController:(UINavigationController*)nController
{
	navigationController = nController;
}

@end
