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
	processNow = false;
	[self reset];

}

- (void)viewDidUnload {

	[webView stopLoading];
	[ID resignFirstResponder];
	[Password resignFirstResponder];
	[super viewDidUnload];
}


- (void)dealloc {
	[webView stopLoading];
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

	[loadingNow setAlpha:0];
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
	//프로세싱중이면 뮈...
	if (processNow) return;
	
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
		httpRequest = [[HTTPRequest alloc] init];
	processNow = true;
	
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"MRIA",@"sid",
								ID.text,@"loginid",
								Password.text,@"password",
								nil];
	
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	// 페이지 호출
	[httpRequest  requestUrlFull:SERVERURL_TOWN bodyObject:bodyObject bodyArray:nil];
	
	[loadingNow setAlpha:1];
	[loadingNow startAnimating];

	finishCount = 0;
}
/*
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];	
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{	processNow = FALSE;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self ShowOKAlert:ALERT_TITLE msg:HTTP_ERROR_MSG];
	
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // just create a new NSURLConnection and assign it a delegate, it'll get called
	if([[[request URL] absoluteString] isEqual:SERVERURL_MEMBER] == YES)
	{
		receivedData = [[NSMutableData alloc] init];
		[NSURLConnection connectionWithRequest:request delegate:self];
		return NO;
	}

	return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse
{
	// 데이터를 전송받기 전에 호출되는 메서드, 우선 Response의 헤더만을 먼저 받아 온다.
	//[receivedData setLength:0];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	response = aResponse;
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// 데이터를 전송받는 도중에 호출되는 메서드, 여러번에 나누어 호출될 수 있으므로 appendData를 사용한다.
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[receivedData release];
	processNow = false;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
	[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	result = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	[receivedData release];
	[self  didReceiveFinished:result];
}
 */


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
- (void)didServerResult:(NSString *)result
{
	
	if( [result compare:@"error"] == NSOrderedSame || result == nil)
	{
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	}
	else {
		
		if([[DataManager getInstance] isLoginSave])
		{
			[[DataManager getInstance] setAccountId:ID.text];
			[[DataManager getInstance] setAccountPass:Password.text];
			[[DataManager getInstance] LoginSave];
		}
		else {
			[[DataManager getInstance] setAccountId:@""];
			[[DataManager getInstance] setAccountPass:@""];
			[[DataManager getInstance] LoginSave];
		}
		[[DataManager getInstance] setCust_id:ID.text];
		
		[[DataManager getInstance] setIsLoginNow:TRUE];
		[[ViewManager getInstance] closePopUp];
	}
	processNow = false;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
	[httpRequest release];
	httpRequest = nil;

}
- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	NSRange length;
	length.length = 0;
	length.location =0;
	[ID resignFirstResponder];
	[Password resignFirstResponder];
	
	
	if(result == nil) 
	{
		processNow = false;
		[loadingNow setAlpha:0];
		[loadingNow stopAnimating];	
		[httpRequest release];
		httpRequest = nil;
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_FAIL_MSG];	
	
		return	;
	}
	
	NSString *temp = nil;
	for(int loop = 0 ; loop < 4; loop++)
	{
		length = [result rangeOfString:[NSString stringWithFormat:@"%d;", loop] ];
		
		if(length.location > 80) continue;  /* 음.. location 값이 해당 문자열이 없으면 엄청 큰값을 리턴하네..;;*/
		temp = [result substringFromIndex:length.location];
		if (temp != nil) {
			break;
		}
	}
	
	if( [temp  hasPrefix:@"0;"])
	{
		
		NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
									ID.text,@"login_id",
									@"Y",@"result_flag",
									nil];
		[httpRequest setDelegate:self selector:@selector(didServerResult:)];
		// 페이지 호출
		[httpRequest  requestUrlFull:SERVERURL_MEMBER bodyObject:bodyObject bodyArray:nil];
		
		return ;
	}
	else 	if( [temp  hasPrefix:@"1;"])
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_FAIL_MSG];
	else 	if( [temp  hasPrefix:@"2;"])
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_AUTH_CUST_FAIL];
	else 	if( [temp  hasPrefix:@"3;"])
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_FAIL_LOCK_MSG];
	else
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	
	processNow = false;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
	[httpRequest release];
	httpRequest= nil;
}

@end
