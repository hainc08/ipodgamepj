@interface SaveManager : NSObject
{	
	int opt1, opt2;

	int saveData[28];
	int saveDate[28];
}

@property (readonly) int opt1;
@property (readonly) int opt2;

+ (SaveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadSaveFile;
- (void)saveSaveFile;

- (void)loadExtraFile;
- (void)saveExtraFile;

- (void)loadOptionFile;
- (void)saveOptionFile;

- (int)getSaveData:(int)idx;
- (NSDate*)getSaveDate:(int)idx;

- (void)save:(int)idx data:(int)data;

- (void)setOpt:(int)o1 :(int)o2;

@end
