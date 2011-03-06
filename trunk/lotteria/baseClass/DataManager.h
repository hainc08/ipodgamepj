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
	
	int		storetype;

	NSString *si;
	NSString *gu;
	NSString *dong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
	
	float	coordinate; // 좌표 맵에서 사용될 좌표 .. 나중에 최종 값 나오면 ..
}

@property (retain) NSString *storeid;
@property (retain) NSString *storename;
@property (retain) NSString *storephone;
@property (readwrite) int storetype;

@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;

@end


@interface CustomerDelivery : NSObject {
	NSString *custid;
	NSString *seq;
	NSString *phone;
	NSString *si;
	NSString *gu;
	NSString *dong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
	NSString *branchid;
	NSString *branchname;
	NSString *branchtime;
	NSString *regdate;
	NSString *regtime;
	NSString *upddate;
	NSString *updtime;
}

@property (retain) NSString *custid;
@property (retain) NSString *seq;
@property (retain) NSString *phone;
@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;
@property (retain) NSString *branchid;
@property (retain) NSString *branchname;
@property (retain) NSString *branchtime;
@property (retain) NSString *regdate;
@property (retain) NSString *regtime;
@property (retain) NSString *upddate;
@property (retain) NSString *updtime;

@end


@interface OrderUserAddr : NSObject 
{
	NSString *addrSeq;		// 주소키 값 주겠지..ㅡ.ㅡ; 주소 다보내 달라고 하지는 않겠지..
	NSString *si;	
	NSString *gu;
	NSString *dong;
	NSString *adong;
	NSString *ldong;
	NSString *bunji;
	NSString *building;
	NSString *addrdesc;
}

@property (retain) NSString	*addrSeq;
@property (retain) NSString *si;
@property (retain) NSString *gu;
@property (retain) NSString *dong;
@property (retain) NSString *adong;
@property (retain) NSString *ldong;
@property (retain) NSString *bunji;
@property (retain) NSString *building;
@property (retain) NSString *addrdesc;

@end

@interface Order : NSObject
{
	
	OrderUserAddr	*UserAddr;			// 사용자 배송지주소

	NSString		*UserName;			// 주문사용자
	NSString		*UserPhone;				// 주문자 핸드폰
	
	int				OrderMoney;			// 주문 값
	int				OrderSaleMoney;		// 세일 값 (?? 있으려나 )
	int				OrderTotalMoney;	// 두개 sum 

	int				OrderType;			// 일반 주문 : 0   예약주문 : 1
	NSString		*OrderTime;			// 예약시 예약 시간
	
	NSString		*branchid;			// 매장 ID
	NSString		*branchname;		// 매장 Name
	NSString		*branchPhone;		// 매장 전화번호 
	
}

@property (retain)		OrderUserAddr *UserAddr;
@property (retain)		NSString	*UserName;			// 주문사용자
@property (retain)		NSString	*UserPhone;				// 주문자 핸드폰
@property (readwrite) int	OrderMoney;			// 주문 값
@property (readwrite) int	OrderSaleMoney;		// 세일 값 (?? 있으려나 )
@property (readwrite) int	OrderTotalMoney;	// 두개 sum 

@property (readwrite) int	OrderType;			// 일반 주문 : 0   예약주문 : 1

@property (retain) NSString	*OrderTime;			// 예약시 예약 시간

@property (retain) NSString	*branchid;			// 매장 ID
@property (retain) NSString	*branchname;		// 매장 Name
@property (retain) NSString	*branchPhone;		// 매장 전화번호 
@end



@interface DataManager : NSObject
{
	bool isLoginNow;
	bool isLoginSave;
	NSString* accountId;
	NSString* accountPass;

	Order		 *UserOrder;
	NSMutableArray* ShopCart;
	
	NSMutableDictionary *setProductMap;

	NSMutableDictionary *allProductMap;
	NSMutableArray* allProductList;
	
	NSMutableArray* searchResult[5];
	
	UIViewController* cartView;
}

@property (retain) UIViewController* cartView;
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
- (NSMutableArray*)getShopCart;
- (int)itemCount:(int)listIdx;
- (CartItem*)getCartItem:(int)idx listIdx:(int)listIdx;
- (CartItem*)getCartItem:(int)idx;
- (void)cartUpdate;

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
- (NSString*)getCategoryName:(NSString*)cat;

@end
