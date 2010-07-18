

@interface ImgManager : NSObject
{
	UIImage* u_image[20];
	UIImage* d_image[20];


}

+ (ImgManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (UIImage*)getUp:(int)idx;
- (UIImage*)getDown:(int)idx;
@end
