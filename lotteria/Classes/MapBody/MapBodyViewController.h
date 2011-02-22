#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapBodyViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
	IBOutlet MKMapView *mapView;
	CLLocationManager *locationManager;

	IBOutlet UIButton* storeAll;
	IBOutlet UIButton* storeDelivery;
	IBOutlet UIButton* store24;
	
	UIImage* buttonImg[3][2];
	int selectIdx;
}

@property (nonatomic, retain) MKMapView *mapView;

-(void)setupMap;
-(void)selectCategory:(int)idx;
-(IBAction)buttonClick:(id)sender;
-(void)addShopMark:(int)shopIdx location:(CLLocationCoordinate2D)location;

@end
