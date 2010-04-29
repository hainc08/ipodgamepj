@interface Scenario : NSObject
{
	//뭔내용인지 모르니 네이밍이 이따위...
	int intVal[3];
	NSString* strVal;
}

- (void)setIntVal:(int)idx val:(int)val;
- (int)getIntVal:(int)idx;
- (void)setStrVal:(NSString*)val;
- (NSString*)getStrVal;

@end

@interface VName : NSObject
{
	int valCount;
	NSString* strVal[6];
}

@property (readwrite) int valCount;

- (void)addStrVal:(NSString*)val;
- (NSString*)getStrVal:(int)idx;

@end

@interface EventList : NSObject
{
	int valCount;
	int intVal[12];
}

@property (readwrite) int valCount;

- (void)addIntVal:(int)val;
- (int)getIntVal:(int)idx;

@end

@interface Msg : NSObject
{
	int intVal[13];
	int valCount;
	NSString* strVal[7];
}

@property (readwrite) int valCount;

- (void)setIntVal:(int)idx val:(int)val;
- (int)getIntVal:(int)idx;
- (void)addStrVal:(NSString*)val;
- (NSString*)getStrVal:(int)idx;

@end

@interface Scene : NSObject
{
	int sceneId;
	int willSceneId;

	bool isLoaded;
	int preLoadCharIdx[3];
	UIImage* preLoadChar[3];

	int preLoadBgIdx;
	UIImage* preLoadBg;
}

@property (readwrite) bool isLoaded;
@property (readwrite) int sceneId;
@property (readwrite) int willSceneId;

- (void)reset;
- (void)setChar:(int)idx img:(UIImage*)chr chrId:(int)chrId;
- (UIImage*)getChar:(int)idx;
- (UIImage*)findChar:(int)chrId;

- (void)setBg:(UIImage*)bg bgId:(int)bgId;
- (UIImage*)getBg;
- (UIImage*)findBg:(int)bgId;

@end

@interface DataManager : NSObject
{	
	NSString* versionNum;
	int tempVoiceList[39];
	NSString* subTitle[90];
	Scenario* scenario[127];
	int moveBG[16];
	CGPoint chrID[82];
	NSString* BGMname[29];
	VName* vname[18];
	EventList* eventList[15];
	NSString* itemName[23][2];

	int msgCount;
	Msg* msg[22031];
	int msgIdx[91];

	//preload데이터
	int curIdx;
	Scene* preloadScene[10];
	Scene* curScene;
	
	bool loadingDone;
}

@property (readwrite) bool loadingDone;

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (bool)parseData;
- (void)parseSubTitle:(char*)data;
- (void)parseScenario:(char*)data;
- (void)parseChrID:(char*)data;
- (void)parseVName:(char*)data;
- (void)parseEventList:(char*)data;
- (void)parseItemName:(char*)data;
- (void)parseMsg:(char*)data;

- (void)preload;
- (void)setCurIdx:(int)idx1;
- (void)setNextIdx:(int)idx1;
- (void)resetPreload;
- (Scene*)getCurScene;

- (NSString*)getSubTitle:(int)idx;
- (Scenario*)getScenario:(int)idx;
- (CGPoint)getChrID:(int)idx;
- (VName*)getVName:(int)idx;
- (EventList*)getEventList:(int)idx;
- (NSString*)getItemName:(int)idx idx2:(int)idx2;
- (Msg*)getMsg:(int)idx idx2:(int)idx2;

@end
