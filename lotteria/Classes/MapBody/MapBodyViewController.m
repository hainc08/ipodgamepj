#import "MapBodyViewController.h"
#import "MapSearchViewController.h"
#import "PlaceMark.h"
#import "HttpRequest.h"
#import "XmlParser.h"

@implementation MapBodyViewController

@synthesize mapView;

- (void)viewDidLoad {
	naviImgIdx = 0;
	[super viewDidLoad];
	self.navigationItem.title = @"매장찾기";
	
	buttonImg[0][0] = [[UIImage imageNamed:@"btn_store_all_off.png"] retain];
	buttonImg[0][1] = [[UIImage imageNamed:@"btn_store_all_on.png"] retain];
	buttonImg[1][0] = [[UIImage imageNamed:@"btn_store_delivery_off.png"] retain];
	buttonImg[1][1] = [[UIImage imageNamed:@"btn_store_delivery_on.png"] retain];
	buttonImg[2][0] = [[UIImage imageNamed:@"btn_store_24_off.png"] retain];
	buttonImg[2][1] = [[UIImage imageNamed:@"btn_store_24_on.png"] retain];
	
	selectIdx = -1;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil]; 
	
	
	blackview = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 360)];
	blackview.backgroundColor =  [UIColor colorWithWhite: 0.0 alpha: 0.4];
	[self.view addSubview:blackview];
	[blackview setAlpha:0];
	
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease]; 
	UIBarButtonItem *barButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleButton:)] autorelease];
	NSArray *items = [[NSArray alloc] initWithObjects:flexibleSpace,barButtonItem, nil];
	[toolbar setItems:items];
	[items release];
	
	Search.inputAccessoryView = toolbar;
	
	[self selectCategory:0];
	[self setupMap];
	[self GetStoreInfo:[NSString stringWithFormat:@"%ld", mapView.userLocation.coordinate.latitude] gis_y:[NSString stringWithFormat:@"%ld", mapView.userLocation.coordinate.longitude]];
}
- (void)viewDidUnload {

	
}

