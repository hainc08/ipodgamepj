typedef enum _ImgType
{
	MIDDLE = 0,
	DESC = 1,
	DETAIL = 2,
	NAME = 3,
	SMALL = 4
} ImgType;

@interface ShopItem : NSObject
{
	int productIdx;
	int count;
}

@property (readwrite) int productIdx;
@property (readwrite) int count;

@end

@interface ProductData : NSObject
{
	int productIdx;
	NSString* productKey;
	NSString* name;
	int price;
	
	UIImage* img[5];
}

@property (readwrite) int productIdx;
@property (retain) NSString* productKey;
@property (retain) NSString* name;
@property (readwrite) int price;

- (UIImage*)getProductImg:(ImgType)type;

@end

@interface DataManager : NSObject
{
	bool isLoginNow;
	NSString* accountId;
	NSString* accountPass;

	NSMutableArray* ShopKart;
	
	NSMutableDictionary *productMap;
	
	ProductData* readCache;
}

@property (readonly) bool isLoginNow;
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
- (ProductData*)getProduct:(int)idx;
- (UIImage*)getProductImg:(int)idx type:(ImgType)imgType;

@end
