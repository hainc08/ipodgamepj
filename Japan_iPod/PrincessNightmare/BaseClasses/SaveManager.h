@interface SaveManager : NSObject
{	
	int opt1, opt2;

	int saveData[28];
	int saveDate[28];
	char saveFlag[28][20];
	char saveFlag2[28][30];

	char sceneExp[127];
	char sceneExp2[2757];
	int sceneExpDirty;
	
	char flag[20];
	char flag2[30];

	bool itemFlag[23];
	
	NSString* saveFileName;
	NSString* extraFileName;
	NSString* musicFileName;
	NSString* optionFileName;
	NSString* sceneExpFileName;
	NSString* sceneExp2FileName;
	NSString* itemFlagFileName;
	
	int lastPage;
	
	int qsaveSlot;
	int qsavedScene;
}

@property (readonly) int opt1;
@property (readonly) int opt2;

@property (readwrite) int lastPage;

@property (readwrite) int qsaveSlot;
@property (readwrite) int qsaveScene;

+ (SaveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)initFilePath;
- (void)resetFlag;
- (void)setFlag:(int)idx;
- (bool)getFlag:(int)idx;
- (void)setFlag2:(int)idx data:(int)data;
- (int)getFlag2:(int)idx;
- (void)setFlagData:(int)idx;

- (void)loadSaveFile;
- (void)saveSaveFile;

- (void)loadExtraFile;
- (void)saveExtraFile;

- (void)loadMusicFile;
- (void)saveMusicFile;

- (void)loadOptionFile;
- (void)saveOptionFile;

- (void)loadSceneExpFile;
- (void)saveSceneExpFile;

- (void)loadItemFlagFile;
- (void)saveItemFlagFile;

- (void)loadSceneExp2File;
- (void)saveSceneExp2File:(bool)force;

- (int)getSaveData:(int)idx;
- (NSDate*)getSaveDate:(int)idx;

- (void)setSceneExp:(int)idx;
- (bool)getSceneExp:(int)idx;

- (void)setSceneExp2:(int)idx;
- (bool)getSceneExp2:(int)idx;

- (void)setItemFlag:(int)idx;
- (bool)getItemFlag:(int)idx;

- (void)save:(int)idx data:(int)data;

- (void)setOpt:(int)o1 :(int)o2;

- (void)qsave;

@end
