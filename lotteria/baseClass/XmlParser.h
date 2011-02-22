#import <Foundation/Foundation.h>

//왜이리 쓰기 불편하게 되어있나? 편하게 바꿔보자!

@interface Element : NSObject
{
	NSString* name;
	Element* parent;
	
	NSString *value;
	NSDictionary* attribute;
	NSMutableArray* childs;
	
	int curIdx;
}

@property (retain) NSString* name;
@property (retain) Element* parent;
@property (retain) NSDictionary* attribute;
@property (retain) NSString *value;

- (void)addChild:(Element*)ele;
- (Element*)getChild:(NSString*)str;
- (Element*)getFirstChild;
- (Element*)getNextChild;
- (int)childCount;

- (NSString*)getAttribute:(NSString*)str;
- (void)clear;
- (NSString*)getValue;

@end

@interface XmlParser : NSObject <NSXMLParserDelegate>
{
	Element *root;
	Element *curElement;
}

- (Element*)getRoot:(NSString*)name;

- (void)parserBundleFile:(NSString*)fname;
- (void)parserUrl:(NSString*)url;
- (void)parserString:(NSString*)string;

- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@end
