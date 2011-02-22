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
	NSString* menuId;
	NSString* drinkId;
	NSString* dessertId;

	int count;
}

@property (retain) NSString* menuid;
@property (retain) NSString* drinkId;
@property (retain) NSString* dessertId;

@property (readwrite) int count;

@end

@interface ProductData : NSObject
{
	NSString* menuId;
	NSString* category;

	NSString* key;
	NSString* name;

	int price;
	
	UIImage* img[5];
}

@property (retain) NSString* menuId;
@property (retain) NSString* category;

@property (retain) NSString* key;
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
	NSMutableDictionary *setProductMap;

	NSMutableArray* allProductList;
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
- (ProductData*)getProduct:(NSString*)menuId;
- (UIImage*)getProductImg:(NSString*)menuId type:(ImgType)imgType;
- (NSMutableArray*)getProductArray:(NSString*)category;

@end
