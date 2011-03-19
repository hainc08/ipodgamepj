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
    
    [viewLayer addAnimation:fadeInAnimation forKey:@"opacity"];
	
	[noticeView setAlpha:0];
	[self GetVersion];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isNoticeCheck)
	{
		
		[self.view setAlpha:0];
	}
}

- (IBAction)buttonClick
{
	[UIView beginAnimations:@"logoAni" context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	
	[noticeView setAlpha:0.f];
	[noticeView setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0)];
	
	[UIView commitAnimations];
		

	
	[self GetMenuList];
}

#pragma mark -
#pragma mark HttpRequestDelegate

- (void)GetVersion
{
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
	NSString *Version=nil;
	if(![result compare:@"error"])
	{
		[self ShowOKCancleAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		Element* t_item = [root getFirstChild];
		Version = [ [t_item getChild:@"VERSION"] getValue];
		NSString *Image = [[t_item getChild:@"IMG_NM"] getValue];
		
		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;
/*
	if( [Version compare:[[DataManager getInstance] getVersion]] != NSOrderedSame )
	{
		[self ShowOKCancleAlert:nil msg:@"버전이 업그레이드 되었습니다. 앱스토어에서 다시 다운받으세요 "];
	}
	else {
		[noticeView setAlpha:1];
	}
 */
	[noticeView setAlpha:1];

}
-(void)GetMenuList
{
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
	if(![result compare:@"error"])
	{
		[self ShowOKCancleAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		if(root != nil)
		{
			deleteFile(@"menu.xml");
			NSFileHandle* accountFile = makeFileToWrite(@"menu.xml");
			if (accountFile != nil)
			{
				writeString(accountFile  ,result);
				closeFile(accountFile);
			}
		}
		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;
	[[DataManager getInstance] loadProduct];

	isNoticeCheck = true;
	
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
	[super alertView:actionSheet clickedButtonAtIndex:buttonIndex];
	
	if(buttonIndex)
	{
		//[[UIApplication sharedApplication] openURL:@"앱 스토어 "];
	}
	else {
		/* 앱종료 */
	}

}
@end
