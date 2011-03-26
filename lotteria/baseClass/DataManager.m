#import "DataManager.h"
#import "FileIO.h"
#import "XmlParser.h"
#import "CartBodyViewController.h"
#import "MainViewController.h"
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
@synthesize menuDIS;
@synthesize category;
@synthesize key;
@synthesize origin;
@synthesize name;
@synthesize price;
@synthesize menucomment;
@synthesize set_flag;
@synthesize new_flag;
@synthesize kcal;

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
		
		if ([category compare:@"S10"] == NSOrderedSame) catStr = @"st";
		else if ([category compare:@"D10"] == NSOrderedSame) catStr = @"bg";
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

@implementation StoreInfo
@synthesize storeid, storename, storephone;
@synthesize	store_flag, si , gu;
@synthesize dong,bunji , building ,addrdesc;
@synthesize coordinate;

- (NSString*)getAddressStr
{
	return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", 
			(si ? si:@""), (si ? @" ":@""),
			(gu ? si:@""), (gu ? @" ":@""),
			(dong ? dong:@""), (dong ? @" ":@""),
			(bunji ? bunji:@""), (bunji ? @" ":@""),
			(building ? building:@""), (building ? @" ":@""),
			(addrdesc ? addrdesc:@"")];
}

- (void)dealloc {
	[storeid release];
	[storename release];
	[storephone release];
	
    [si release];
    [gu release];
	[dong release];
    [bunji release];
    [building release];
    [addrdesc release];

	[super dealloc];
}

@end


@implementation DeliveryAddrInfo

@synthesize Seq, phone ,si , gu;
@synthesize dong,bunji , building ,addrdesc ,branchid;
@synthesize branchname, gis_x, gis_y;
@synthesize branchtel, terminal_id, business_date;
@synthesize opendate, closedate;
@synthesize deliverytime;
- (NSString*)getAddressStr
{
	return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", 
						(si ? si:@""), (si ? @" ":@""),
						(gu ? si:@""), (gu ? @" ":@""),
						(dong ? dong:@""), (dong ? @" ":@""),
						(bunji ? bunji:@""), (bunji ? @" ":@""),
						(building ? building:@""), (building ? @" ":@""),
						(addrdesc ? addrdesc:@"")];
}

- (void)dealloc {
	if(Seq)				[Seq release];
    if(phone)			[phone release];
    if(si)				[si release];
    if(gu)				[gu release];
	if(dong)			[dong release];
    if(bunji)			[bunji release];
    if(building)		[building release];
    if(addrdesc)		[addrdesc release];
    if(branchid)		[branchid release];
	if(branchname)		[branchname release];
	if(gis_x)			[gis_x release];
	if(gis_y)			[gis_y	release];
	if(branchtel)		[branchtel release];
	if(terminal_id)		[terminal_id release];
	if(business_date)	[business_date release];
	if(deliverytime)	[deliverytime release];
	[super dealloc];
}

@end

@implementation Order 
@synthesize UserName,UserPhone ,OrderType;  
@synthesize OrderMoney, OrderSaleMoney;
@synthesize OrderTime, OrderMemo;
@synthesize UserAddr;

- (void)dealloc {
	if(UserName)	[UserName release];
	if(UserPhone)	[UserPhone release];
	if(OrderTime)	[OrderTime release];
	if(OrderMemo)	[OrderMemo release];
	
	if(UserAddr)	[UserAddr release];

	[super dealloc];
}

@end


@implementation DataManager

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
	DeliveryAddrInfo *UserAddr = [[DeliveryAddrInfo alloc] init];
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
		isLoginSave  = readInt(accountFile) ? true :false;
		accountId	= [readString(accountFile) retain];
		accountPass = [readString(accountFile) retain];
		
		closeFile(accountFile);
	}

	isLoginNow = false;
	

}

- (void)LoginSave
{
	NSFileHandle* accountFile = makeFileToWrite(@"account.txt");
	if (accountFile != nil)
	{
		writeInt(accountFile, isLoginSave ? 1 : 0);
		writeString(accountFile  ,accountId);
		writeString(accountFile  ,accountPass);
		closeFile(accountFile);
	}
}

