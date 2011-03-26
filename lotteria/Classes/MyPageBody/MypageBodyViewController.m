#import "MypageBodyViewController.h"
#import "MyCustomerDelivery.h"
#import "LoginViewController.h"
#import "DataManager.h"
#import "HttpRequest.h"
#import "XmlParser.h"

@implementation MypageBodyViewController

- (void)viewDidLoad {
	naviImgIdx = 0;
	[super viewDidLoad];
	self.navigationItem.title = @"마이페이지";
	
	if ([[DataManager getInstance] isLoginNow] == false)
	{
		LoginViewController* popView = [[LoginViewController alloc] init];
		[[ViewManager getInstance] popUp:popView owner:nil];
		[popView release];
	}
}

- (void)viewDidUnload {
	[[ViewManager getInstance] closePopUp];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)LogOutButton
{
	
	httpRequest = [[HTTPRequest alloc] init];
	
	// HTTP Request 인스턴스 생성
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								[[DataManager getInstance] cust_id] ,@"cust_id",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbCust.asmx/ws_isLogout" bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view isBlock:YES];
	
}

- (void)didReceiveFinished:(NSString *)result
{	
	[[ViewManager getInstance] waitview:self.view isBlock:NO];
	// 실패성공에러를 떠나서 무조건 사라저라.. 
	[httpRequest release];
	httpRequest = nil;
	[[DataManager getInstance] setIsLoginNow:FALSE];
	
	LoginViewController* popView = [[LoginViewController alloc] init];
	[[ViewManager getInstance] popUp:popView owner:nil];
	[popView release];
}
- (IBAction)OrderListButton
{
	MyCustomerDelivery *Coustomer = [[MyCustomerDelivery alloc] initWithNibName:@"MyCustomerDelivery" bundle:nil];
	[self.navigationController pushViewController:Coustomer animated:YES];
	[Coustomer release];
}

@end
