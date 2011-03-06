#import "MainBodyViewController.h"
#import "FindBodyViewController.h"
#import "IconButton.h"

#define SearchBase @"메뉴를 검색해 주세요."

@implementation MainBodyViewController

- (void)viewDidLoad {
	naviImgIdx = 1;
	[super viewDidLoad];
	detailView = [[DetailViewController alloc] init];
	[detailView setNavi:navi];
	[baseView addSubview:detailView.view];
	[detailView.view setAlpha:0];
	[detailView makeHalfMode];

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
	lastIconButton = nil;
	
	searchField.delegate = self;
}

-(void)back
{
	self.navigationItem.leftBarButtonItem = nil;
	[backButton removeFromSuperview];
	
	//디테일 뷰를 숨기자...
	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[buttonView setAlpha:1];
	[detailView.view setAlpha:0];

	[normalBG1 setAlpha:0];
	[normalBG2 setAlpha:0];

	[burgerBG setAlpha:alphaValue[0]];
	[chickenBG setAlpha:alphaValue[1]];
	[dessertBG setAlpha:alphaValue[2]];
	[drinkBG setAlpha:alphaValue[3]];
	[packBG setAlpha:alphaValue[4]];
	
	[UIView commitAnimations];
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == lastButton) return;
	lastButton = sender;

	if (sender == burgerButton)
	{
		[self setScrollBar:@"D10"];
	}
	else if (sender == chickenButton)
	{
		[self setScrollBar:@"D20"];
	}
	else if (sender == dessertButton)
	{
		[self setScrollBar:@"D30"];
	}
	else if (sender == drinkButton)
	{
		[self setScrollBar:@"D40"];
	}
	else if (sender == packButton)
	{
		[self setScrollBar:@"D50"];
	}
}

- (IBAction)FindClick
{
	if ([[searchField text] compare:SearchBase] == NSOrderedSame)
	{
		[[DataManager getInstance] searchProduct:@""];
	}
	else
	{
		[[DataManager getInstance] searchProduct:[searchField text]];
	}
	
	FindBodyViewController* findBody = [[FindBodyViewController alloc] init];
	[findBody setNavi:navi];
	[findBody setBackView:self];

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
	[[icon view] setCenter:CGPointMake([[scrollView subviews] count] * 63 + 3 + 32 - 63, 35)];
	[icon setData:menuId];
	[icon setSelected:false];
	[icon setListener:self];
}

- (void)iconClicked:(id)button :(NSString*)mid
{
	[normalBG1 setAlpha:1];
	[normalBG2 setAlpha:1];

	alphaValue[0] = [burgerBG alpha];
	alphaValue[1] = [chickenBG alpha];
	alphaValue[2] = [dessertBG alpha];
	alphaValue[3] = [drinkBG alpha];
	alphaValue[4] = [packBG alpha];

	[burgerBG setAlpha:0];
	[chickenBG setAlpha:0];
	[dessertBG setAlpha:0];
	[drinkBG setAlpha:0];
	[packBG setAlpha:0];
	
	if ((lastIconButton != nil)&&
		(button != lastIconButton)) [(IconButton*)lastIconButton setSelected:false];

	{
		UIImage *buttonImage = [UIImage imageNamed:@"btn_com_top_back_off.png"];
		UIImage *buttonImage2 = [UIImage imageNamed:@"btn_com_top_back_on.png"];

		backButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[backButton setImage:buttonImage forState:UIControlStateNormal];
		[backButton setImage:buttonImage2 forState:UIControlStateHighlighted];
		[backButton setImage:buttonImage2 forState:UIControlStateSelected];
		
		backButton.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
		
		[backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
		
		UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
		self.navigationItem.leftBarButtonItem = customBarItem;
		[customBarItem release];
	}

	lastIconButton = button;

	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];

	[backButton setAlpha:1];
	[buttonView setAlpha:0];
	[detailView showProduct:mid];
	[detailView.view setAlpha:1];

	[UIView commitAnimations];
}

- (void)setScrollBar:(NSString*)category
{
	bool isTopList;
	[normalBG1 setAlpha:0];
	[normalBG2 setAlpha:0];

	if ([category compare:@"D10"] == NSOrderedSame)
	{
		[burgerBG setAlpha:1];
		[chickenBG setAlpha:0];
		isTopList = true;
	}
	else if ([category compare:@"D20"] == NSOrderedSame)
	{
		[burgerBG setAlpha:0];
		[chickenBG setAlpha:1];
		isTopList = true;
	}
	else if ([category compare:@"D30"] == NSOrderedSame)
	{
		[drinkBG setAlpha:0];
		[packBG setAlpha:0];
		[dessertBG setAlpha:1];
		isTopList = false;
	}
	else if ([category compare:@"D40"] == NSOrderedSame)
	{
		[dessertBG setAlpha:0];
		[packBG setAlpha:0];
		[drinkBG setAlpha:1];
		isTopList = false;
	}
	else if ([category compare:@"D50"] == NSOrderedSame)
	{
		[drinkBG setAlpha:0];
		[dessertBG setAlpha:0];
		[packBG setAlpha:1];
		isTopList = false;
	}
	
	[UIView beginAnimations:@"menuAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	float offset[2];
	CGPoint centerPos = CGPointMake(160, [baseView frame].size.height * 0.5f);
	
	if (isTopList)
	{
		centerPos.y += 34;
		[detailView.view setCenter:centerPos];
		
		[topList setCenter:CGPointMake(160, 40)];
		[bottomList setCenter:CGPointMake(160, 367+40)];
		
		offset[0] = 47.f;
		offset[1] = 19.f;
		
		NSArray* subviews = [topScrollView subviews];
		for (id data in subviews)
		{
			UIView* view = (UIView*)data;
			[view removeFromSuperview];
		}
	}
	else
	{
		centerPos.y -= 35;
		[detailView.view setCenter:centerPos];
		
		[topList setCenter:CGPointMake(160, -40)];
		[bottomList setCenter:CGPointMake(160, 367-40)];
		
		offset[0] = -5.f;
		offset[1] = -15.f;
		
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

#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	[self FindClick];
//	FindBodyViewController * find = [[FindBodyViewController alloc] init];
//	[self.navigationController pushViewController:find  animated:YES];
//	[find release];
	return YES;
}

- (IBAction)FieldStart
{
	[self.view bringSubviewToFront:fieldGuard];
	[self.view bringSubviewToFront:findView];
	
	[UIView beginAnimations:@"findAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[self.view setCenter:CGPointMake(160, 30)];
	
	[UIView commitAnimations];
}

- (IBAction)FieldEnd
{
	[self.view sendSubviewToBack:findView];
	[self.view sendSubviewToBack:fieldGuard];
	
	[UIView beginAnimations:@"findAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	[self.view setCenter:CGPointMake(160, 208)];
	
	[UIView commitAnimations];
}

@end
