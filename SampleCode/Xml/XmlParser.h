
#import <Foundation/Foundation.h>

@interface XmlParser : NSObject 
{
	NSMutableDictionary *result;
	NSString *currentElementName;
	NSString *currentElementValue;
	NSMutableArray *parentArray;
}

@property (nonatomic, retain) NSMutableDictionary *result;
@property (nonatomic, retain) NSString *currentElementName;
@property (nonatomic, retain) NSString *currentElementValue;
@property (nonatomic, retain) NSMutableArray *parentArray;

- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
