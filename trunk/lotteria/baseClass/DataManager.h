@interface ShopItem : NSObject
{
	int productIdx;
	int opt1, opt2;
	int count;
}

@property (readwrite) int productIdx;
@property (readwrite) int opt1;
@property (readwrite) int opt2;
@property (readwrite) int count;

@end

@interface ProductData : NSObject
{
	int productIdx;
	NSString* name;
}

@property (readwrite) int productIdx;
@property (retain) NSString* name;

@end

@interface DataManager : NSObject
{	
	NSString* accountId;
	NSString* accountPass;

	NSMutableArray* ShopKart;
	
	NSMutableArray* burgerList;
	NSMutableArray* chickenList;
	NSMutableArray* dessertList;
	NSMutableArray* drinkList;
	NSMutableArray* packList;
}

@property (retain) NSString* accountId;
@property (retain) NSString* accountPass;

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

//-------------------장바구니 처리---------------------
- (void)addShopItem:(ShopItem*)item;
- (void)removeShopItem:(ShopItem*)item;
- (NSMutableArray*)getShopKart;

//-------------------상품 정보 처리---------------------
- (void)loadProduct;
- (ProductData*)getBurger:(int)idx;
- (ProductData*)getChicken:(int)idx;
- (ProductData*)getDessert:(int)idx;
- (ProductData*)getDrink:(int)idx;
- (ProductData*)getPack:(int)idx;

@end
