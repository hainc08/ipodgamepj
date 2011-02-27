typedef enum _ImgType
{
	MIDDLE = 0,
	DESC = 1,
	DETAIL = 2,
	NAME = 3,
	SMALL = 4
} ImgType;

#define SIDE_DRINK 0
#define SIDE_DESSERT 1

@interface CartItem : NSObject
{
	NSString* menuId;
	NSString* dessertId;
	NSString* drinkId;

	int count;
	int listIdx;
}

@property (retain) NSString* menuId;
@property (retain) NSString* dessertId;
@property (retain) NSString* drinkId;

@property (readwrite) int count;
@property (readwrite) int listIdx;

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

	NSMutableArray* ShopCart;
	
	NSMutableDictionary *setProductMap;

	NSMutableDictionary *allProductMap;
	NSMutableArray* allProductList;
	
	NSMutableArray* searchResult[5];
	bool isCartDirty;
}

@property (readonly) bool isLoginNow;
@property (retain) NSString* accountId;
@property (retain) NSString* accountPass;
@property (readwrite) bool isCartDirty;

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

//-------------------장바구니 처리---------------------
- (void)addCartItem:(CartItem*)item;
- (void)removeCartItem:(CartItem*)item;
- (NSMutableArray*)getShopCart;
- (int)itemCount:(int)listIdx;
- (CartItem*)getCartItem:(int)idx listIdx:(int)listIdx;

//-------------------상품 정보 처리---------------------
- (void)loadProduct;
- (ProductData*)getProduct:(NSString*)menuId;
- (NSString*)getSetId:(NSString*)menuId;
- (UIImage*)getProductImg:(NSString*)menuId type:(ImgType)imgType;
- (NSMutableArray*)getProductArray:(NSString*)category;

- (NSString*)getPriceStr:(int)value;
- (int)getCartPrice;

- (ProductData*)getSearchProduct:(int)idx listIdx:(int)lIdx;
- (int)getSearchProductCount:(int)lIdx;
- (void)searchProduct:(NSString*)str;

// ----------------- 로그인 -------------------
- (void)setLoginNow;

@end
