
#import <Foundation/Foundation.h>


@interface HTTPRequest : NSObject
{
	NSMutableData *receivedData;
	NSURLResponse *response;
	NSString *result;
	id target;
	SEL selector;
}
			/* URL 정보는 " /파일명/FUNC " 만을 받는다. */
- (BOOL)requestUrl:(NSString *)url bodyObject:(NSDictionary *)bodyObject   bodyArray:(NSMutableArray *)bodyarr;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)setDelegate:(id)aTarget selector:(SEL)aSelector;

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic, assign) NSString *result;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

@end

