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
	bool isShow[12];
}

@property (readwrite) int valCount;

- (void)addIntVal:(int)val;
- (int)getIntVal:(int)idx;

- (bool)getIsShow:(int)idx;
- (void)setIsShow:(int)idx :(bool)h;
- (void)setIsShowByIdx:(int)eventIdx;

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
	int sceneType;
	int willSceneId;

	bool isLoaded;
	int preLoadCharIdx[4];
	UIImage* preLoadChar[4];

	int preLoadBgIdx;
	UIImage* preLoadBg;

	int preLoadBgmIdx;
	
	NSString* serihu;
	NSString* chara;

	NSString* selectStr[3];
	int selectTag[4];
	
	int nextChapter;
	int endNum;
	
	int FXIdx;
	bool FXrepeat;
}

@property (readwrite) bool isLoaded;
@property (readwrite) int sceneId;
@property (readwrite) int willSceneId;
@property (readwrite) int sceneType;
@property (readwrite) int nextChapter;
@property (readwrite) int endNum;
@property (readonly) int preLoadBgIdx;
@property (readwrite) int preLoadBgmIdx;
@property (readwrite) int FXIdx;
@property (readwrite) bool FXrepeat;

- (bool)isLoadOk;

- (void)reset;
- (void)setChar:(int)idx img:(UIImage*)chr chrId:(int)chrId;
- (UIImage*)getChar:(int)idx;
- (UIImage*)findChar:(int)chrId;
- (UIImage*)findSChar:(int)chrId;

- (void)setBg:(UIImage*)bg bgId:(int)bgId;
- (UIImage*)getBg;
- (UIImage*)findBg:(int)bgId;

- (void)setSerihu:(NSString*)str;
- (NSString*)getSerihu;

- (void)setChara:(NSString*)str;
- (NSString*)getChara;

- (void)setSelect:(int)idx str:(NSString*)str;
- (NSString*)getSelect:(int)idx;

- (void)setSelectTag:(int)tag1 :(int)tag2 :(int)tag3 :(int)tag4;
- (int)getSelectTag:(int)idx;
@end

@interface DataManager : NSObject
{	
	NSString* versionNum;
	int tempVoiceList[39];
	NSString* subTitle[90];
	Scenario* scenario[127];
	int moveBG[16];
	CGPoint chrID[82];
	NSString* BGMname[34];
	VName* vname[18];
	EventList* eventList[15];	
	NSString* itemName[23][2];
	
	bool musicShowData[34];

	int msgCount;
	Msg* msg[22050];
	int msgIdx[91];

	//preload데이터
	int curIdx;
	Scene* preloadScene[10];
	Scene* curScene;
	
	int tagInfo[2][800];
	int indexInfo[130];
	
	bool loadingDone;
	int loadingTime;
}

@property (readwrite) bool loadingDone;
@property (readwrite) int loadingTime;

+ (DataManager*)getInstance;
+ (void)initManager;
- (void)closeManager;
- (void)reset;

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
- (Msg*)getMsg2:(int)idx;

- (int)getIndexInfo:(int)idx;
- (int)getTagInfo:(int)tag;

- (int)gotoChapter:(int)chp;
- (void)gotoEnding:(int)type idx:(int)idx;
- (NSString*)getSceneIdxStr;

- (void)setEventData:(int)idx :(int)data;
- (int)getEventData:(int)idx;
- (void)setEventShow:(int)eventIdx;

- (void)resetMusicShow;
- (void)setMusicShow:(int)idx;
- (bool)getMusicShow:(int)idx;

@end