//-------------------장바구니 처리---------------------
- (void)addCartItem:(CartItem*)item
{
	item.StoreMenuOnOff = true;
	
	if ([[[self getProduct:[item menuId]] category] compare:@"S10"] != NSOrderedSame)
	{
		for (CartItem* i in ShopCart)
		{
			if (([[i menuId] compare:[item menuId]] == NSOrderedSame)&&
				([[i drinkId] compare:[item drinkId]] == NSOrderedSame)&&
				([[i dessertId] compare:[item dessertId]] == NSOrderedSame))
			{
				[i setCount:[item count] + [i count]];
				[[ViewManager getInstance] cartUpdate];
				return;
			}
		}
	}

	[ShopCart addObject:item];
	[[ViewManager getInstance] cartUpdate];
}

- (void)removeCartItem:(CartItem*)item
{
	[ShopCart removeObject:item];
	[[ViewManager getInstance] cartUpdate];
}
- (void)allremoveCartItem
{
	[ShopCart removeAllObjects];
	[[ViewManager getInstance] cartUpdate];
}

- (NSMutableArray*)getShopCart
{
	return ShopCart;
}

- (int)itemCount:(int)listIdx
{
	if (listIdx == -1) return [ShopCart count];

	int count = 0;
	
	for (CartItem* item in ShopCart)
	{
		if ([item listIdx] == listIdx)
			++count;
	}
	
	return count;
}

