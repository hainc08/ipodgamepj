#import <MapKit/MapKit.h>

typedef enum _MOVEMENU {
	MYPAGEMOVE,
	MENUPAGEMOVE,
}MOVEMENU;
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
	bool	StoreMenuOnOff;	// 매장에서 파는지 여부 확인 Update
}

@property (retain) NSString* menuId;
@property (retain) NSString* dessertId;
@property (retain) NSString* drinkId;

@property (readwrite) int count;
@property (readwrite) int listIdx;
@property (readwrite) bool StoreMenuOnOff;

@end

@interface ProductData : NSObject
{
	NSString* menuId;
	NSString* menuDIS; // 할인코드 -- 주문시 필요
	
	NSString* kcal;		// 칼로리 
	NSString* menucomment;	// 메뉴 설명
	NSString* category;
	
	NSString* set_flag;	// 3이면 장남감 세트 
	
	NSString* key;
	NSString* origin;
	NSString* name;

	bool new_flag;		// TRUE면 new이미지 사용 아니면 사용하지 않음.
	int price;
	
	UIImage* img[5];
}

@property (retain) NSString* menuId;
@property (retain) NSString* menuDIS;
@property (retain) NSString* category;
@property (retain) NSString* kcal;
@property (retain) NSString* menucomment;
@property (retain) NSString* set_flag;
@property (readwrite) bool new_flag;

@property (retain) NSString* key;
@property (retain) NSString* origin;
@property (retain) NSString* name;
@property (readwrite) int price;

- (UIImage*)getProductImg:(ImgType)type;

@end

typedef enum _Storetype
{
	ALLSTORE = 0,
	TIMESTORE,	// 24시매장
	DELIVERYSTORE,	// 배달가능 매장
	NORMALSTORE,	// 일반매장
}Storetype;


@interface StoreInfo : NSObject {
	NSString *storeid;
	NSString *storename;
	NSString *storephone;
	
	Storetype		store_flag;		// 

	NSString *si;
	NSString *gu;
	NSString *dong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
	
	CLLocationCoordinate2D coordinate;
}

@property (retain) NSString *storeid;
@property (retain) NSString *storename;
@property (retain) NSString *storephone;
@property (nonatomic, assign) Storetype store_flag;

@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;

- (NSString*)getAddressStr;

@end


@interface DeliveryAddrInfo : NSObject {
	NSString *Seq;			// 주문시 사용됨  
	NSString *phone;		
	
	NSString *si;
	NSString *gu;
	NSString *dong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
	
	NSString *branchid;
	NSString *branchname;
	NSString *branchtel; 
	NSString *terminal_id;	// 주문시 사용 
	NSString *business_date;	// 주무시 사용

	NSDate  *opendate;		// 배달 시작시간
	NSDate	*closedate;		// 배달 끝시간
	NSString *deliverytime;		// 배달 소요시간 ( 사용가능한곳은 없지만 나중에 사용할 수있으니 추가)
	
	NSString *gis_x;
	NSString *gis_y;
}
@property (retain) 	NSString *Seq;
@property (retain) NSString *phone;

@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;

@property (retain) NSString *branchid;
@property (retain) NSString *branchname;

@property (retain) NSString *gis_x;
@property (retain) NSString *gis_y;

@property (retain) 	NSDate  *opendate; 
@property (retain)  NSDate	*closedate;
@property (retain) 	NSString *deliverytime;
@property (retain) NSString *branchtel; 
@property (retain) NSString *terminal_id;	// 주문시 사용 
@property (retain) NSString *business_date;
- (NSString*)getAddressStr;

@end


@interface Order : NSObject
{
	
	DeliveryAddrInfo	*UserAddr;			// 사용자 배송지주소

	NSString		*UserName;			// 주문사용자
	NSString		*UserPhone;			// 주문자 핸드폰

	NSString		*OrderMemo;
	int				OrderMoney;			// 주문 값
	int				OrderSaleMoney;		// 세일 값 (장남감 가격 1500 원 들어감 )

	int				OrderType;			// 일반 주문 : 0   예약주문 : 1
	NSString		*OrderTime;			// 예약시 예약 시간

}

@property (retain)		DeliveryAddrInfo *UserAddr;
@property (retain)		NSString	*UserName;			// 주문사용자
@property (retain)		NSString	*UserPhone;				// 주문자 핸드폰
@property (retain)		NSString	*OrderMemo;		// 주문 내용

@property (readwrite) int	OrderType;			// 일반 주문 : 0   예약주문 : 1
@property (retain) NSString	*OrderTime;			// 예약시 예약 시간

@property (readwrite) int	OrderMoney;			// 주문 값
@property (readwrite) int	OrderSaleMoney;		// 세일 값 
@end

@interface DataManager : NSObject
{
	bool isLoginNow;
	bool isLoginSave;
	NSString* accountId;
	NSString* accountPass;

	Order		 *UserOrder;
	
	// D10 + S10 의 합이 12개 주문할수 있음 나머지 메뉴는 무한대로 주문 가능
	NSMutableArray* ShopCart;		
	
	NSMutableDictionary *setProductMap;

	NSMutableDictionary *allProductMap;
	NSMutableArray* allProductList;
	
	NSMutableArray* searchResult[5];

}

@property (readwrite) bool isLoginNow;
@property (readwrite) bool isLoginSave;
@property (retain) NSString* accountId;
@property (retain) NSString* accountPass;
@property (retain) Order	 *UserOrder;

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

- (void)LoginSave;
//-------------------장바구니 처리---------------------
- (void)addCartItem:(CartItem*)item;
- (void)removeCartItem:(CartItem*)item;
- (void)allremoveCartItem;
- (NSMutableArray*)getShopCart;
- (int)itemCount:(int)listIdx;
- (CartItem*)getCartItem:(int)idx listIdx:(int)listIdx;
- (CartItem*)getCartItem:(int)idx;
- (void)updateCartMenuStatus:(NSString *)menu_id dis:(NSString *)menu_dis flag:(bool)Flag;
- (bool)checkBurgerCount:(int)count;

//-------------------상품 정보 처리---------------------
- (bool)loadProduct;
- (ProductData*)getProduct:(NSString*)menuId;
- (NSString*)getSetId:(NSString*)menuId;
- (UIImage*)getProductImg:(NSString*)menuId type:(ImgType)imgType;
- (NSMutableArray*)getProductArray:(NSString*)category;

- (NSString*)getPriceStr:(int)value;
- (int)getCartPrice;	// 전체 Cart
- (int)getCartSalePrice;	//장난감 세트의 값 
- (ProductData*)getSearchProduct:(int)idx listIdx:(int)lIdx;
- (int)getSearchProductCount:(int)lIdx;
- (void)searchProduct:(NSString*)str;
- (NSString*)getCategoryName:(NSString*)cat;
- (NSString*)getPhoneStr:(NSString*)PhoneNumber;
@end
