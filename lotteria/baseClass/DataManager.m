#import "DataManager.h"
#import "FileIO.h"
#import "XmlParser.h"
#import "CartBodyViewController.h"
#import <sys/time.h>

static DataManager *DataManagerInst;

@implementation CartItem

@synthesize menuId;
@synthesize dessertId;
@synthesize drinkId;
@synthesize count;
@synthesize listIdx;
@synthesize StoreMenuOnOff;

@end

//menu_id	menu_dis	CATE_ID	menu_nm	menu_eng_nm	menu_rpt_nm	menu_sdate	menu_edate	price	coupon_sdate	coupon_edate	set_cd	set_menu_cd	set_sale_cd	ori_menu_id	ori_menu_dis	pos_menu_id	pos_menu_dis	use_flag	reg_date	reg_time	upd_date	upd_time
//200199	00	S10	불새버거세트	BULGOGI & SHRIMP BURGER SET	불새세트	20090901	99991231	₩5,200.00			2	200199	00	LB0004	00	2034	00	Y	20110210	213055	20110210	213055
//200807	00	S40	세트콜라(R)	SET COLA(R)	세  트콜라R	20040217	99991231	₩0.00			1	200807	00	200807	00	6128	00	Y	20110210	213055	20110210	213055
//200504	00	S30	세트포테이토	SET POTATO	세트포테이토	20040217	99991231	₩0.00			1	200504	00	200504	00	5142	00	Y	20110210	213055	20110210	213055
//LB0004	00	D10	불새버거	BULGOGI & SHRIMP BURGER	불새버거	20100417	99991231	₩3,500.00			1	LB0004	00	LB0004	00	1267	00	Y	20110210	213055	20110210	213055
//LD0009	00	D40	콜라(R)	COLA(R)	콜  라(R)	20020723	99991231	₩1,600.00			1	LD0009	00	LD0009	00	6122	00	Y	20110210	213055	20110210	213055
//LS0004	00	D30	포테이토	POTATO	포  테이  토	19921123	99991231	₩1,300.00			1	LS0004	00	LS0004	00	5101	00	Y	20110210	213055	20110210	213055

@implementation ProductData

@synthesize menuId;
@synthesize category;
@synthesize key;
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
		NSString* catStr;

		if ([category compare:@"D10"] == NSOrderedSame) catStr = @"bg";
		else if ([category compare:@"D20"] == NSOrderedSame) catStr = @"ck";
		else if ([category compare:@"D30"] == NSOrderedSame) catStr = @"ds";
		else if ([category compare:@"D40"] == NSOrderedSame) catStr = @"dr";
		else if ([category compare:@"D50"] == NSOrderedSame) catStr = @"pk";

		else if ([category compare:@"S30"] == NSOrderedSame) catStr = @"ds";
		else if ([category compare:@"S40"] == NSOrderedSame) catStr = @"dr";
	
		img[0] = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_a.png", catStr, key]];
		img[1] = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_c.png", catStr, key]];
		img[2] = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_l.png", catStr, key]];
		img[3] = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_n.png", catStr, key]];
		img[4] = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_s.png", catStr, key]];
	}
	
	return img[type];
}

@end


@implementation CustomerDelivery

@synthesize custid,seq ,phone ,si , gu;
@synthesize dong,bunji , building ,addrdesc ,branchid;
@synthesize regdate, regtime, upddate, updtime;
@synthesize branchname, branchtime;
- (void)dealloc {
    [custid release];
    [seq release];
    [phone release];
    [si release];
    [gu release];
	[dong release];
    [bunji release];
    [building release];
    [addrdesc release];
    [branchid release];
	[branchname release];
	[branchtime release];
	[regdate release];
    [regtime release];
    [upddate release];
    [updtime release];
	[super dealloc];
}

@end


@implementation OrderUserAddr

@synthesize addrSeq,si , gu;
@synthesize dong,bunji , building ,addrdesc;
@synthesize adong, ldong;

- (void)dealloc {
	[addrSeq release];
    [si release];
    [gu release];
	[dong release];
	[adong release];
	[ldong release];
    [bunji release];
    [building release];
    [addrdesc release];
	
	[super dealloc];
}

