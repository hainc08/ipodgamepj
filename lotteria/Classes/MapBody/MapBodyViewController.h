#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapBodyViewController : UIViewController {
	IBOutlet MKMapView *mapView;

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

@end
