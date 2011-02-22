#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapBodyViewController : UIViewController {
	IBOutlet MKMapView *mapView;
}

@property (nonatomic, retain) MKMapView *mapView;

-(void)setupMap;

@end
