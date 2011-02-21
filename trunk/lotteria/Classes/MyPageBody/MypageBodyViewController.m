#import "MypageBodyViewController.h"

@implementation MypageBodyViewController

@synthesize Login;


- (void)viewDidLoad {
	[super viewDidLoad];
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


- (IBAction)OrderListButton
{
	//Login이 된 플레그가 0 이면 login페이지로 1이면 List 페이지 이동 
	//if () 
	{
		LoginViewController *Login_tmp = [[LoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
		self.Login = Login_tmp;
		self.Login.delegate = self;
		[self.view insertSubview:Login_tmp.view atIndex:9];
		
		[Login_tmp release];
	}
}


#pragma mark -
#pragma mark LoginViewDelegate

-(void)returnLoginValue:(NSString *)LoginInfo
{
}

@end
