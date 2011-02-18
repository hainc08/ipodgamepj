
// 사용된 코드 정리 .. 


+ (NSString *)base64Decode_UTF8:(NSString *)string 
{
	NSMutableData *decode = [NSMutableData dataWithData:[NSData base64DataFromString:string]];
	// 문자열이므로 널 터미네이터를 넣어준다.
	const unsigned char tempcstring = 0;
	[decode appendBytes:&tempcstring length:1];
	return [NSString stringWithUTF8String:(const char*)[decode bytes]];
}

+ (NSString *)base64Encode_UTF8:(NSString *)string
{
	const char *utf8 = [string UTF8String];
	const int len = strlen(utf8);
	NSData *data = [NSData dataWithBytes:utf8 length:len];
	return [NSString base64StringFromData:data];
}

+ (NSString *)urlencode_EUC_KR:(NSString *)string
{
	return [string stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingDOSKorean)];
}	

+ (NSString *)urlencode_UTF8:(NSString *)string
{
	return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}	