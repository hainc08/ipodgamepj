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
    /* 데미지, 스피드 , 공격 범위 ,  공격반경 */
   GumAttactInfo  value[2] = {
        { 10, -10 , 420, 5 }, 
        { 10, -10 , 150, 20 }
    };
    memcpy(gumInfo, value, sizeof(GumAttactInfo) * 2);
}
- (GumAttactInfo) getGumInfo:(int)type
{
    return gumInfo[type];
}

@end
