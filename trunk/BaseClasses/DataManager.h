
@interface DataManager : NSObject
{	

}

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)parseData;

@end
