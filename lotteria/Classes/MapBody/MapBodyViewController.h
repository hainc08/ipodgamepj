#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIViewControllerTemplate.h"	

@class HTTPRequest;
@interface MapBodyViewController : UIViewControllerTemplate <CLLocationManagerDelegate, MKMapViewDelegate > {
	IBOutlet MKMapView *mapView;
	CLLocationManager *locationManager;
	
	IBOutlet UIButton* TextClear;
	IBOutlet UIButton* listView;
	IBOutlet UIButton* storeAll;
	IBOutlet UIButton* storeDelivery;
	IBOutlet UIButton* store24;
	IBOutlet UITextField *Search;
	UIImage* buttonImg[3][2];
	int selectIdx;
	HTTPRequest *httpRequest;
	
	NSMutableArray *AddressArr;

	UIView *blackview;
	UIToolbar *toolbar;
	NSMutableArray *Annotations;
	
	bool infoReceive;
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) UIToolbar *toolbar;
- (void)setupMap;
- (void)selectCategory:(int)idx;
- (IBAction)buttonClick:(id)sender;
- (void)addShopMark:(int)shopIdx  store:(StoreInfo *)Info;
- (void)GetStoreInfo:(NSString *)gis_x gis_y:(NSString *)gis_y;
- (void)reloadMapAnnotation;

@end