#import "MainBodyViewController.h"

@implementation MainBodyViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	detailView = [[DetailViewController alloc] init];
	[self.view addSubview:detailView.view];
	[detailView.view setCenter:CGPointMake(160, 250)];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
