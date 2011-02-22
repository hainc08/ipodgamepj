#import "MapBodyViewController.h"

@implementation MapBodyViewController

@synthesize mapView;

- (void)viewDidLoad {
	[super viewDidLoad];
	
	buttonImg[0][0] = [[UIImage imageNamed:@"btn_store_all_off.png"] retain];
	buttonImg[0][1] = [[UIImage imageNamed:@"btn_store_all_on.png"] retain];
	buttonImg[1][0] = [[UIImage imageNamed:@"btn_store_delivery_off.png"] retain];
	buttonImg[1][1] = [[UIImage imageNamed:@"btn_store_delivery_on.png"] retain];
	buttonImg[2][0] = [[UIImage imageNamed:@"btn_store_24_off.png"] retain];
	buttonImg[2][1] = [[UIImage imageNamed:@"btn_store_24_on.png"] retain];
	
	selectIdx = -1;
	[self selectCategory:0];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[buttonImg[0][0] release]; 
	[buttonImg[0][1] release]; 
	[buttonImg[1][0] release]; 
	[buttonImg[1][1] release]; 
	[buttonImg[2][0] release]; 
	[buttonImg[2][1] release]; 
	
    [super dealloc];
}

-(void)setupMap
{
}

-(void)selectCategory:(int)idx
{
	if (selectIdx == idx) return;
	selectIdx = idx;

	int i[3];
	
	i[0] = i[1] = i[2] = 0;
	i[idx] = 1;
	
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateNormal];
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateHighlighted];
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateSelected];
	
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateNormal];
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateHighlighted];
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateSelected];
	
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateNormal];
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateHighlighted];
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateSelected];	
}

-(IBAction)buttonClick:(id)sender
{
	if (sender == storeAll) [self selectCategory:0];
	else if (sender == storeDelivery) [self selectCategory:1];
	else if (sender == store24) [self selectCategory:2];
}

@end
