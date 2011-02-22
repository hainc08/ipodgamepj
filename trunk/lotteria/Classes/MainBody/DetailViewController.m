#import "DetailViewController.h"

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
	pId[0] = menu_id;

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
		[optionView1 setCenter:CGPointMake(160, 87)];
		[addCartButton setCenter:CGPointMake(160, 214)];

		[closeButton setCenter:CGPointMake(300, 63)];
		
		//기본 사이드를 설정하자.
		pId[1] = @"";
		pId[2] = @"";
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
		[optionView1 setCenter:CGPointMake(160, 127)];
		[addCartButton setCenter:CGPointMake(160, 184)];

		[closeButton setCenter:CGPointMake(300, 90)];

		//사이드가 없다.
		pId[1] = @"200504";	//세트포테이토
		pId[2] = @"200807";	//세트콜라
	}
	else if (sender == addCartButton)
	{
		[selectView setAlpha:0];
		
		CartItem* item = [[CartItem alloc] init];
		[item setCount:count];
		[item setMenuid:pId[0]];
		[item setDrinkId:pId[1]];
		[item setDessertId:pId[2]];
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
}

@end
