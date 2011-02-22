
#import "XmlParser.h"

//-----------------Element-----------------
@implementation Element

@synthesize name;
@synthesize parent;
@synthesize attribute;
@synthesize value;

- (id)init
{
	[super init];
	attribute = [[NSDictionary alloc] init];
	childs = [[NSMutableArray alloc] initWithCapacity:0];
	return self;
}

- (void)addChild:(Element*)ele
{
	[childs addObject:ele];
}

- (Element*)getChild:(NSString*)str
{
	curIdx = 0;
	for(Element* i in childs)
	{
		if ([[i name] compare:str] == NSOrderedSame)
		{
			return i;
		}
		++curIdx;
	}

	return nil;
}


- (Element*)getFirstChild
{
	curIdx = 0;
	return [childs objectAtIndex:curIdx];
}

- (Element*)getNextChild
{
	++curIdx;
	if (curIdx >= [childs count]) return nil;
	return [childs objectAtIndex:curIdx];
}

- (NSString*)getAttribute:(NSString*)str
{
	curIdx = 0;
	return [attribute objectForKey:str];
}
- (NSString*)getValue
{
	return value;
}

- (int)childCount
{
	return [childs count];
}

- (void)dealloc
{
	for(Element* i in childs)
	{
		[i dealloc];
	}
	
	for(id i in attribute)
	{
		[i dealloc];
	}
	
	[attribute release];
	[childs release];
	
	[name release];
	[super dealloc];
}

@end

//-----------------XmlParser-----------------
@implementation XmlParser

- (void)parserBundleFile:(NSString*)fname
{
	NSString* filePath = [NSString stringWithFormat: @"%@/%@",
						  [[NSBundle mainBundle] resourcePath], fname];
	NSData* tempData = [[NSData alloc] initWithContentsOfFile:filePath];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:tempData];
    [parser setDelegate:self];
	
    [parser parse];
	[parser release];
}

- (void)parserUrl:(NSString*)url
{
	NSURL* fileUrl = [NSURL URLWithString:url];
	NSData* tempData = [[NSData alloc] initWithContentsOfURL:fileUrl];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:tempData];
    [parser setDelegate:self];
	
    [parser parse];
	[parser release];
}

- (void)parserString:(NSString*)string
{
	NSData* tempData = [string dataUsingEncoding:NSUTF8StringEncoding];
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:tempData];
    [parser setDelegate:self];
	
    [parser parse];
	[parser release];
}

- (Element*)getRoot:(NSString*)name
{
	return [root getChild:name];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	root = [[[Element alloc] init] retain];
	curElement = root;
}

- (void)dealloc
{
	[root dealloc];
	[super dealloc];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if (qName) elementName = qName;

	Element* ele = [[[Element alloc] init] retain];
	[ele setName:elementName];
	[ele setAttribute:attributeDict];
	[ele setParent:curElement];

	[curElement addChild:ele];
	curElement = ele;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
		[curElement setValue:string];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	curElement = [curElement parent];
}

@end

