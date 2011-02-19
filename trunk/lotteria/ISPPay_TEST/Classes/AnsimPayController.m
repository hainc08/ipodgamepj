//
//  AnsimPayController.m
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnsimPayController.h"

@implementation AnsimPayController



@synthesize s_mname;
@synthesize s_businessnum;
@synthesize s_hosturl;
@synthesize s_cardtype;
@synthesize s_currency;
@synthesize s_receiveurl;
@synthesize s_amount;
@synthesize  PayView ;

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	//(필수 ) 삼성카드 가맹점 번호 사업자 번호 필수 
	NSString *APVL_CHAIN_NO_SS=@""; //삼성카드 가맹점 번호
	NSString *APVL_SELLER_ID=@""; //삼성카드 사업자번호 
	
	//현대카드 세이브 이용시 (공인인증서 모바일 사용불가로 처리안됨.)
	//NSString *APVL_CHAIN_NO_HD=@"11111"; //hyundaicard 가맹점 번호
	//NSString *APVL_SELLER_HD=@"11111"; //hyundaicard 사업자번호 
	//NSString *APVL_SS_USEYN_HD=@"11111"; //Hyundaicard 세이브 사용여부 Y/N 
	
	
	
	NSString *paramStr = [[NSString alloc] initWithFormat: @"X_MNAME=%@&X_MBUSINESSNUM=%@&X_CARDTYPE=%@&X_CURRENCY=%@&X_RECEIVEURL=%@&X_AMOUNT=%@&APVL_CHAIN_NO_SS=%@&APVL_SELLER_ID=%@",s_mname, s_businessnum,s_cardtype,s_currency,s_receiveurl,s_amount,APVL_CHAIN_NO_SS,APVL_SELLER_ID];
	
	int timeout=10.0;
	NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:s_hosturl]
														  cachePolicy:NSURLRequestReloadIgnoringCacheData 
													  timeoutInterval:timeout];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[paramStr dataUsingEncoding:NSUTF8StringEncoding]];
	[paramStr release];
	
	[PayView loadRequest:request];	
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(IBAction) closeButton{
	[self.view removeFromSuperview];
	
}

-(void)setAnsimValue:(NSString *) x_mname 
			  amount:(NSString *) x_amount
		 cardtype:(NSString *) x_cardtype 

{
	self.s_mname		= x_mname;		// 결제 품목
	self.s_cardtype		= x_cardtype;	// 카드 타입  
	self.s_amount		= x_amount;		//결제금액 

	
	// 사업자 번호 
	self.s_businessnum	= @"1231231230";
	// 원화  "410" 
	self.s_currency		= @"410";
	
	//호스팅 응답받을 url  "https://mpi.dacom.net/XMPI/m_hostAgent12.jsp"
	self.s_receiveurl	= @"https://mpi.dacom.net/XMPI/m_hostAgent12.jsp";
	
	//호스트 url "https://mpi.dacom.net/XMPI/m_hostAgent01.jsp"
	self.s_hosturl		= @"https://mpi.dacom.net/XMPI/m_hostAgent01.jsp";


    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView1 { 
	
	NSString* frm = [webView1 stringByEvaluatingJavaScriptFromString: @"document.forms[0].name"]; 
	
	if ( YES==[@"X_RESULT" isEqualToString:frm]){
		
		NSString* r_resp		 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_RESP.value"]; 
		NSString* r_msg			 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_MSG.value"]; 
		NSString* r_xid			 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_XID.value"]; 
		NSString* r_eci			 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_ECI.value"]; 
		NSString* r_cavv		 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_CAVV.value"]; 
		NSString* r_cardno		 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_CARDNO.value"]; 
		NSString* r_joincode	 = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_JOINCODE.value"]; 
		NSString* r_hs_useamt_sh = [PayView stringByEvaluatingJavaScriptFromString: @"document.X_RESULT.X_HS_USEAMT_SH.value"]; 
		
		NSLog(@"============카드사에서 내려준 안심클릭 응답값입니다. ============");
		NSLog(@"x_resp가 0000일경우만 정상처리 하시면 됩니다.");
		
		NSLog(@"x_resp=====>%@", r_resp);
		NSLog(@"x_msg=====>%@", r_msg);
		NSLog(@"x_xid=====>%@", r_xid);
		NSLog(@"x_eci=====>%@", r_eci);
		NSLog(@"x_cavv=====>%@", r_cavv);
		NSLog(@"x_cardno=====>%@", r_cardno);
		NSLog(@"x_joincode=====>%@",r_joincode);
		NSLog(@"x_hs_useamt_sh=====>%@",r_hs_useamt_sh);
		NSLog(@"============카드사에서 내려준 안심클릭 응답 ============");
		
		
		if ([r_resp isEqualToString:@"0000"]){
			
			// ****카드사 인증이 정상완료 되었습니다. VAN에서 제공하는 승인모듈을 테우시면 됩니다.******
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"인증결과" 
														  message:@"카드인증이 완료되었습니다" 
														 delegate:nil 
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			//리턴 받은 내용을 넘겨준다 .. 이 View를 호출한 곳으로 [super 로 돌려 보낸다. ]
			[self.delegate returnAnsimValue:r_resp
										msg:(NSString *)r_msg
										xid:(NSString *)r_xid
										eci:(NSString *)r_eci
									   cavv:(NSString *)r_cavv
									 cardno:(NSString *)r_cardno
								   joincode:(NSString *)r_joincode 
			 ];
			
		} else {
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"인증결과" 
														  message:r_msg 
														 delegate:nil 
												cancelButtonTitle:@"OK" 
												otherButtonTitles:nil];
			[alert show];
			[alert release];			
		}
		
		
		[self.view removeFromSuperview];
		
	}
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
