@interface DataKey : NSObject
{
	NSString* key;
	int idx;
}

@property (retain) NSString* key;
@property (readwrite) int idx;
-(void)saveData:(NSFileHandle*)writeFile;
-(void)loadData:(NSFileHandle*)loadFile;
@end

@interface BaseData : NSObject
{
	int keyIdx;
	int idx;
}

@property (readwrite) int idx;
@property (readwrite) int keyIdx;
-(void)saveData:(NSFileHandle*)writeFile;
-(void)loadData:(NSFileHandle*)loadFile;
@end

@interface StringData : BaseData
{
	NSString* value;
}
-(NSString*)getValue;
-(void)setValue:(NSString*)v;
-(void)saveData:(NSFileHandle*)writeFile;
-(void)loadData:(NSFileHandle*)loadFile;
@end

@interface IntData : BaseData
{
	int value;
}
-(int)getValue;
-(void)setValue:(int)v;
-(void)saveData:(NSFileHandle*)writeFile;
-(void)loadData:(NSFileHandle*)loadFile;
@end

@interface SaveManager : NSObject
{	
	NSMutableArray* stringData;
	NSMutableArray* intData;
	NSMutableArray* keys;
	
	bool isDirty;
}

+ (SaveManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadFile;
- (void)saveFile;

- (int)getIntData:(NSString*)key idx:(int)idx base:(int)base;
- (NSString*)getStringData:(NSString*)key idx:(int)idx base:(NSString*)base;

- (void)setIntData:(NSString*)key idx:(int)idx value:(int)value;
- (void)setStringData:(NSString*)key idx:(int)idx value:(NSString*)value;

@end
