
@interface PointManager : NSObject
{
	int point;
	int maxPoint[2];
	int maxIdx;
}

@property (readwrite) int point;
@property (readwrite) int maxIdx;

+ (PointManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (int)getMaxPoint;
- (void)addPoint:(int)p;

@end