- (void)dealloc {
	[buttonImg[0][0] release]; 
	[buttonImg[0][1] release]; 
	[buttonImg[1][0] release]; 
	[buttonImg[1][1] release]; 
	[buttonImg[2][0] release]; 
	[buttonImg[2][1] release]; 
	if(httpRequest)
		[httpRequest release];

	[blackview release];	
	[toolbar release];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark HttpRequestDelegate

- (void)GetStoreInfo:(NSString *)gis_x gis_y:(NSString *)gis_y
{
	httpRequest = [[HTTPRequest alloc] init];
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								gis_x,@"gis_x",
								gis_y,@"gis_y",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbBranch.asmx/ws_getBranchGisXml" bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view isBlock:YES];
}

- (void)didReceiveFinished:(NSString *)result
{
	[[ViewManager getInstance] waitview:self.view isBlock:NO];
	XmlParser* xmlParser = [XmlParser alloc];
	[xmlParser parserString:result];
	Element* root = [xmlParser getRoot:@"NewDataSet"];
	
	
	if(root == nil)
	{
		NSString *Value  = [[xmlParser getRoot:@"RESULT_CODE"] getValue];
		if( [Value compare:@"N"] == NSOrderedSame )
			[self ShowOKAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
		else 	if( [Value compare:@"C"] == NSOrderedSame )
			[self ShowOKAlert:@"Data Fail" msg:@"서버에 오류가 발생하였습니다."];	
	}
	else {
	
		
		for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
		{
			
			StoreInfo *storeaddr  = [[[StoreInfo alloc] init] retain];
			[storeaddr setStoreid:[[t_item getChild:@"BRANCH_ID"] getValue]];
			[storeaddr setStorename:[[t_item getChild:@"BRANCH_NM"] getValue]];
			[storeaddr setStorephone:[[t_item getChild:@"BRANCH_TEL1"] getValue]];
			
			[storeaddr setSi:[[t_item getChild:@"SI"] getValue]];
			[storeaddr setGu:[[t_item getChild:@"GU"] getValue]];
			[storeaddr setDong:[[t_item getChild:@"DONG"] getValue]];
			[storeaddr setBunji:[[t_item getChild:@"BUNJI"] getValue]];
			[storeaddr setBuilding:[[t_item getChild:@"BUILDING"] getValue]];
			[storeaddr setAddrdesc:[[t_item getChild:@"ADDR_DESC"] getValue]];
			
			NSString *xvalue = [[t_item getChild:@"GIS_X"] getValue];
			NSString *yvalue = [[t_item getChild:@"GIS_Y"] getValue];
			
			CLLocationCoordinate2D temp;
			temp.latitude	= [xvalue integerValue];
			temp.longitude	= [yvalue integerValue];
			[storeaddr setCoordinate:temp];
			
			NSString *delivery = [[t_item getChild:@"DELIVERY_FLAG"] getValue];
			NSString *open = [[t_item getChild:@"OPEN_FLAG"] getValue];
			
			if ( [delivery compare:@"Y"] == NSOrderedSame ) [storeaddr setStore_flag:DELIVERYSTORE];
			else if ( [open compare:@"Y"] == NSOrderedSame ) [storeaddr setStore_flag:TIMESTORE];
			else [storeaddr setStore_flag:NORMALSTORE];
			
			[AddressArr  addObject:storeaddr];
		}	
		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;
}

#pragma mark  -
#pragma mark TextField


- (void)keyboardWillShow:(NSNotification *)note
{
	[blackview setAlpha:1];
}


- (void)keyboardWillHide:(NSNotification*)notification {
	[blackview setAlpha:0];
}
- (void)cancleButton:(id)sender
{
	[Search setText:@""];
	[Search resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	MapSearchViewController *SearchControl = [[MapSearchViewController alloc] initWithNibName:@"MapSearchView" bundle:nil];
	SearchControl.Dong = Search.text;
	
	[Search setText:@""];
	[textField resignFirstResponder];
	
	[self.navigationController pushViewController:SearchControl animated:YES];
	[SearchControl release];

	return YES;
}

#pragma mark -
#pragma mark Map


-(void)setupMap
{
	locationManager=[[CLLocationManager alloc] init];
	locationManager.delegate=self;
	locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[locationManager startUpdatingLocation];
	
	[mapView setDelegate:self];

//원하는 위치로 찾아가는 코드...
//	CLLocationCoordinate2D location; 
//	location.latitude=38.f;
//	location.longitude=0.f;
//
//	MKCoordinateRegion region;
//	region.center=location;
//
//	MKCoordinateSpan span;
//	span.latitudeDelta=0.03f;
//	span.longitudeDelta=0.03f;
//	region.span=span;
//	
//	[mapView setRegion:region animated:TRUE];

}

-(void)selectCategory:(int)idx
{
	if (selectIdx == idx) return;
	selectIdx = idx;

	int i[3];
	
	i[0] = i[1] = i[2] = 0;
	i[idx] = 1;
	
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateNormal];
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateHighlighted];
	[storeAll setImage:buttonImg[0][i[0]] forState:UIControlStateSelected];
	
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateNormal];
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateHighlighted];
	[storeDelivery setImage:buttonImg[1][i[1]] forState:UIControlStateSelected];
	
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateNormal];
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateHighlighted];
	[store24 setImage:buttonImg[2][i[2]] forState:UIControlStateSelected];	
}

-(IBAction)buttonClick:(id)sender
{
	if (sender == storeAll) [self selectCategory:0];
	else if (sender == storeDelivery) [self selectCategory:1];
	else if (sender == store24) [self selectCategory:2];
	else if (sender == listView) 
	{
		[Search resignFirstResponder];		
		MapSearchViewController *SearchControl = [[MapSearchViewController alloc] initWithNibName:@"MapSearchView" bundle:nil];
		SearchControl.Dong = Search.text;

		[Search setText:@""];
		[self.navi pushViewController:SearchControl animated:YES];
		[SearchControl release];
	}
	else if (sender == TextClear)	[Search setText:@""];
}

