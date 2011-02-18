

#import "XmlParser.h"

@implementation XmlParser

@synthesize result;
@synthesize currentElementName;
@synthesize currentElementValue;
@synthesize parentArray;

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	result = [[NSMutableDictionary alloc] init];
	parentArray = [[NSMutableArray alloc] init];
	[parentArray addObject:result];
	currentElementName = @"";
}

- (void)dealloc
{
	[result release];
	[currentElementName release];
	[currentElementValue release];
	[parentArray release];
	[super dealloc];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if (qName)
		elementName = qName;
	currentElementValue = @"";
	if (! [currentElementName isEqualToString:@""]) {
		id newParent = NULL;

		if ((NSNotFound != [currentElementName rangeOfString:@"Array"].location) ||	(NSNotFound != [currentElementName rangeOfString:@"List"].location)) {
			newParent = [[NSMutableArray alloc] init];
			//NSLog(@"ARRAY = %@", currentElementName);
		} else {
			newParent = [[NSMutableDictionary alloc] init];
			//NSLog(@"ELEMENT = %@", currentElementName);
		}
		[parentArray addObject:newParent];
	}
	currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
	if (qName) {
		elementName = qName;
	}
	
	if ([currentElementName isEqualToString:@""]) {
		//We're adding a container with children.  Add it to the parent and remove this item fromt he parentArray
		int currentIndex = [parentArray count]-1;
		int parentIndex = currentIndex - 1;
		id currentChild = [parentArray objectAtIndex:currentIndex];
		id currentParent = [parentArray objectAtIndex:parentIndex];
		
		if ([currentParent isKindOfClass:[NSMutableArray class]])
			[currentParent addObject:currentChild];
		else
			[currentParent setObject:currentChild forKey:elementName];
		[parentArray removeObjectAtIndex:currentIndex];
	} else {
		//We're adding a simple type element
		int currentIndex = [parentArray count]-1;
		id currentParent = [parentArray objectAtIndex:currentIndex];
		if ([currentParent isKindOfClass:[NSMutableArray class]]) {
			[currentParent addObject:currentElementValue];
		} else
			[currentParent setObject:currentElementValue forKey:currentElementName];
		//NSLog(@"elementName = %@, %@", currentElementName, currentElementValue);
	}
	currentElementName = @"";
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	currentElementValue = [currentElementValue stringByAppendingString:string];
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
	NSMutableData *decode = [NSMutableData dataWithData:CDATABlock];
	const unsigned char tempcstring = 0;
	[decode appendBytes:&tempcstring length:1];
	NSString *string = [NSString stringWithUTF8String:(const char*)[decode bytes]];
	currentElementValue = string;
}

@end

