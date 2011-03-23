#import "LogoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HttpRequest.h"
#import "XmlParser.h"
#import "FileIO.h"
#import "DataManager.h"
#define kAnimationDuration  0.25

@implementation LogoViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	isNoticeCheck = false;
	[noticeView setAlpha:0.f];
	doneStep = 0;
	[self GetVersion];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isNoticeCheck)
	{
		[self.view setAlpha:0];
	}
}

- (void)loadingDone
{
	CALayer *viewLayer = noticeView.layer;
    CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    popInAnimation.duration = kAnimationDuration;
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.1],
							 [NSNumber numberWithFloat:.9],
							 [NSNumber numberWithFloat:1],
                             nil];
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0],
							   [NSNumber numberWithFloat:1.1],
							   [NSNumber numberWithFloat:1.2],
                               nil];    
    popInAnimation.delegate = nil;
    
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];  
	
    CAKeyframeAnimation* fadeInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    fadeInAnimation.duration = kAnimationDuration;
    fadeInAnimation.values = [NSArray arrayWithObjects:
							  [NSNumber numberWithFloat:0.0],
							  [NSNumber numberWithFloat:1],
							  nil];
    fadeInAnimation.keyTimes = [NSArray arrayWithObjects:
								[NSNumber numberWithFloat:0.0],
								[NSNumber numberWithFloat:1],
								nil];    
    fadeInAnimation.delegate = nil;
    
	[noticeView setAlpha:1.f];
    [viewLayer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (IBAction)buttonClick
{
	[UIView beginAnimations:@"logoAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	[noticeView setAlpha:0.f];
	[noticeView setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0)];
	
	[UIView commitAnimations];

	isNoticeCheck = true;


}

#pragma mark -
#pragma mark HttpRequestDelegate

- (void)GetVersion
{
	[loadingNow setAlpha:1];
	[loadingNow startAnimating];

	httpRequest = [[HTTPRequest alloc] init];
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"3",@"cust_flag",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbVersion.asmx/ws_getVersionXml" bodyObject:bodyObject bodyArray:nil];
}

- (void)didReceiveFinished:(NSString *)result
{
	[loadingNow stopAnimating];
	[loadingNow setAlpha:0];

	NSString *Version=nil;
	NSString *Image;
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"연결 에러" msg:@"서버에서 메뉴정보를 읽는데 실패하였습니다."];	
		return;
	}
	else 
	{
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		Element* t_item = [root getFirstChild];
		Version = [ [t_item getChild:@"VERSION"] getValue];
		Image= [[t_item getChild:@"IMG_NM"] getValue];
		
		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;

	doneStep = 1;
/*
	if( [Version compare:[[DataManager getInstance] getVersion]] != NSOrderedSame )
	{
		[self ShowOKCancleAlert:nil msg:@"버전이 업그레이드 되었습니다. 앱스토어에서 다시 다운받으세요 "];
	}
	else {
		[self loadingDone];
	}
 */
	NSString *remoteImagePath = [NSString stringWithFormat:@"%@/iphone/notice/%@",SERVERURL,Image];
	UIImage *localImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:remoteImagePath]]];
	[noticeImg setImage:localImage];
	[localImage release];
	[self loadingDone];

	[self GetMenuList];
}

-(void)GetMenuList
{

	[loadingNow setAlpha:1];
	[loadingNow startAnimating];

	httpRequest = [[HTTPRequest alloc] init];
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								@"",@"menu_nm",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didMenuReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbMenu.asmx/ws_getMenuXml" bodyObject:bodyObject bodyArray:nil];
}

- (void)didMenuReceiveFinished:(NSString *)result
{
	[loadingNow stopAnimating];
	[loadingNow setAlpha:0];

	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"연결 에러" msg:@"서버에서 버전 정보를 읽는데 실패하였습니다."];
		return;
	}
	else 
	{
		//혹여나 과거정보가 틀린 경우도 있으니
		//일단 무조건 과거정보는 지운다.
		deleteFile(@"menu.xml");

		NSFileHandle* accountFile = makeFileToWrite(@"menu.xml");
		if (accountFile != nil)
		{
			writeString(accountFile  ,result);
			closeFile(accountFile);
		}
	}
	[httpRequest release];
	httpRequest = nil;
	if ([[DataManager getInstance] loadProduct])
	{
		doneStep = 2;
		[self loadingDone];
		return;
	}
	[loadingNow stopAnimating];
	[loadingNow setAlpha:0.f];
	//혹여나 잘못된 정보가 넘어오는 경우 다시시도하게 한다.
	[self ShowOKAlert:@"연결 에러" msg:@"서버에서 메뉴정보를 읽는데 실패하였습니다."];	
}
#pragma mark -
#pragma mark AlertView

- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		//다시시도...
		if (doneStep == 0) [self GetVersion];
		else if (doneStep == 1) [self GetMenuList];
	}
}

- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:nil otherButtonTitles:@"다시시도", nil];
	[alert show];
	[alert release];
}
@end
