#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PlaceMark : NSObject<MKAnnotation> {
	int shopType;
	NSInteger idx;
	NSString *title;
	NSString *subtitle;
	CLLocationCoordinate2D coordinate;

	//걍 보이드포인터로 저장하자...
	StoreInfo* info;
}

@property (readwrite) int shopType;
@property NSInteger idx;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *subtitle;
@property(nonatomic,retain) StoreInfo *info;

@end
