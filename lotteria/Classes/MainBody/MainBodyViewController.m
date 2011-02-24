#import "MainBodyViewController.h"
#import "FindBodyViewController.h"
#import "IconButton.h"

@implementation MainBodyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	detailView = [[DetailViewController alloc] init];
	[baseView addSubview:detailView.view];
	[detailView.view setCenter:CGPointMake(160, 250)];
	[detailView.view setAlpha:0];

	[baseView bringSubviewToFront:topList];
	[baseView bringSubviewToFront:bottomList];
	[topList setCenter:CGPointMake(160, -40)];
	[bottomList setCenter:CGPointMake(160, 368+40)];
	
	buttonOrigin[0] = burgerButton.center;
	buttonOrigin[1] = chickenButton.center;
	buttonOrigin[2] = dessertButton.center;
	buttonOrigin[3] = drinkButton.center;
	buttonOrigin[4] = packButton.center;
	buttonOrigin[5] = findView.center;
	
	lastButton = nil;
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == lastButton) return;
	lastButton = sender;

	bool isTopList;
	
	[burgerBG setAlpha:0];
	[chickenBG setAlpha:0];
	[drinkBG setAlpha:0];
	[dessertBG setAlpha:0];
	[packBG setAlpha:0];

	NSString* category;

	if (sender == burgerButton)
	{
		[burgerBG setAlpha:1];
		isTopList = true;
		category = @"D10";
	}
	else if (sender == chickenButton)
	{
		[chickenBG setAlpha:1];
		isTopList = true;
		category = @"D20";
	}
	else if (sender == dessertButton)
	{
		[dessertBG setAlpha:1];
		isTopList = false;
		category = @"D30";
	}
	else if (sender == drinkButton)
	{
		[drinkBG setAlpha:1];
		isTopList = false;
		category = @"D40";
	}
	else if (sender == packButton)
	{
		[packBG setAlpha:1];
		isTopList = false;
		category = @"D50";
	}
	
	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];

	float offset[3];
	CGPoint centerPos = CGPointMake(160, [baseView frame].size.height * 0.5f);
	
	if (isTopList)
	{
		centerPos.y += 17;
		[buttonView setCenter:centerPos];
		centerPos.y += 18;
		[detailView.view setCenter:centerPos];

		[topList setCenter:CGPointMake(160, 40)];
		[bottomList setCenter:CGPointMake(160, 368+40)];

		offset[0] = 40.f;
		offset[1] = 20.f;
		offset[2] = 10.f;

		NSArray* subviews = [topScrollView subviews];
		for (id data in subviews)
		{
			UIView* view = (UIView*)data;
			[view removeFromSuperview];
		}
	}
	else
	{
		centerPos.y -= 17;
		[buttonView setCenter:centerPos];
		centerPos.y -= 18;
		[detailView.view setCenter:centerPos];
		
		[topList setCenter:CGPointMake(160, -40)];
		[bottomList setCenter:CGPointMake(160, 368-40)];

		offset[0] = 0.f;
		offset[1] = -20.f;
		offset[2] = -30.f;

		NSArray* subviews = [bottomScrollView subviews];
		for (id data in subviews)
		{
			UIView* view = (UIView*)data;
			[view removeFromSuperview];
		}
	}

	[burgerButton	setCenter:CGPointMake(buttonOrigin[0].x, buttonOrigin[0].y + offset[0])];
	[chickenButton	setCenter:CGPointMake(buttonOrigin[1].x, buttonOrigin[1].y + offset[0])];
	[dessertButton	setCenter:CGPointMake(buttonOrigin[2].x, buttonOrigin[2].y + offset[1])];
	[drinkButton	setCenter:CGPointMake(buttonOrigin[3].x, buttonOrigin[3].y + offset[1])];
	[packButton		setCenter:CGPointMake(buttonOrigin[4].x, buttonOrigin[4].y + offset[1])];

	[findView		setCenter:CGPointMake(buttonOrigin[5].x, buttonOrigin[5].y + offset[2])];

	[UIView commitAnimations];

	NSMutableArray* products = [[DataManager getInstance] getProductArray:category];
	for (ProductData* data in products)
	{
		[self addIcon:[data menuId] isTop:isTopList];
	}
	[products release];

	UIScrollView* scrollView;
	if (isTopList) scrollView = topScrollView;
	else scrollView = bottomScrollView;

	[scrollView setContentSize:CGSizeMake([[scrollView subviews] count]* 70, 70)];
	[scrollView scrollRectToVisible:CGRectMake(0, 0, 320, 70) animated:false];
}

- (IBAction)FindClick
{
	FindBodyViewController* findBody = [[FindBodyViewController alloc] init];
	[navi pushViewController:findBody animated:true];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)sender
{
	if ((sender == topScrollView)||(sender == bottomScrollView))
	{
		[self becomeFirstResponder];
	}
}

- (void)addIcon:(NSString*)menuId isTop:(bool)isTop
{
	IconButton* icon = [[IconButton alloc] init];
	UIScrollView* scrollView;
	
	if (isTop) scrollView = topScrollView;
	else scrollView = bottomScrollView;
	
	[scrollView addSubview:[icon view]];
	[[icon view] setCenter:CGPointMake([[scrollView subviews] count] * 70 - 35, 35)];
	[icon setData:menuId];
	[icon setListener:self];
}

- (void)iconClicked:(NSString*)mid
{
	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];

	[buttonView setAlpha:0];
	[detailView showProduct:mid];
	[detailView.view setAlpha:1];

	[UIView commitAnimations];
}

@end
