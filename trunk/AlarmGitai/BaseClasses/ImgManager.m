#import "ImgManager.h"
static ImgManager *ImgManagerInst;

@implementation ImgManager

+ (ImgManager*)getInstance
{
	return ImgManagerInst;
}

+ (void)initManager
{
	ImgManagerInst = [ImgManager alloc];
	for (int i=1; i< 2; ++i)
	{
		for(int j=0; j< 10; ++j)
		{
			ImgManagerInst->d_image[j] = [UIImage imageNamed:[NSString stringWithFormat:@"%d_dw%d.png", i,j]];
			ImgManagerInst->u_image[j] = [UIImage imageNamed:[NSString stringWithFormat:@"%d_ub%d.png", i,j]];
		}
	}
	
}

- (UIImage*)getUp:(int)idx
{
	return u_image[idx];
}

- (UIImage*)getDown:(int)idx
{
	return d_image[idx];
}
- (void)closeManager
{
	for (int i=0; i<10; ++i)
	{
		[u_image[i] release];
		[d_image[i] release];
	}

}

@end
