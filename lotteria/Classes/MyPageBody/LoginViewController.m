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


@implementation LoginViewController
@synthesize LoginNextType;
- (void)viewDidLoad {
	naviImgIdx = 0;

    [super viewDidLoad];
	
	ID.returnKeyType = UIReturnKeyDone;
	Password.returnKeyType = UIReturnKeyDone;
	ID.delegate = self;
	Password.delegate = self;
	self.navigationItem.title = @"로그인";
	[self reset];
	httpRequest = [[HTTPRequest alloc] init];
}

- (void)viewDidUnload {
	if(httpRequest){
		[httpRequest release];
		httpRequest = nil;
    }
	[super viewDidUnload];
}


- (void)dealloc {
	if(httpRequest){
		[httpRequest release];
		httpRequest = nil;
    }
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
- (IBAction)LoginButton 
{

	// Login 하자..
	if([ID.text length] >  10 || [ID.text length] < 4 )
	{
		[self ShowOKAlert:@"Login Error" msg:@"Login ID 가 10자 이상입니다."];
		return;
	}
	
	if([Password.text length] >  12)
	{
		[self ShowOKAlert:@"Login Error" msg:@"Password 가 12자 이상입니다."];
		return;
	}
		// 접속할 주소 설정
	NSString *url = @"http://www.naver.com";
	
	// HTTP Request 인스턴스 생성

	
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								ID.text,@"cust_id",
								Password.text, @"cust_passwd",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:url bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view isBlock:YES];
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

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	
	/*if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Login Error" msg:@"로그인에 실패 했습니다."];	
	}
	else */{
		
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
	[[ViewManager getInstance] waitview:self.view isBlock:NO];
	[[ViewManager getInstance] closePopUp];
}

@end