//테스트용...실제 데이타는 어떻게 들어오려나?
-(void)addShopMark:(int)shopIdx location:(CLLocationCoordinate2D)location
{
	PlaceMark *anote = [[PlaceMark alloc] init];
	anote.idx = shopIdx;
	anote.shopType = shopIdx;
	anote.coordinate = location;
	
	
	anote.title =@"롯데리아 대청점";

	NSString *phoneRgCode = @"02";
	NSString *phoneNumber = @"5332580";
	
	anote.subtitle  = [NSString stringWithFormat:@"%@-%@-%@",
					   phoneRgCode ,
					   [phoneNumber substringToIndex:[phoneNumber length]-4],
					   [phoneNumber substringFromIndex:[phoneNumber length]-4]];

	[mapView addAnnotation:anote];
}

-(void)addShopMark:(int)shopIdx  store:(StoreInfo *)Info
{
	PlaceMark *anote = [[PlaceMark alloc] init];
	anote.idx = shopIdx;
	anote.shopType = Info.store_flag	;
	anote.coordinate = Info.coordinate ;
		
		
	anote.title = [NSString	 stringWithFormat:@"롯데리아 %@" , Info.storename] ;
	
	int len = [[Info storephone] length];
	int t = 3;
	if ([[[Info storephone] substringWithRange:NSMakeRange(0, 2)] compare:@"02"] == NSOrderedSame) t = 2;
	
	anote.subtitle = [NSString stringWithFormat:@"%@-%@-%@",
			 [[Info storephone] substringWithRange:NSMakeRange(0, t)],
			 [[Info storephone] substringWithRange:NSMakeRange(t, len - 4 - t)],
			 [[Info storephone] substringWithRange:NSMakeRange(len - 4, 4)]];
	
	[mapView addAnnotation:anote];
 }
						   
						   
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	mapView.hidden = NO;
	[locationManager stopUpdatingLocation];
	
	MKCoordinateRegion region;
	region.center=newLocation.coordinate;
	
	MKCoordinateSpan span;
	span.latitudeDelta=0.01f;
	span.longitudeDelta=0.01f;
	region.span=span;
	
	[mapView setRegion:region animated:FALSE];
	mapView.userLocation.title = @"내위치";

	CLLocationCoordinate2D location;

	location.latitude=newLocation.coordinate.latitude + 0.001f;
	location.longitude=newLocation.coordinate.longitude - 0.001f;
	location.latitude=newLocation.coordinate.latitude;
	location.longitude=newLocation.coordinate.longitude;
	[self addShopMark:0 location:location];

	location.latitude=newLocation.coordinate.latitude + 0.003f;
	location.longitude=newLocation.coordinate.longitude + 0.001f;
	[self addShopMark:1 location:location];

	location.latitude=newLocation.coordinate.latitude - 0.002f;
	location.longitude=newLocation.coordinate.longitude - 0.002f;
	[self addShopMark:2 location:location];
}
	 
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"매장을 검색하시려면 위치정보를 허용해야합니다. 프로그램 종료후 다시 실행하여 위치정보를 허용하십시오."
						  message:@"롯데리아"
						  delegate:nil
						  cancelButtonTitle:@"닫기"
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	PlaceMark *anote = (PlaceMark*)annotation;
	
	MKAnnotationView *annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	switch (anote.shopType)
	{
		case 0:
			annView.image = [UIImage imageNamed:@"icon_pin_all"];
			break;
		case 1:
			annView.image = [UIImage imageNamed:@"icon_pin_24"];
			break;
		case 2:
			annView.image = [UIImage imageNamed:@"icon_pin_delivery"];
			break;
	}
	//    annView.animatesDrop = TRUE;
	annView.canShowCallout = YES;
	annView.centerOffset = CGPointMake(0, -30);
	
	UIButton *disclosureButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
	annView.canShowCallout = YES;
	annView.rightCalloutAccessoryView = disclosureButton;
	
	return annView;
}

@end
