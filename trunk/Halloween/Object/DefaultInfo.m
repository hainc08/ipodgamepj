#import "DefaultInfo.h"
static DefaultManager *dataDefaultManager;

@implementation DefaultManager

+ (DefaultManager*)getInstance
{
	return dataDefaultManager;
}

+ (void)initManager
{
	dataDefaultManager = [DefaultManager alloc];
    [dataDefaultManager loadGumInfo];
	return;
}

- (void)closeManager
{
}
- (void)loadGumInfo {
    /* 데미지, 스피드 , 공격 범위 */
   GumAttectInfo  value[2] = {
        { 10, -10 , 420 }, 
        { 10, -10 , 150 }
    };
    memcpy(gumInfo, value, sizeof(GumAttectInfo) * 2);
}
- (GumAttectInfo) getGumInfo:(int)type
{
    return gumInfo[type];
}

@end
