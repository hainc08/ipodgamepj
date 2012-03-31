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
-(void)setValue:(NSString*)v
{
	if (value != nil) [value release];
	value = [[NSString stringWithString:v] retain];
}
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

@implementation FloatData
-(float)getValue { return value; }
-(void)setValue:(float)v { value = v; }
-(void)saveData:(NSFileHandle*)writeFile
{
	[super saveData:writeFile];
	writeFloat(writeFile, value);
}
-(void)loadData:(NSFileHandle*)loadFile
{
	[super loadData:loadFile];
	value = readFloat(loadFile);
}
@end

@implementation SaveManager

@synthesize curSlot;

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
	int ver = 2;
	writeInt(writeFile, ver);

	writeInt(writeFile, [stringData count]);
	for (BaseData* data in stringData)
	{
		[data saveData:writeFile];
	}

	writeInt(writeFile, [intData count]);
	for (BaseData* data in intData)
	{
		[data saveData:writeFile];
	}

	writeInt(writeFile, [floatData count]);
	for (BaseData* data in floatData)
	{
		[data saveData:writeFile];
	}
	
	writeInt(writeFile, [keys count]);
	for (DataKey* data in keys)
	{
		[data saveData:writeFile];
	}
	
	[writeFile closeFile];

	isDirty = false;
}

- (void)loadFile
{
	stringData = [[NSMutableArray alloc] initWithCapacity:0];
	intData = [[NSMutableArray alloc] initWithCapacity:0];
	floatData = [[NSMutableArray alloc] initWithCapacity:0];
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

	//Float추가되면서 Ver올림
	if (ver <= 2)
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

		if (ver >= 2)
		{
			count = readInt(readFile);
			for (int i=0; i<count; ++i)
			{
				FloatData* data = [FloatData alloc];
				[data loadData:readFile];
				[floatData addObject:data];
			}
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

- (int)getIntData:(NSString*)key idx:(int)idx base:(int)base
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

- (float)getFloatData:(NSString*)key idx:(int)idx base:(float)base;
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
	
	for (id data in floatData)
	{
		FloatData* fData = (FloatData*)data;
		if ((keyIdx == [fData keyIdx]) && (idx == [fData idx]))
		{
			return [fData getValue];
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

- (void)setFloatData:(NSString*)key idx:(int)idx value:(float)value
{
	int keyIdx;
	DataKey* kd;
	FloatData* fData;
	
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
	
	for (id data in floatData)
	{
		fData = (FloatData*)data;
		if ((keyIdx == [fData keyIdx]) && (idx == [fData idx]))
		{
			if ([fData getValue] != value)
			{
				isDirty = true;
				[fData setValue:value];
			}
			return;
		}
	}
	
	fData = [FloatData alloc];
	[fData setKeyIdx:keyIdx];
	[fData setIdx:idx];
	[fData setValue:value];
	
	[floatData addObject:fData];
	
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
			if ([value compare:[sData getValue]] != NSOrderedSame)
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
