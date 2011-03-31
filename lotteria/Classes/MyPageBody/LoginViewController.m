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

	processNow = true;

	NSURL *url = [NSURL URLWithString: @"http://homeservice.lotteria.com/Auth/mblogin.asp"];
	NSString *body = [NSString stringWithFormat: @"cust_id=%@&cust_pwd=%@&cust_flag=3", ID.text, Password.text];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
	
	[request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
	[webView loadRequest: request];
	[webView setDelegate: self];
	
	[loadingNow setAlpha:1];
	[loadingNow startAnimating];

	finishCount = 0;
}

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
	response = aResponse;
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// 데이터를 전송받는 도중에 호출되는 메서드, 여러번에 나누어 호출될 수 있으므로 appendData를 사용한다.
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	[[ViewManager getInstance] waitview:self.view isBlock:NO];
	[receivedData release];
	processNow = false;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
	[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// 데이터 전송이 끝났을 때 호출되는 메서드, 전송받은 데이터를 NSString형태로 변환한다.
	result = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	[receivedData release];
	[self  didReceiveFinished:result];
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

	[ID resignFirstResponder];
	[Password resignFirstResponder];
	
	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserString:result];
	Element* root = [xmlParser getRoot:@"NewDataSet"];
		
	if (root == nil || [[[root getChild:@"RESULT_CODE"] getValue] compare:@"Y"] != NSOrderedSame )
	{
		[self ShowOKAlert:ERROR_TITLE msg:LOGIN_FAIL_MSG];
		goto LOGIN_FAIL;
	}
	else
	{
		NSString *Cust_ID =  [[root getChild:@"CUST_ID"] getValue] ;
		NSString *Cust_PHONE =  [[root getChild:@"CUST_PHONE"] getValue] ;
		[[DataManager getInstance] setCust_id:Cust_ID];
		[[DataManager getInstance] setCust_phone:Cust_PHONE];
	}
		
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
		
	[[DataManager getInstance] setIsLoginNow:TRUE];
	[[ViewManager getInstance] closePopUp];

LOGIN_FAIL:
	[xmlParser release];
	processNow = false;
	[loadingNow setAlpha:0];
	[loadingNow stopAnimating];
}

@end
