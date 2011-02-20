typedef enum _ImgType
{
	MIDDLE = 0,
	DESC = 1,
	DETAIL = 2,
	NAME = 3,
	SMALL = 4
} ImgType;

@interface CartItem : NSObject
{
	int productIdx;
	int drinkIdx;
	int dessertIdx;
	int count;
}

@property (readwrite) int productIdx;
@property (readwrite) int drinkIdx;
@property (readwrite) int dessertIdx;
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
- (void)addCartItem:(CartItem*)item;
- (void)removeCartItem:(CartItem*)item;
- (NSMutableArray*)getShopKart;

//-------------------상품 정보 처리---------------------
- (void)loadProduct;
- (ProductData*)getProduct:(int)idx;
- (UIImage*)getProductImg:(int)idx type:(ImgType)imgType;

@end
