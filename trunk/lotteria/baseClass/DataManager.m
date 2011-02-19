#import "DataManager.h"
#import "FileIO.h"
#import <sys/time.h>

static DataManager *DataManagerInst;

@implementation ShopItem

@synthesize productIdx;
@synthesize opt1;
@synthesize opt2;
@synthesize count;

@end

@implementation DataManager

@synthesize accountId;
@synthesize accountPass;

+ (DataManager*)getInstance
{
	return DataManagerInst;
}

+ (void)initManager;
{
	DataManagerInst = [DataManager alloc];
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

	
	[self loadProduct];
}

//-------------------장바구니 처리---------------------
- (void)addShopItem:(ShopItem*)item
{
	[ShopKart addObject:item];
}

- (void)removeShopItem:(ShopItem*)item
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
}

- (ProductData*)getBurger:(int)idx
{
	for (ProductData* data in burgerList)
	{
		if (idx == [data productIdx])
		{
			return data;
		}
	}
	
	return nil;
}

- (ProductData*)getChicken:(int)idx
{
	for (ProductData* data in chickenList)
	{
		if (idx == [data productIdx])
		{
			return data;
		}
	}
	
	return nil;
}

- (ProductData*)getDessert:(int)idx
{
	for (ProductData* data in dessertList)
	{
		if (idx == [data productIdx])
		{
			return data;
		}
	}
	
	return nil;
}

- (ProductData*)getDrink:(int)idx
{
	for (ProductData* data in drinkList)
	{
		if (idx == [data productIdx])
		{
			return data;
		}
	}
	
	return nil;
}

- (ProductData*)getPack:(int)idx
{
	for (ProductData* data in packList)
	{
		if (idx == [data productIdx])
		{
			return data;
		}
	}
	
	return nil;
}

@end
