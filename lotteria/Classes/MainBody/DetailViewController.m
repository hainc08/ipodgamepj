#import "DetailViewController.h"
#import "ChangeSideViewController.h"

@implementation DetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[contentScrollView setContentSize:CGSizeMake(320, 380)];
	count = 1;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (void)showProduct:(NSString*)menu_id
{
	pId[0] = productId = menu_id;

	[pImage setImage:[[DataManager getInstance] getProductImg:menu_id type:DETAIL]];
	[nameImage setImage:[[DataManager getInstance] getProductImg:menu_id type:NAME]];
	[descImage setImage:[[DataManager getInstance] getProductImg:menu_id type:DESC]];
	[selectView setAlpha:0];
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == setButton)
	{
		[UIView beginAnimations:@"menuAni" context:NULL];
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[selectView setAlpha:1];
		[UIView commitAnimations];
		
		[singleBack setAlpha:0];
		[setBack setAlpha:1];

		[optionView2 setAlpha:1];
		[optionView1 setCenter:CGPointMake(160, 39 + 28 + 20)];
		[addCartButton setCenter:CGPointMake(160, 39 + 150 + 25)];

		[closeButton setCenter:CGPointMake(300, 39 + 21)];
		
		//기본 사이드를 설정하자.
		pId[0] = [[DataManager getInstance] getSetId:productId];
		pId[1] = @"200504";	//세트포테이토
		pId[2] = @"200807";	//세트콜라
	}
	else if (sender == singleButton)
	{
		[UIView beginAnimations:@"menuAni" context:NULL];
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[selectView setAlpha:1];
		[UIView commitAnimations];

		[singleBack setAlpha:1];
		[setBack setAlpha:0];

		[optionView2 setAlpha:0];
		[optionView1 setCenter:CGPointMake(160, 58 + 28 + 20)];
		[addCartButton setCenter:CGPointMake(160, 58 + 98 + 25)];

		[closeButton setCenter:CGPointMake(300, 58 + 21)];

		//사이드가 없다.
		pId[0] = productId;
		pId[1] = nil;
		pId[2] = nil;
	}
	else if (sender == addCartButton)
	{
		[selectView setAlpha:0];
		
		CartItem* item = [[[CartItem alloc] init] retain];
		
		NSString* category = [[[DataManager getInstance] getProduct:productId] category];

		if ([category compare:@"D10"] == NSOrderedSame) [item setListIdx:0];
		else if ([category compare:@"D20"] == NSOrderedSame) [item setListIdx:1];
		else if ([category compare:@"D30"] == NSOrderedSame) [item setListIdx:2];
		else if ([category compare:@"D40"] == NSOrderedSame) [item setListIdx:3];
		else if ([category compare:@"D50"] == NSOrderedSame) [item setListIdx:4];

		[item setCount:count];
		[item setMenuId:pId[0]];
		[item setDessertId:pId[1]];
		[item setDrinkId:pId[2]];
		[[DataManager getInstance] addCartItem:item];
	}
	else if ((sender == incCount)||(sender == decCount))
	{
		if (sender == incCount) ++count;
		else if (count > 1) --count;

		[countLabel setText:[NSString stringWithFormat:@"%d", count]];
	}
	else if (sender == closeButton)
	{
		[UIView beginAnimations:@"menuAni" context:NULL];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[selectView setAlpha:0];
		[UIView commitAnimations];
	}
	else if (sender == side1Select)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DESSERT];
		[changeView setBackView:self];
		[changeView selectId:pId[1]];
		
		[navi pushViewController:changeView animated:true];
	}
	else if (sender == side2Select)
	{
		ChangeSideViewController* changeView = [[ChangeSideViewController alloc] init];
		[changeView setNavi:navi];
		[changeView setSideType:SIDE_DRINK];
		[changeView setBackView:self];
		[changeView selectId:pId[2]];
		
		[navi pushViewController:changeView animated:true];
	}
}

- (void)sideSelected:(int)idx :(ProductData*)data
{
	if (idx == SIDE_DESSERT)
	{
		pId[1] = [data menuId];
		[side1Label setText:[data name]];
	}
	else if (idx == SIDE_DRINK)
	{
		pId[2] = [data menuId];
		[side2Label setText:[data name]];
	}
}

@end
