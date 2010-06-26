@interface SaveManager : NSObject
{	
	int saveData[28];
	int saveDate[28];
}

+ (SaveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadSaveFile;
- (void)saveSaveFile;

- (void)loadExtraFile;
- (void)saveExtraFile;

- (int)getSaveData:(int)idx;
- (NSDate*)getSaveDate:(int)idx;

- (void)save:(int)idx data:(int)data;

@end
