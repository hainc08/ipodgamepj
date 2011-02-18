

@interface ImgManager : NSObject
{
	UIImage* u_image[10];
	UIImage* d_image[10];

}

+ (ImgManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (UIImage*)getUp:(int)idx;
- (UIImage*)getDown:(int)idx;
@end
