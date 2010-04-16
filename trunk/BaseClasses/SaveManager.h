
@interface SaveManager : NSObject
{	
	int test;
}

@property (readwrite) int test;

+ (SaveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (bool)isSaved;
- (void)loadFromFile;
- (void)saveToFile;

@end
