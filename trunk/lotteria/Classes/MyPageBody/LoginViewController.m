//
//  LoginViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 20..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "DataManager.h"
#import "MypageBodyViewController.h"
@implementation LoginViewController

@synthesize Request;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	ID.text =  [[DataManager getInstance] accountId];
	Password.text =  [[DataManager getInstance] accountPass];

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[Request release];
    [super dealloc];
}

- (IBAction)LoginButton 
{
	NSString *string = @" <NewDataSet> \
	<item>\
	<SI>서울특별시</SI>\
	<GU>영등포구</GU>\
	<ADONG>신길5동</ADONG>\
	<LDONG>신길동</LDONG>\
	<POI_NM>411-11</POI_NM>\
	<POINT_X>303230.84375</POINT_X>\
	<POINT_Y>544574.0625</POINT_Y>\
	</item>\
	<item>\
	<SI>서울특별시</SI>\
	<GU>영등포구</GU>\
	<ADONG>신길1동</ADONG>\
	<LDONG>신길동</LDONG>\
	<POI_NM>산111-11</POI_NM>\
	<POINT_X>304303.4375</POINT_X>\
	<POINT_Y>545587.25</POINT_Y>\
	</item>\
	<item>\
	<SI>서울특별시</SI>\
	<GU>영등포구</GU>\
	<ADONG>신길1동</ADONG>\
	<LDONG>신길동</LDONG>\
	<POI_NM>111-11</POI_NM>\
	<POINT_X>304584.75</POINT_X>\
	<POINT_Y>546160.5</POINT_Y>\
	</item>\
	</NewDataSet>";
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
	    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    [parser parse];
	    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    [parser release];
	
	
	// Login 하자..
/*	if([ID.text length] >  10 || [ID.text length] < 4 )
	{
		[self ShowOKAlert:@"Login Error" msg:@"Login ID 가 10자 이상입니다."];
		return;
	}
	if([Password.text length] >  12)
	{
		[self ShowOKAlert:@"Login Error" msg:@"Password 가 12자 이상입니다."];
		return;
	}*/
	[[DataManager getInstance] setAccountId:ID.text];
	[[DataManager getInstance] setAccountPass:Password.text];
	// 접속할 주소 설정
	NSString *url = @"http://your.webpage.url";
	
	// HTTP Request 인스턴스 생성
	HTTPRequest *httpRequest = [[HTTPRequest alloc] init];
	
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"1234",@"cust_id",
								@"12345", @"cust_passwd",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject];

}

#pragma mark -
#pragma mark HttpRequestDelegate

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Login Error" msg:@"로그인에 실패 했습니다."];	
	}
	else {
		
		MypageBodyViewController *mypage = [[MypageBodyViewController alloc] initWithNibName:@"MypageBodyView" bundle:nil];
		[self.view addSubview:mypage.view];
		[mypage release];
	}

	
}


#pragma mark -
#pragma mark AlertView
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

 - (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
 {
	 // 필요한 엑션이 있으면 넣자 ..
 }



/*
 <NewDataSet>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길5동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>411-11</POI_NM>
 <POINT_X>303230.84375</POINT_X>
 <POINT_Y>544574.0625</POINT_Y>
 </item>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길1동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>산111-11</POI_NM>
 <POINT_X>304303.4375</POINT_X>
 <POINT_Y>545587.25</POINT_Y>
 </item>
 <item>
 <SI>서울특별시</SI>
 <GU>영등포구</GU>
 <ADONG>신길1동</ADONG>
 <LDONG>신길동</LDONG>
 <POI_NM>111-11</POI_NM>
 <POINT_X>304584.75</POINT_X>
 <POINT_Y>546160.5</POINT_Y>
 </item>
 </NewDataSet>
 */



@end
