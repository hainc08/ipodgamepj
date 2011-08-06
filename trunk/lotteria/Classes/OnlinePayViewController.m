#import "OnlinePayViewController.h"
#import "HttpRequest.h"
#import "XmlParser.h"
#import <time.h>

@implementation OnlinePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveFinished:(NSString *)result
{

}

- (void)showPage:(NSString *)url bodyArray:(NSMutableArray *)bodyarr
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	// URL Request 객체 생성
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SERVERURLWS, url]]
									  cachePolicy:NSURLRequestUseProtocolCachePolicy
								  timeoutInterval:5.0f];
	
	// 통신방식 정의 (POST, GET)
	[request setHTTPMethod:@"POST"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	
	// 값들을 &로 연결하여 Body에 사용
	[request setHTTPBody:[[bodyarr componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];

	[Webview loadRequest:request];
}

@end
