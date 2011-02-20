#import "DataManager.h"
#import "FileIO.h"
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
	//product.txt에 상품 정보를 읽자!!!
	//여기서는 로딩시간 단축을 위해서 ansi C 함수를 이용해서 읽는다.
	productMap = [[NSMutableDictionary alloc] init];
	
	//일단 테스트를 위해서 몇개만 수작업 추가
	ProductData* data[7];

	for (int i=0; i<7; ++i)
	{
		data[i] = [[[ProductData alloc] init] retain];
		[data[i] setProductIdx:i];
		[productMap setObject:data[i] forKey:[NSString stringWithFormat:@"%d", data[i].productIdx]];
	}

	[data[0] setName:@"불갈비버거"];
	[data[0] setProductKey:@"bgb"];

	[data[1] setName:@"불새버거"];
	[data[1] setProductKey:@"bsb"];

	[data[2] setName:@"치킨버거"];
	[data[2] setProductKey:@"cb"];

	[data[3] setName:@"치즈버거"];
	[data[3] setProductKey:@"ch"];

	[data[4] setName:@"유러피안프리코치즈버거"];
	[data[4] setProductKey:@"ecb"];
	
	[data[5] setName:@"자이안트더블버거"];
	[data[5] setProductKey:@"gdb"];
	
	[data[6] setName:@"한우불고기버거"];
	[data[6] setProductKey:@"hbb"];
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
