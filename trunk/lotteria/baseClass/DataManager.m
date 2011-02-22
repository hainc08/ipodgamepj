#import "DataManager.h"
#import "FileIO.h"
#import "XmlParser.h"
#import <sys/time.h>

static DataManager *DataManagerInst;

@implementation CartItem

@synthesize productIdx;
@synthesize drinkIdx;
@synthesize dessertIdx;
@synthesize count;

@end

@implementation ProductData

@synthesize productIdx;
@synthesize productKey;
@synthesize name;
@synthesize price;

- (id)init
{
	img[0] = img[1] = img[2] = img[3] = img[4] = nil;
	return [super init];
}

- (UIImage*)getProductImg:(ImgType)type
{
	if (img[0] == nil)
	{
		img[0] = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@_a.png", productKey]];
		img[1] = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@_c.png", productKey]];
		img[2] = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@_l.png", productKey]];
		img[3] = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@_n.png", productKey]];
		img[4] = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%@_s.png", productKey]];
	}
	
	return img[type];
}

@end


@implementation DataManager

@synthesize isLoginNow;
@synthesize accountId;
@synthesize accountPass;

+ (DataManager*)getInstance
{
	return DataManagerInst;
}

+ (void)initManager;
{
	DataManagerInst = [DataManager alloc];
	[DataManagerInst reset];
}

- (void)closeManager
{

}

- (void)reset
{
	ShopKart = [[NSMutableArray alloc] initWithCapacity:0];

	//account.txt에서 계정정보를 읽어오자
	NSFileHandle* accountFile = openFileToRead(@"account.txt");
	if (accountFile == nil)
	{
		accountId = @"";
		accountPass = @"";
	}
	else
	{
		accountId = [readString(accountFile) retain];
		accountPass = [readString(accountFile) retain];
		
		closeFile(accountFile);
	}

	isLoginNow = false;
	readCache = nil;
	
	[self loadProduct];
}

//-------------------장바구니 처리---------------------
- (void)addCartItem:(CartItem*)item
{
	[ShopKart addObject:item];
}

- (void)removeCartItem:(CartItem*)item
{
	[ShopKart removeObject:item];
}

- (NSMutableArray*)getShopKart
{
	return ShopKart;
}

//-------------------상품 정보 처리---------------------
- (void)loadProduct
{
	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserBundleFile:@"product.xml"];

	//product.xml에 상품 정보를 읽자!!!
	productMap = [[NSMutableDictionary alloc] init];
	
	Element* root = [xmlParser getRoot:@"Products"];
	Element* product = [root getFirstChild];

	while (product)
	{
		ProductData* data = [[[ProductData alloc] init] retain];

		[data setProductIdx:[[product getAttribute:@"id"] intValue]];
		[data setName:[product getAttribute:@"name"]];
		[data setProductKey:[product getAttribute:@"key"]];

		[productMap setObject:data forKey:[product getAttribute:@"id"]];
		
		product = [root getNextChild];
	}
}

- (ProductData*)getProduct:(int)idx
{
	if ((readCache != nil)&&([readCache productIdx] == idx))
	{
		return readCache;
	}
	
	readCache = [productMap objectForKey:[NSString stringWithFormat:@"%d", idx]];
	
	return readCache;
}

- (UIImage*)getProductImg:(int)idx type:(ImgType)imgType
{
	return [[self getProduct:idx] getProductImg:imgType];
}

@end
