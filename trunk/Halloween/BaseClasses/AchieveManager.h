enum{
	KillGhost = 0,
	EatItem = 1,
};

typedef struct _Achieve
{
	bool isGet;
	int goal;
	int data;
	
	int event;
	int param1, param2, param3;
	
	NSString* name;
	int iconIdx;
	NSString* desc;
} Achieve;

@interface AchieveManager : NSObject
{
	Achieve achieves[50];

	NSTimer *updateTimer;

	bool isDirty;
	
	int curAdd;
}

+ (AchieveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)resumeTimer;

- (void)loadFile;
- (void)saveFile;

- (void)event:(int)event :(int)param1 :(int)param2 :(int)param3;
- (void)addEvent:(int)event :(int)goal :(int)param1 :(int)param2 :(int)param3 :(NSString*)name :(int)iconIdx :(NSString*)desc;

@end
