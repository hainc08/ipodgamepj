#import "DetailViewController.h"
#import "ChangeSideViewController.h"

@implementation DetailViewController

@synthesize fullType;

- (void)viewDidLoad {
	naviImgIdx = 1;
	[super viewDidLoad];
	[contentScrollView setContentSize:CGSizeMake(320, 380)];
	count = 1;

	[self showProduct:productId];
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
	ProductData* data = [[DataManager getInstance] getProduct:menu_id];
	
	if ([[data category] compare:@"D10"] == NSOrderedSame)
	{
		[setButton setAlpha:1];
	}
	else
	{
		[setButton setAlpha:0];
	}

	[pImage setImage:[data getProductImg:DETAIL]];
	[nameImage setImage:[data getProductImg:NAME]];
	[descImage setImage:[data getProductImg:DESC]];
	[selectView setAlpha:0];

	count = 1;
	[self refreshCount];
}

- (IBAction)ButtonClick:(id)sender
{
	if (sender == setButton)
	{
		[incCount setAlpha:0];
		[decCount setAlpha:0];
		
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

		[side1Label setText:[[[DataManager getInstance] getProduct:pId[1]] name]];
		[side2Label setText:[[[DataManager getInstance] getProduct:pId[2]] name]];
		
		count = 1;
		[self refreshCount];
	}
	else if (sender == singleButton)
	{
		[incCount setAlpha:1];
		[decCount setAlpha:1];
		
		[UIView beginAnimations:@"menuAni" context:NULL];
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[selectView setAlpha:1];
		[UIView commitAnimations];

		[singleBack setAlpha:1];
		[setBack setAlpha:0];

		[optionView2 setAlpha:0];
		[optionView1 setCenter:CGPointMake(160, 58 + 28 + 35)];
		[addCartButton setCenter:CGPointMake(160, 58 + 98 + 25)];

		[closeButton setCenter:CGPointMake(300, 58 + 21)];

		//사이드가 없다.
		pId[0] = productId;
		pId[1] = nil;
		pId[2] = nil;

		count = 1;
		[self refreshCount];
	}
	else if (sender == addCartButton)
	{
		if ([self checkCount])
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
	}
	else if ((sender == incCount)||(sender == decCount))
	{
		if (sender == incCount)
		{
			++count;
			if ([self checkCount] == false) --count;
		}
		else if (count > 1) --count;

		[self refreshCount];
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

- (void)makeHalfMode
{
	[self.view setFrame:CGRectMake(0, 0, 320, 296)];

	[contentScrollView setFrame:CGRectMake(0, 0, 320, 296)];
	[contentScrollView setCenter:CGPointMake(160, 148)];
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

- (void)refreshCount
{
	[countLabel setText:[NSString stringWithFormat:@"%d", count]];
}

- (bool)checkCount
{
	ProductData* data = [[DataManager getInstance] getProduct:productId];
	
	if ([[data category] compare:@"D10"] == NSOrderedSame)
	{
		if ([[DataManager getInstance] checkBurgerCount:count] == false)
		{
			[self ShowOKAlert:@"주문오류" msg:[NSString stringWithFormat:@"햄버거는 %d개까지 주문가능합니다.", MAX_BURGER]];
			return false;
		}
	}
		
	return true;
}

@end
