#import "SaveManager.h"

//제너럴한 세이브시스템을 목표로 만든 메니저
//많은 양의 데이터를 처리하기에는 무리가 있지만 적응량의 데이터를 편리하게 관리하고자 만들었심
//계속 업데이트 시켜서 쓸만하게 만들 예정 by Sasin...

//setIntData, setStringData를 사용하고 나서는 꼭 [[SaveManager getInstance] saveFile]을 호출해야함
//setIntData, setStringData를 여러번 호출하면 그 때마다 saveFile이 호출되는 걸 방지하기 위해서
//해당 함수를 명시적으로 호출해야한다.

//사용예
//[[SaveManager getInstance] setIntData:@"key1" idx:0 value:100];
//[[SaveManager getInstance] setIntData:@"key1" idx:2 value:200];
//[[SaveManager getInstance] setStringData:@"key2" idx:0 value:@"Sasin!!!"];
//[[SaveManager getInstance] saveFile];

static SaveManager *SaveManagerInst;

int readInt(NSFileHandle* readFile)
{
	int temp;

	NSData *data;
	data = [readFile readDataOfLength:sizeof(int)];
	[data getBytes:&temp];

	return temp;
}

void writeInt(NSFileHandle* writeFile, int value)
{
	[writeFile writeData: [NSData dataWithBytes:&value
										 length:sizeof(int)]];
}

void writeString(NSFileHandle* writeFile, NSString* value)
{
	NSData* d = [value dataUsingEncoding:NSUTF8StringEncoding];
	int len = [d length];
	
	[writeFile writeData: [NSData dataWithBytes:&len
										 length:sizeof(int)]];
	[writeFile writeData: d];
}

NSString* readString(NSFileHandle* readFile)
{
	int len;
	NSData *lenData = [readFile readDataOfLength:sizeof(int)];
	[lenData getBytes:&len];
	
	NSData *data = [readFile readDataOfLength:len];
	NSString* result = [[NSString alloc] initWithData: data 
											encoding: NSUTF8StringEncoding];
	return result;
}

@implementation DataKey
@synthesize key;
@synthesize idx;
@end

@implementation BaseData
@synthesize keyIdx;
@synthesize idx;
-(void)saveData:(NSFileHandle*)writeFile{}
-(void)loadData:(NSFileHandle*)loadFile{}
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

	[writeFile closeFile];

	isDirty = false;
}

- (void)loadFile
{
	stringData = [NSMutableArray alloc];
	intData = [NSMutableArray alloc];
	
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
		for (int i=0; i<count; +i)
		{
			StringData* data = [StringData alloc];
			[data loadData:readFile];
			[stringData addObject:data];
		}
		
		count = readInt(readFile);
		for (int i=0; i<count; +i)
		{
			IntData* data = [IntData alloc];
			[data loadData:readFile];
			[intData addObject:data];
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

	kd = [DataKey alloc];
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
	
	kd = [DataKey alloc];
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
}

@end
