#import "SaveManager.h"
#import "FileIO.h"

static SaveManager *SaveManagerInst;

@implementation DataKey
@synthesize key;
@synthesize idx;

-(void)saveData:(NSFileHandle*)writeFile
{
	writeString(writeFile, key);
	writeInt(writeFile, idx);
}
-(void)loadData:(NSFileHandle*)loadFile
{
	key = readString(loadFile);
	idx = readInt(loadFile);
}

@end

@implementation BaseData
@synthesize keyIdx;
@synthesize idx;
-(void)saveData:(NSFileHandle*)writeFile
{
	writeInt(writeFile, keyIdx);
	writeInt(writeFile, idx);
}
-(void)loadData:(NSFileHandle*)loadFile
{
	keyIdx = readInt(loadFile);
	idx = readInt(loadFile);
}
@end

@implementation StringData
-(NSString*)getValue { return value; }
-(void)setValue:(NSString*)v { value = v; }
-(void)saveData:(NSFileHandle*)writeFile
{
	[super saveData:writeFile];
	writeString(writeFile, value);
}
-(void)loadData:(NSFileHandle*)loadFile
{
	[super loadData:loadFile];
	value = readString(loadFile);
}
@end

@implementation IntData
-(int)getValue { return value; }
-(void)setValue:(int)v { value = v; }
-(void)saveData:(NSFileHandle*)writeFile
{
	[super saveData:writeFile];
	writeInt(writeFile, value);
}
-(void)loadData:(NSFileHandle*)loadFile
{
	[super loadData:loadFile];
	value = readInt(loadFile);
}
@end

@implementation SaveManager

+ (SaveManager*)getInstance
{
	return SaveManagerInst;
}

+ (void)initManager;
{
	SaveManagerInst = [SaveManager alloc];
	[SaveManagerInst loadFile];
}

- (void)closeManager
{

}

- (void)saveFile
{
	if (isDirty == false) return;

	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/save.dat", recordingDirectory];
	
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:saveFile];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:saveFile
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:saveFile];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}
	
	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);

	writeInt(writeFile, [stringData count]);
	for (id data in stringData)
	{
		BaseData* sData = (BaseData*)data;
		[sData saveData:writeFile];
	}

	writeInt(writeFile, [intData count]);
	for (id data in intData)
	{
		BaseData* iData = (BaseData*)data;
		[iData saveData:writeFile];
	}

	writeInt(writeFile, [keys count]);
	for (id data in keys)
	{
		DataKey* kData = (DataKey*)data;
		[kData saveData:writeFile];
	}
	
	[writeFile closeFile];

	isDirty = false;
}

- (void)loadFile
{
	stringData = [[NSMutableArray alloc] initWithCapacity:0];
	intData = [[NSMutableArray alloc] initWithCapacity:0];
	keys = [[NSMutableArray alloc] initWithCapacity:0];
	
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/save.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
	if(readFile == nil) return;
	
	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		int count = readInt(readFile);
		for (int i=0; i<count; ++i)
		{
			StringData* data = [StringData alloc];
			[data loadData:readFile];
			[stringData addObject:data];
		}
		
		count = readInt(readFile);
		for (int i=0; i<count; ++i)
		{
			IntData* data = [IntData alloc];
			[data loadData:readFile];
			[intData addObject:data];
		}
		
		count = readInt(readFile);
		for (int i=0; i<count; ++i)
		{
			DataKey* kd = [DataKey alloc];
			[kd loadData:readFile];
			[keys addObject:kd];
		}
	}
	
	[readFile closeFile];
	
	isDirty = false;
}

- (int)getIntData:(NSString*)key idx:(int)idx base:(int)base;
{
	int keyIdx;

	for (id k in keys)
	{
		DataKey* kd = (DataKey*)k;
		if ([key compare:[kd key]] == NSOrderedSame)
		{
			keyIdx = [kd idx];
			goto FINDKEY;
		}
	}
	
	return base;
FINDKEY:

	for (id data in intData)
	{
		IntData* iData = (IntData*)data;
		if ((keyIdx == [iData keyIdx]) && (idx == [iData idx]))
		{
			return [iData getValue];
		}
	}
	
	return base;
}

- (NSString*)getStringData:(NSString*)key idx:(int)idx base:(NSString*)base
{
	int keyIdx;
	
	for (id k in keys)
	{
		DataKey* kd = (DataKey*)k;
		if ([key compare:[kd key]] == NSOrderedSame)
		{
			keyIdx = [kd idx];
			goto FINDKEY;
		}
	}
	
	return base;
FINDKEY:
	
	for (id data in stringData)
	{
		StringData* sData = (StringData*)data;
		if ((keyIdx == [sData keyIdx]) && (idx == [sData idx]))
		{
			return [sData getValue];
		}
	}
	
	return base;
}

- (void)setIntData:(NSString*)key idx:(int)idx value:(int)value
{
	int keyIdx;
	DataKey* kd;
	IntData* iData;
	
	for (id k in keys)
	{
		kd = (DataKey*)k;
		if ([key compare:[kd key]] == NSOrderedSame) goto FINDKEY;
	}

	kd = [[DataKey alloc] init];
	[kd setIdx:[keys count]];
	[kd setKey:key];
	
	[keys addObject:kd];

FINDKEY:
	keyIdx = [kd idx];
	
	for (id data in intData)
	{
		iData = (IntData*)data;
		if ((keyIdx == [iData keyIdx]) && (idx == [iData idx]))
		{
			if ([iData getValue] != value)
			{
				isDirty = true;
				[iData setValue:value];
			}
			return;
		}
	}

	iData = [IntData alloc];
	[iData setKeyIdx:keyIdx];
	[iData setIdx:idx];
	[iData setValue:value];
	
	[intData addObject:iData];

	isDirty = true;
}

- (void)setStringData:(NSString*)key idx:(int)idx value:(NSString*)value
{
	int keyIdx;
	DataKey* kd;
	StringData* sData;
	
	for (id k in keys)
	{
		kd = (DataKey*)k;
		if ([key compare:[kd key]] == NSOrderedSame) goto FINDKEY;
	}
	
	kd = [[DataKey alloc] init];
	[kd setIdx:[keys count]];
	[kd setKey:key];
	
	[keys addObject:kd];
	
FINDKEY:
	keyIdx = [kd idx];
	
	for (id data in stringData)
	{
		sData = (StringData*)data;
		if ((keyIdx == [sData keyIdx]) && (idx == [sData idx]))
		{
			if ([value compare:[sData getValue]] == NSOrderedSame)
			{
				isDirty = true;
				[sData setValue:value];
			}
			return;
		}
	}
	
	sData = [StringData alloc];
	[sData setKeyIdx:keyIdx];
	[sData setIdx:idx];
	[sData setValue:value];
	
	[stringData addObject:sData];
	isDirty = true;
}

@end