- (int)itemAllCount
{
	int count = 0;
	
	for (CartItem* item in ShopCart)
	{
		count += [item count];
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
- (void)updateCartMenuStatus:(NSString *)menu_id dis:(NSString *)menu_dis flag:(bool)Flag
{
	for (CartItem* item in ShopCart)
	{
		if ( ([item.menuId compare:menu_id] == NSOrderedSame ) || 
			( [item.drinkId compare:menu_id] == NSOrderedSame ) || 
			( [item.dessertId compare:menu_id] == NSOrderedSame ))
		{
			if (item.StoreMenuOnOff) item.StoreMenuOnOff = Flag;	
		}
	}
}

- (bool)checkBurgerCount:(int)addCount
{
	int count = 0;
	for (CartItem* i in ShopCart)
	{
		NSString* category = [[self getProduct:[i menuId]] category];
		if (([category compare:@"D10"] == NSOrderedSame)||
			([category compare:@"S10"] == NSOrderedSame))
		{
			count += [i count];
		}
	}
	
	return ((addCount + count) <= MAX_BURGER);
}

//-------------------상품 정보 처리---------------------
/*
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
 */

- (bool)loadProduct
{
	//product.xml에 상품 정보를 읽자!!!
	{
		NSString *readxml = nil;
		NSFileHandle *readfile =  openFileToRead(@"menu.xml");
		
		if(readfile)
		{
			readxml = readString(readfile);
			closeFile(readfile);
		}
		
		XmlParser* parser = [[XmlParser alloc] init];
		[parser parserString:readxml];
		
		setProductMap = [[NSMutableDictionary alloc] init];
		allProductMap = [[NSMutableDictionary alloc] init];
		allProductList = [[NSMutableArray alloc] initWithCapacity:0];
		
		Element* root = [parser getRoot:@"NewDataSet"];
		Element* product = [root getFirstChild];
		
		while (product)
		{
	
			ProductData* data = [[[ProductData alloc] init] retain];
				
			[data setMenuId:[NSString stringWithString:[[product getChild:@"MENU_ID"] getValue]]];
			[data setMenuDIS:[NSString stringWithString:[[product getChild:@"MENU_DIS"] getValue]]];
			
			[data setName:[NSString stringWithString:[[product getChild:@"MENU_NM"]  getValue]]];
			[data setCategory:[NSString stringWithString:[[product getChild:@"CATE_ID"] getValue]]];
			
			Element *tmp = [product getChild:@"KCAL"];	// 없는 제품이 있음.. 
			if(tmp)
				[data setKcal:[NSString stringWithString:[[product getChild:@"KCAL"] getValue]]];
			else 
				[data	 setKcal:@"0"];
			
			[data setMenucomment:[NSString stringWithString:[[product getChild:@"MENU_EXPLAIN"] getValue]]];
			
			// 세트 플레그 3번은 장남감 
			[data setSet_flag:[NSString stringWithString:[[product getChild:@"SET_FLAG"] getValue]]];	
			[data setNew_flag: ( [[[product getChild:@"NEW_FLAG"] getValue] compare:@"Y"] == NSOrderedSame) ? TRUE : FALSE ];

			[data setPrice:[[[product getChild:@"PRICE"] getValue] intValue]];
				
			//세트는 따로 분류해 놓자...
			//세트는 origin에 단품코드가 들어간다.
			if (([[data category] compare:@"S10"] == NSOrderedSame)||
				([[data category] compare:@"S11"] == NSOrderedSame))
			{
				//장난감세트는 세트맵에는 넣지 않는다.
				//그냥 버거에서 세트ID를 찾을 때 꼬이기 때문에...
				if ([[data set_flag] intValue] != 3)
				{
					tmp = [product getChild:@"ORI_MENU_ID"];
					if(tmp)
					{
						[data setOrigin:[NSString stringWithString:[tmp getValue]]];
						[setProductMap setObject:data forKey:[data origin]];
					}
				}
			}
				
			[allProductMap setObject:data forKey:[data menuId]];
			[allProductList addObject:data];

			product = [root getNextChild];
		}
		
		[parser dealloc];
	}
	
	//읽어들인 제품의 정보가 10개 미만이면 잘못 읽은 것이니 다시 읽어보자...
	if ([allProductList count] < 10) return false;
	
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
			UIImage* img = [data getProductImg:0];
		}
		
		[parser dealloc];
	}
	
	return true;
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
	
	//햄버거의 경우 세트중에 장난감도 찾는다...(이뭐...)
	if ([category compare:@"D10"] == NSOrderedSame)
	{
		for (ProductData* data in allProductList)
		{
			if (([[data category] compare:@"S10"] == NSOrderedSame) &&
				([[data set_flag] intValue] == 3))
			{
				[array addObject:data];
			}
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

		value = (int)(value / 10);
		
		if ((value != 0) && ((60 - idx)%4 == 0))
		{
			--idx;
			temp[idx] = ',';
		}
	}
	
	return [NSString stringWithFormat:@"%s", &temp[idx]];
}
/* 장난감 세트에 가격에는 1500 원이 합한 가격이 나온다 .. 음.. 가격은 우선 전부 더해서 보여주고 조정하자  */
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

/* 메뉴중에 장난감 세트일 경우 */
- (int)getCartSalePrice
{
	int totSalePrice = 0;
	
	for (CartItem* data in ShopCart)
	{
		if( [[[self getProduct:[data menuId]] set_flag] compare:@"3"] == NSOrderedSame )
			totSalePrice += [data count] * 1500;
	}
	
	return totSalePrice;
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

- (NSString*)getCategoryName:(NSString*)cat
{
	if ([cat compare:@"D10"] == NSOrderedSame) return @"햄버거";
	if ([cat compare:@"D20"] == NSOrderedSame) return @"치킨";
	if ([cat compare:@"D30"] == NSOrderedSame) return @"디저트";
	if ([cat compare:@"D40"] == NSOrderedSame) return @"음료";
	if ([cat compare:@"D50"] == NSOrderedSame) return @"팩";

	if ([cat compare:@"S10"] == NSOrderedSame) return @"햄버거세트";
	if ([cat compare:@"S11"] == NSOrderedSame) return @"콤보";

	return nil;		// 엉뚱한값이면 
}

- (NSString*)getPhoneStr:(NSString*)PhoneNumber
{
	if(PhoneNumber ==nil || [ PhoneNumber length] < 9) return @"";
	
	NSString* p_tmp;
	int len = [PhoneNumber length];
	int t = 3;
	
	//길이가 7자보다 적거나, 스트링안에 "-"가 있는 경우에는 그냥 리턴한다. ( DB에는모든값에 - 는없음..
	//if (([PhoneNumber rangeOfString:@"-"].length == 0) || (len < 7)) return PhoneNumber;

	if ([PhoneNumber hasPrefix:@"02"]) t = 2;
		  
	p_tmp = [NSString stringWithFormat:@"%@-%@-%@",
			 [PhoneNumber substringWithRange:NSMakeRange(0, t)],
			 [PhoneNumber substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [PhoneNumber substringWithRange:NSMakeRange(len - 4, 4)]]; 
	
	return p_tmp;
}
@end
