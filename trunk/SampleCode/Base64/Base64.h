

#import <Foundation/NSData.h>
#import <Foundation/NSString.h>

@interface NSData (NSDataExtensions)

+ (NSData *)base64DataFromString: (NSString *)string;

@end

#pragma mark -

@interface NSString (NSStringExtensions)

+ (NSString *)base64StringFromData:(NSData *)data;
+ (NSString *)base64StringFromData:(NSData *)data carryReturnLength:(int)carryReturnLength;

@end