#import "AlarmGitaiViewController.h"
#import "ActionManager.h"

@implementation AlarmGitaiViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[[ActionManager getInstance] playAction:@"GameStart" param:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[touch setAlpha:0];

	[UIView beginAnimations:@"anime2" context:NULL];
	[UIView setAnimationDuration:2];
	[UIView setAnimationDelay:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[touch setAlpha:1];
	[UIView commitAnimations];

}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
