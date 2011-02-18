

#import "Base64.h"

/* Base64 Encoding Table */
static char base64EncodingTable[64] = {
'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

@implementation NSData (NSDataExtensions)

+ (NSData *)base64DataFromString:(NSString *)string
{
	unsigned long ixtext, lentext;
	unsigned char ch, inbuf[4], outbuf[3];
	short i, ixinbuf;
	Boolean flignore, flendtext = false;
	const unsigned char *tempcstring;
	NSMutableData *theData;
	
	if (string == nil) {
		return [NSData data];
	}
	
	ixtext = 0;
	tempcstring = (const unsigned char *)[string UTF8String];
	//tempcstring = [string UTF8String];
	lentext = [string length];
	theData = [NSMutableData dataWithCapacity: lentext];
	ixinbuf = 0;
	
	while (true)
	{
		if (ixtext >= lentext)
			break;
		ch = tempcstring[ixtext++];
		flignore = false;
		if ((ch >= 'A') && (ch <= 'Z'))	{
			ch = ch - 'A';
		} else if ((ch >= 'a') && (ch <= 'z')) {
			ch = ch - 'a' + 26;
		} else if ((ch >= '0') && (ch <= '9')) {
			ch = ch - '0' + 52;
		} else if (ch == '+') {
			ch = 62;
		} else if (ch == '=') {
			flendtext = true;
		} else if (ch == '/') {
			ch = 63;
		} else {
			flignore = true; 
		}
		if (!flignore) {
			short ctcharsinbuf = 3;
			Boolean flbreak = false;
			
			if (flendtext) {
				if (ixinbuf == 0) {
					break;
				}
				
				if ((ixinbuf == 1) || (ixinbuf == 2)) {
					ctcharsinbuf = 1;
				} else {
					ctcharsinbuf = 2;
				}
				ixinbuf = 3;
				flbreak = true;
			}
			
			inbuf[ixinbuf++] = ch;
			if (ixinbuf == 4) {
				ixinbuf = 0;
				outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
				outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
				outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
				for (i=0; i<ctcharsinbuf; i++) {
					[theData appendBytes: &outbuf[i] length: 1];
				}
			}
			
			if (flbreak) {
				break;
			}
		} else {
			NSLog(@"it's not base64");
		}
	}
	return theData;
}

@end

#pragma mark -

@implementation NSString (NSStringExtensions)

+ (NSString *)base64StringFromData:(NSData *)data
{
	return [NSString base64StringFromData:data carryReturnLength:0];
}

+ (NSString *)base64StringFromData: (NSData *)data carryReturnLength:(int)carryReturnLength
{
	unsigned long ixtext, lentext;
	long ctremaining;
	unsigned char inbuf [3], outbuf [4];
	short i, charsonline = 0, ctcopy;
	const unsigned char *raw;
	NSMutableString *theString;
    
	lentext = [data length];
	
	if (lentext < 1) {
		return @"";
	}
	
 	theString = [NSMutableString stringWithCapacity: lentext];
 	
 	raw = [data bytes];
	
	ixtext = 0; 
 	
	while (true) {
		ctremaining = lentext - ixtext;
		
		if (ctremaining <= 0) {
			break;
		}
		
		for (i = 0; i < 3; i++) { 
			unsigned long ix = ixtext + i;
			
			if (ix < lentext) {
				inbuf [i] = raw [ix];
			}
			else {
				inbuf [i] = 0;
			}
		}
		
		outbuf[0] = (inbuf[0] & 0xFC) >> 2;
		outbuf[1] = ((inbuf[0] & 0x03) << 4) | ((inbuf[1] & 0xF0) >> 4);
		outbuf[2] = ((inbuf[1] & 0x0F) << 2) | ((inbuf[2] & 0xC0) >> 6);
		outbuf[3] = inbuf[2] & 0x3F;
		
		ctcopy = 4;
		
		switch (ctremaining) {
			case 1: 
				ctcopy = 2; 
				break;
			case 2: 
				ctcopy = 3; 
				break;
		}
		
		for (i = 0; i < ctcopy; i++) {
			NSString *s = [[NSString alloc] initWithFormat:@"%c", base64EncodingTable[outbuf[i]]];
			[theString appendString:s];
			[s release];
		}
		
		for (i = ctcopy; i < 4; i++) {
			[theString appendString: @"="];
		}
		
		ixtext += 3;
		charsonline += 4;
		
		if (0 < carryReturnLength) {
			if (charsonline >= carryReturnLength) {
				charsonline = 0;
				[theString appendString: @"\n"];
			}
		}
	}
	
	return theString;
}

@end