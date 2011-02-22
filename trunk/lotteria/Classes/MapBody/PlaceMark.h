#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PlaceMark : NSObject<MKAnnotation> {
	int shopType;
	NSInteger idx;
	NSString *title;
	NSString *subtitle;
	CLLocationCoordinate2D coordinate;
}

@property (readwrite) int shopType;
@property NSInteger idx;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *subtitle;

@end
