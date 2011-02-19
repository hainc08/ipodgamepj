#import "MainBodyViewController.h"

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
		[bottomList setCenter:CGPointMake(160, 450)];
		offset[0] = 40.f;
		offset[1] = 20.f;
	}
	else
	{
		[topList setCenter:CGPointMake(160, 0)];
		[bottomList setCenter:CGPointMake(160, 390)];
		offset[0] = -20.f;
		offset[1] = -40.f;
	}

	[burgerButton	setCenter:CGPointMake(buttonOrigin[0].x, buttonOrigin[0].y + offset[0])];
	[chickenButton	setCenter:CGPointMake(buttonOrigin[1].x, buttonOrigin[1].y + offset[0])];
	[dessertButton	setCenter:CGPointMake(buttonOrigin[2].x, buttonOrigin[2].y + offset[1])];
	[drinkButton	setCenter:CGPointMake(buttonOrigin[3].x, buttonOrigin[3].y + offset[1])];
	[packButton		setCenter:CGPointMake(buttonOrigin[4].x, buttonOrigin[4].y + offset[1])];

	[UIView commitAnimations];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