@end

@implementation Order 
@synthesize UserName,UserPhone ,OrderType;  
@synthesize OrderMoney, OrderSaleMoney, OrderTotalMoney;
@synthesize OrderTime;
@synthesize UserAddr;	
@synthesize branchid, branchname, branchPhone;
- (void)dealloc {
	[UserName release];
	[UserPhone release];
	[OrderTime release];

	[UserAddr release];
	[branchid release];
	[branchPhone release];
	[branchname release];
	
	[super dealloc];
}

@end


@implementation DataManager

@synthesize cartView;
@synthesize isLoginNow;
@synthesize isLoginSave;
@synthesize accountId;
@synthesize accountPass;
@synthesize UserOrder;

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
	ShopCart = [[NSMutableArray alloc] initWithCapacity:0];

	UserOrder = [[Order alloc] init];
	OrderUserAddr *UserAddr = [[OrderUserAddr alloc] init];
	[UserOrder setUserAddr:UserAddr];
	[UserAddr release];
	
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
	isLoginSave = false;
	cartView = nil;
	
	[self loadProduct];
}

//-------------------장바구니 처리---------------------
- (void)addCartItem:(CartItem*)item
{
	[ShopCart addObject:item];
	[self cartUpdate];
}

- (void)removeCartItem:(CartItem*)item
{
	[ShopCart removeObject:item];
	[self cartUpdate];
}

- (NSMutableArray*)getShopCart
{
	return ShopCart;
}

- (void)cartUpdate
{
	if (cartView != nil)
	{
		[(CartBodyViewController*)cartView update];
	}
}

- (int)itemCount:(int)listIdx
{
	int count = 0;
	
	for (CartItem* item in ShopCart)
	{
		if ([item listIdx] == listIdx)
			++count;
	}
	
	return count;
}

- (CartItem*)getCartItem:(int)idx listIdx:(int)listIdx
{
	for (CartItem* item in ShopCart)
	{
		if ([item listIdx] == listIdx)
		{
			if (idx == 0)
			{
				return item;
			}
			--idx;
		}
	}

	return nil;
}
- (CartItem*)getCartItem:(int)idx
{
	return [ShopCart objectAtIndex:idx];
}

//-------------------상품 정보 처리---------------------
- (void)loadProduct
{
	//product.xml에 상품 정보를 읽자!!!
	{
		XmlParser* parser = [[XmlParser alloc] init];
		[parser parserBundleFile:@"product.xml"];

		setProductMap = [[NSMutableDictionary alloc] init];
		allProductMap = [[NSMutableDictionary alloc] init];
		allProductList = [[NSMutableArray alloc] initWithCapacity:0];

		Element* root = [parser getRoot:@"Products"];
		Element* product = [root getFirstChild];

		while (product)
		{
			if ([[product getAttribute:@"use_flag"] compare:@"Y"] == NSOrderedSame)
			{
				ProductData* data = [[[ProductData alloc] init] retain];
				
				[data setMenuId:[NSString stringWithString:[product getAttribute:@"menu_id"]]];
				[data setName:[NSString stringWithString:[product getAttribute:@"menu_nm"]]];
				[data setCategory:[NSString stringWithString:[product getAttribute:@"CATE_ID"]]];
				[data setPrice:[[product getAttribute:@"price"] intValue]];
				
				//세트는 따로 분류해 놓자...
				//세트는 key에 단품코드가 들어간다.
				if (([[data category] compare:@"S10"] == NSOrderedSame)||
					([[data category] compare:@"S11"] == NSOrderedSame))
				{
					[data setKey:[NSString stringWithString:[product getAttribute:@"ori_menu_id"]]];
					[setProductMap setObject:data forKey:[data key]];
				}
				
				[allProductMap setObject:data forKey:[data menuId]];
				[allProductList addObject:data];
				
				product = [root getNextChild];
			}
		}

		[parser dealloc];
	}
	
	//productKey.xml에서 상품별 구분키를 읽자!!
	//이건 실제 DB에 없는데이터이기 때문에 별도로 관리한다.
	{
		XmlParser* parser = [[XmlParser alloc] init];
		[parser parserBundleFile:@"productKey.xml"];

		Element* root = [parser getRoot:@"Products"];
		Element* product = [root getFirstChild];
		
		while (product)
		{
			//세트는 별도의 이미지가 없으니 무시...
			ProductData* data = [self getProduct:[product getAttribute:@"menu_id"]];
			if (data)
			{
				[data setKey:[NSString stringWithString:[product getAttribute:@"key"]]];
			}

			product = [root getNextChild];
		}

		[parser dealloc];
	}
}

