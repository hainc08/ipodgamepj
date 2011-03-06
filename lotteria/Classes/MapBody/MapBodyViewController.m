#import "MapBodyViewController.h"
#import "MapSearchViewController.h"
#import "PlaceMark.h"

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
	
	[self selectCategory:0];
	[self setupMap];
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
	
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event	
{
	[Search resignFirstResponder];
}

#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	MapSearchViewController *SearchControl = [[MapSearchViewController alloc] initWithNibName:@"MapSearchView" bundle:nil];
	
	[self.navi pushViewController:SearchControl animated:YES];
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
		MapSearchViewController *SearchControl = [[MapSearchViewController alloc] initWithNibName:@"MapSearchView" bundle:nil];
		SearchControl.Dong = Search.text;
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
