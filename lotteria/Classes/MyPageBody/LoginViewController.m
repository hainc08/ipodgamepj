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
#import "CartMyShippingListView.h"
#import "NaviViewController.h"
#import "HttpRequest.h"
#import "ViewManager.h"
#import "XmlParser.h"

@implementation LoginViewController
@synthesize LoginNextType;
- (void)viewDidLoad {
	naviImgIdx = 0;

    [super viewDidLoad];
	
	Password.returnKeyType = UIReturnKeyDone;
	ID.delegate = self;
	Password.delegate = self;
	self.navigationItem.title = @"로그인";
	[self reset];

}

- (void)viewDidUnload {
	if(httpRequest){
		[httpRequest release];
		httpRequest = nil;
    }
	[ID resignFirstResponder];
	[Password resignFirstResponder];
	[super viewDidUnload];
}


- (void)dealloc {
	if(httpRequest){
		[httpRequest release];
		httpRequest = nil;
    }
	[ID resignFirstResponder];
	[Password resignFirstResponder];
    [super dealloc];
}

- (void)reset
{
	if([[DataManager getInstance] isLoginSave])
	{
		ID.text =  [[DataManager getInstance] accountId];
		Password.text =  [[DataManager getInstance] accountPass];
		[ID_Save setAlpha:0];
		[ID_Save2 setAlpha:1];
	}
	else {
		ID.text = @"";
		Password.text = @"";
		[ID_Save setAlpha:1];
		[ID_Save2 setAlpha:0];
	}
}

- (IBAction)IDSaveButton
{
	[[DataManager getInstance] setIsLoginSave:![[DataManager getInstance] isLoginSave]];
	if([[DataManager getInstance] isLoginSave])
	{
		[ID_Save setAlpha:0];
		[ID_Save2 setAlpha:1];
	}
	else 
	{
		[ID_Save setAlpha:1];
		[ID_Save2 setAlpha:0];
	}
}
/* 영문 4~15자리 한글 x 
 특수문자( -  _  )  사용 
 */

- (IBAction)LoginButton 
{
	// Login 하자..

	if (( [ID.text length] == 0 ) || ( [Password.text length] == 0 ))
	{
		[self ShowOKAlert:ALERT_TITLE msg:LOGIN_INPUT_ERROR_MSG];
		return;
	}

	if (( [ID.text length] >  15 ) || ( [ID.text length] < 4 ))
	{
		[self ShowOKAlert:ALERT_TITLE msg:LOGIN_ID_INPUT_ERROR_MSG];
		return;
	}

	if (( [Password.text length] > 15 ) || ( [Password.text length] < 6 ))
	{
		[self ShowOKAlert:ALERT_TITLE msg:LOGIN_PASS_INPUT_ERROR_MSG];
		return;
	}

	NSURL *url = [NSURL URLWithString: @"http://homeservice.lotteria.com/Auth/MBlogin_test1.asp?Rstate=1"];
	NSString *body = [NSString stringWithFormat: @"sid=RIA&cust_id=%@&cust_pwd=%@", ID.text, Password.text];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
	[webView loadRequest: request];
	[webView setDelegate: self];
	finishCount = 0;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	++finishCount;
	if (finishCount == 4)
	{
		httpRequest = [[HTTPRequest alloc] init];
		
		// HTTP Request 인스턴스 생성
		

		// 통신 완료 후 호출할 델리게이트 셀렉터 설정
		[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
		
		// 페이지 호출
		[httpRequest requestUrlFull:SERVERURL_MEMBER bodyObject:nil bodyArray:nil];
		[[ViewManager getInstance] waitview:self.view isBlock:YES];		
	}
}

#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}


#pragma mark -
#pragma mark HttpRequestDelegate
/* 
 <?xml version="1.0" encoding="utf-8"?>
 <NewDataSet>
 <RESULT_CODE>Y</RESULT_CODE>
 <CUST_ID>mobileuser</CUST_ID>
 <CUST_PHONE>01012345678</CUST_PHONE>
 </NewDataSet>
 */

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	
	[[ViewManager getInstance] waitview:self.view isBlock:NO];
	[ID resignFirstResponder];
	[Password resignFirstResponder];

	if(![result compare:@"error"])
	{
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	}
	else {

		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		if (root == nil || [[[root getChild:@"RESULT_CODE"] getValue] compare:@"Y"] != NSOrderedSame )
		{
			[self ShowOKAlert:ERROR_TITLE msg:LOGIN_FAIL_MSG];
			return;
		}
		else
		{
			NSString *Cust_ID =  [[root getChild:@"CUST_ID"] getValue] ;
			NSString *Cust_PHONE =  [[root getChild:@"CUST_PHONE"] getValue] ;
			[[DataManager getInstance] setCust_id:Cust_ID];
			[[DataManager getInstance] setCust_phone:Cust_PHONE];
		}
		
		[xmlParser release];
		
		
		if([[DataManager getInstance] isLoginSave])
		{
			[[DataManager getInstance] setAccountId:ID.text];
			[[DataManager getInstance] setAccountPass:Password.text];
			[[DataManager getInstance] LoginSave];
		}
		else {
			[[DataManager getInstance] setAccountId:@""];
			[[DataManager getInstance] setAccountPass:Password.text];
			[[DataManager getInstance] LoginSave];
		}
		
		[[DataManager getInstance] setIsLoginNow:TRUE];
	}
	[httpRequest release];
	httpRequest = nil;


	[[ViewManager getInstance] closePopUp];

}

@end