- (ProductData*)getProduct:(NSString*)menuId
{
	return [allProductMap objectForKey:menuId];
}

- (NSString*)getSetId:(NSString*)menuId
{
	return [[setProductMap objectForKey:menuId] menuId];
}

- (UIImage*)getProductImg:(NSString*)menuId type:(ImgType)imgType
{
	return [[self getProduct:menuId] getProductImg:imgType];
}

- (NSMutableArray*)getProductArray:(NSString*)category
{
	NSMutableArray* array = [[[NSMutableArray alloc] initWithCapacity:0] retain];
	for (ProductData* data in allProductList)
	{
		if ([[data category] compare:category] == NSOrderedSame)
		{
			[array addObject:data];
		}
	}
	return array;
}

- (NSString*)getPriceStr:(int)value
{
	if (value == 0) return @"0";

	char temp[64];
	temp[63] = 0x00;

	int idx = 63;
	while (value != 0)
	{
		--idx;
		temp[idx] = '0' + value%10;

		if ((60 - idx)%4 == 0)
		{
			--idx;
			temp[idx] = ',';
		}

		value = (int)(value / 10);
	}
	
	return [NSString stringWithFormat:@"%s", &temp[idx]];
}

- (int)getCartPrice
{
	int totPrice = 0;

	for (CartItem* data in ShopCart)
	{
		totPrice += [data count] * [[self getProduct:[data menuId]] price];
		if ([data dessertId] != nil)
			totPrice += [data count] * [[self getProduct:[data dessertId]] price];
		if ([data drinkId] != nil)
			totPrice += [data count] * [[self getProduct:[data drinkId]] price];
	}
	
	return totPrice;
}

- (ProductData*)getSearchProduct:(int)idx listIdx:(int)lIdx
{
	for (ProductData* data in searchResult[lIdx])
	{
		if (idx == 0) return data;
		--idx;
	}
	
	return nil;
}

- (int)getSearchProductCount:(int)lIdx
{
	return [searchResult[lIdx] count];
}

- (void)searchProduct:(NSString*)str
{
	for (int i=0; i<5; ++i)
	{
		if (searchResult[i] != nil) [searchResult[i] removeAllObjects];
		else searchResult[i] = [[NSMutableArray alloc] initWithCapacity:0];
	}
	
	if ([str compare:@""] == NSOrderedSame)
	{
		for (ProductData* data in allProductList)
		{
			if ([[data category] compare:@"D10"] == NSOrderedSame) [searchResult[0] addObject:data];
			else if ([[data category] compare:@"D20"] == NSOrderedSame) [searchResult[1] addObject:data];
			else if ([[data category] compare:@"D40"] == NSOrderedSame) [searchResult[2] addObject:data];
			else if ([[data category] compare:@"D30"] == NSOrderedSame) [searchResult[3] addObject:data];
			else if ([[data category] compare:@"D50"] == NSOrderedSame) [searchResult[4] addObject:data];
		}
	}
	else
	{
		for (ProductData* data in allProductList)
		{
			NSRange range = [[data name] rangeOfString:str];
			if (range.location != NSNotFound)
			{
				if ([[data category] compare:@"D10"] == NSOrderedSame) [searchResult[0] addObject:data];
				else if ([[data category] compare:@"D20"] == NSOrderedSame) [searchResult[1] addObject:data];
				else if ([[data category] compare:@"D40"] == NSOrderedSame) [searchResult[2] addObject:data];
				else if ([[data category] compare:@"D30"] == NSOrderedSame) [searchResult[3] addObject:data];
				else if ([[data category] compare:@"D50"] == NSOrderedSame) [searchResult[4] addObject:data];
			}
		}
	}
}

@end
