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

- (void)showProduct:(int)idx
{
	[pImage setImage:[[DataManager getInstance] getProductImg:idx type:DETAIL]];
	[nameImage setImage:[[DataManager getInstance] getProductImg:idx type:NAME]];
	[descImage setImage:[[DataManager getInstance] getProductImg:idx type:DESC]];
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
		[optionView1 setCenter:CGPointMake(160, 103)];
		[addCartButton setCenter:CGPointMake(160, 230)];

		[closeButton setCenter:CGPointMake(300, 80)];
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
		[optionView1 setCenter:CGPointMake(160, 143)];
		[addCartButton setCenter:CGPointMake(160, 200)];

		[closeButton setCenter:CGPointMake(300, 107)];
	}
	else if (sender == addCartButton)
	{
		[selectView setAlpha:0];
		//뭐 어찌어찌 처리하자...
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
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[selectView setAlpha:0];
		[UIView commitAnimations];
	}
}

@end
