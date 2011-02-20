#import "MainBodyViewController.h"
#import "IconButton.h"

@implementation MainBodyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	detailView = [[DetailViewController alloc] init];
	[self.view addSubview:detailView.view];
	[detailView.view setCenter:CGPointMake(160, 250)];
	[detailView.view setAlpha:0];

	[topList setCenter:CGPointMake(160, 0)];
	[bottomList setCenter:CGPointMake(160, 450)];
	
	buttonOrigin[0] = burgerButton.center;
	buttonOrigin[1] = chickenButton.center;
	buttonOrigin[2] = dessertButton.center;
	buttonOrigin[3] = drinkButton.center;
	buttonOrigin[4] = packButton.center;
}

- (IBAction)ButtonClick:(id)sender
{
	bool isTopList;
	
	if (sender == burgerButton)
	{
		isTopList = true;
	}
	else if (sender == chickenButton)
	{
		isTopList = true;
	}
	else if (sender == dessertButton)
	{
		isTopList = false;
	}
	else if (sender == drinkButton)
	{
		isTopList = false;
	}
	else if (sender == packButton)
	{
		isTopList = false;
	}
	
	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	float offset[2];
	if (isTopList)
	{
		[topList setCenter:CGPointMake(160, 60)];
		[bottomList setCenter:CGPointMake(160, 440)];
		[detailView.view setCenter:CGPointMake(160, 270)];

		offset[0] = 40.f;
		offset[1] = 20.f;

		NSArray* subviews = [topScrollView subviews];
		for (id data in subviews)
		{
			UIView* view = (UIView*)data;
			[view removeFromSuperview];
		}
		
		[detailView.view setCenter:CGPointMake(160, 230)];
	}
	else
	{
		[topList setCenter:CGPointMake(160, 0)];
		[bottomList setCenter:CGPointMake(160, 380)];
		[detailView.view setCenter:CGPointMake(160, 230)];

		offset[0] = -20.f;
		offset[1] = -40.f;

		NSArray* subviews = [bottomScrollView subviews];
		for (id data in subviews)
		{
			UIView* view = (UIView*)data;
			[view removeFromSuperview];
		}

		[detailView.view setCenter:CGPointMake(160, 170)];
	}

	[burgerButton	setCenter:CGPointMake(buttonOrigin[0].x, buttonOrigin[0].y + offset[0])];
	[chickenButton	setCenter:CGPointMake(buttonOrigin[1].x, buttonOrigin[1].y + offset[0])];
	[dessertButton	setCenter:CGPointMake(buttonOrigin[2].x, buttonOrigin[2].y + offset[1])];
	[drinkButton	setCenter:CGPointMake(buttonOrigin[3].x, buttonOrigin[3].y + offset[1])];
	[packButton		setCenter:CGPointMake(buttonOrigin[4].x, buttonOrigin[4].y + offset[1])];

	[UIView commitAnimations];

	[self addIcon:0 isTop:isTopList];
	[self addIcon:1 isTop:isTopList];
	[self addIcon:2 isTop:isTopList];
	[self addIcon:3 isTop:isTopList];
	[self addIcon:4 isTop:isTopList];
	[self addIcon:5 isTop:isTopList];
	[self addIcon:6 isTop:isTopList];

	UIScrollView* scrollView;
	if (isTopList) scrollView = topScrollView;
	else scrollView = bottomScrollView;

	[scrollView setContentSize:CGSizeMake([[scrollView subviews] count]* 70, 60)];
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

- (void)addIcon:(int)idx isTop:(bool)isTop
{
	IconButton* icon = [[IconButton alloc] init];
	UIScrollView* scrollView;
	
	if (isTop) scrollView = topScrollView;
	else scrollView = bottomScrollView;
	
	[scrollView addSubview:[icon view]];
	[[icon view] setCenter:CGPointMake([[scrollView subviews] count] * 70 - 35, 35)];
	[icon setData:idx];
	[icon setListener:self];
}

- (void)iconClicked:(int)idx
{
	[detailView showProduct:idx];
	[detailView.view setAlpha:1];
}

@end
