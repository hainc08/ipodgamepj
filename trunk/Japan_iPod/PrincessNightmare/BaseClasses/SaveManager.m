#import "SaveManager.h"
#import "DataManager.h"
#import "ErrorManager.h"
#import "SoundManager.h"

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

char readChar(NSFileHandle* readFile)
{
	int temp;
	
	NSData *data;
	data = [readFile readDataOfLength:sizeof(char)];
	[data getBytes:&temp];
	
	return temp;
}

void writeChar(NSFileHandle* writeFile, char value)
{
	[writeFile writeData: [NSData dataWithBytes:&value
										 length:sizeof(char)]];
}

@implementation SaveManager

@synthesize opt1;
@synthesize opt2;
@synthesize lastPage;

+ (SaveManager*)getInstance
{
	return SaveManagerInst;
}

+ (void)initManager;
{
	SaveManagerInst = [SaveManager alloc];
	
	[SaveManagerInst setLastPage:0];
	
	[SaveManagerInst initFilePath];
	[SaveManagerInst loadSaveFile];
	[SaveManagerInst loadOptionFile];
	[SaveManagerInst loadSceneExpFile];
	[SaveManagerInst loadMusicFile];
	[SaveManagerInst loadSceneExp2File];
	[SaveManagerInst loadItemFlagFile];
	[SaveManagerInst loadExtraFile];
	[SaveManagerInst resetFlag];
}

- (void)closeManager
{

}

- (void)initFilePath
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	saveFileName = [[NSString stringWithFormat: @"%@/save.dat", recordingDirectory] retain];
	extraFileName = [[NSString stringWithFormat: @"%@/extra.dat", recordingDirectory] retain];
	musicFileName = [[NSString stringWithFormat: @"%@/music.dat", recordingDirectory] retain];
	optionFileName = [[NSString stringWithFormat: @"%@/option.dat", recordingDirectory] retain];
	sceneExpFileName = [[NSString stringWithFormat: @"%@/sceneExp.dat", recordingDirectory] retain];
	sceneExp2FileName = [[NSString stringWithFormat: @"%@/sceneExp2.dat", recordingDirectory] retain];
	itemFlagFileName = [[NSString stringWithFormat: @"%@/itemFlag.dat", recordingDirectory] retain];
}

- (void)resetFlag
{
	memset(flag, 0x00, 20);
	memset(flag2, 0x00, 30);
	
	for (int i=0; i<28; ++i)
	{
		memset(saveFlag[i], 0x00, 20);
		memset(saveFlag2[i], 0x00, 30);
	}

	sceneExpDirty = 0;
}

- (void)setFlag:(int)idx
{
#ifdef __DEBUGGING__
	int originIdx = idx;
#endif

	if (idx > 500) idx -= 400;
	int i = (int)(idx / 8);
	int j = idx % 8;

#ifdef __DEBUGGING__	
	if (i > 19) [[ErrorManager getInstance] ERROR:"setFlag : flag개수 초과" value:originIdx];
#endif
	
	flag[i] |= (0x01 << j);
}

- (bool)getFlag:(int)idx
{
#ifdef __DEBUGGING__
	int originIdx = idx;
#endif

	if (idx > 500) idx -= 400;
	int i = (int)(idx / 8);
	int j = idx % 8;

#ifdef __DEBUGGING__	
	if (i > 19) [[ErrorManager getInstance] ERROR:"getFlag : flag개수 초과" value:originIdx];
#endif
	
	return ((flag[i] & (0x01 << j)) != 0x00);
}

- (void)setFlag2:(int)idx data:(int)data
{
#ifdef __DEBUGGING__	
	if ((idx < 400) || (idx > 429)) [[ErrorManager getInstance] ERROR:"setFlag2 : flag개수 초과" value:idx];
#endif
	
	idx -= 400;
	flag2[idx] = (char)data;
}

- (int)getFlag2:(int)idx
{
#ifdef __DEBUGGING__	
	if ((idx < 400) || (idx > 429)) [[ErrorManager getInstance] ERROR:"getFlag2 : flag개수 초과" value:idx];
#endif
	
	idx -= 400;
	return (int)flag2[idx];
}

- (void)setFlagData:(int)idx
{
	if (idx == -1)
	{
		memset(flag, 0x00, 20);
		memset(flag2, 0x00, 30);
	}
	else
	{
		memcpy(flag, saveFlag[idx], 20);
		memcpy(flag2, saveFlag2[idx], 30);
	}
}

- (void)saveSaveFile
{	
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:saveFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:saveFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:saveFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}
	
	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);
	
	for (int i=0; i<28; ++i)
	{
		writeInt(writeFile, saveData[i]);
		if (saveData[i] > 0)
		{
			writeInt(writeFile, saveDate[i]);
			[writeFile writeData: [NSData dataWithBytes:saveFlag[i]
												 length:sizeof(char) * 20]];
			[writeFile writeData: [NSData dataWithBytes:saveFlag2[i]
												 length:sizeof(char) * 30]];
		}
	}
	
	[writeFile closeFile];
}

- (void)loadSaveFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFileName];
	
	if(readFile == nil)
	{
		for (int i=0; i<28; ++i)
		{
			saveData[i] = 0;
		}
		return;
	}

	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		for (int i=0; i<28; ++i)
		{
			saveData[i] = readInt(readFile);
			if (saveData[i] > 0)
			{
				saveDate[i] = readInt(readFile);

				memset(saveFlag[i], 0x00, 20);
				memset(saveFlag2[i], 0x00, 30);

				NSData *data;
				data = [readFile readDataOfLength:sizeof(char)*20];
				[data getBytes:saveFlag[i]];
				data = [readFile readDataOfLength:sizeof(char)*30];
				[data getBytes:saveFlag2[i]];
			}
		}
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadSaveFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];
}

- (void)saveExtraFile
{
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:extraFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:extraFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:extraFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}

	//버전정보심기
	int ver = 2;
	writeInt(writeFile, ver);

	for (int i=0; i<EVENTCOUNT; ++i)
	{
		writeChar(writeFile, [[DataManager getInstance] getEventData:i]);
	}
    
	[writeFile closeFile];
}

- (void)loadExtraFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:extraFileName];

	if(readFile == nil)
	{
		for (int i=0; i<15; ++i)
		{
			[[DataManager getInstance] setEventData:i :0];
		}
		return;
	}

	//버전정보확인
	int ver = readInt(readFile);

	if (ver == 2)
	{
		for (int i=0; i<EVENTCOUNT; ++i)
		{
			[[DataManager getInstance] setEventData:i :readChar(readFile)];
		}
	}
	else
	{
		//이걸 어떻게 변환한다?
//		for (int i=0; i<15; ++i)
//		{
//			[[DataManager getInstance] setEventData:i :readInt(readFile)];
//		}
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadExtraFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];
}

- (void)saveMusicFile
{
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:musicFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:musicFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:musicFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}

	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);
	
	for (int i=0; i<35; ++i)
	{
		if ([[DataManager getInstance] getMusicShow:i])
			writeInt(writeFile, 1);
		else
			writeInt(writeFile, 0);
	}
    
	[writeFile closeFile];
}

- (void)loadMusicFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:musicFileName];
	
	if(readFile == nil)
	{
		return;
	}

	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		for (int i=0; i<35; ++i)
		{
			int temp = readInt(readFile);
			if (temp != 0)
			{
				[[DataManager getInstance] setMusicShowWithoutSave:i];
			}
		}
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadMusicFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];
}

- (void)saveOptionFile
{
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:optionFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:optionFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:optionFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}

	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);

	writeInt(writeFile, opt1);
	writeInt(writeFile, opt2);
    
	[writeFile closeFile];
}

- (void)loadOptionFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:optionFileName];
	
	if(readFile == nil)
	{
		for (int i=0; i<15; ++i)
		{
			opt1 = opt2 = 3;

			[[SoundManager getInstance] setBGMVolume:(opt1 - 1) * 0.25f];
			[[SoundManager getInstance] setFxVolume:(opt2 - 1) * 0.25f];
		}
		return;
	}
	
	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		opt1 = readInt(readFile);
		opt2 = readInt(readFile);

		[[SoundManager getInstance] setBGMVolume:(opt1 - 1) * 0.25f];
		[[SoundManager getInstance] setFxVolume:(opt2 - 1) * 0.25f];
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadOptionFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];
}

- (void)saveSceneExpFile
{
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:sceneExpFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:sceneExpFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:sceneExpFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}

	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);

	[writeFile writeData: [NSData dataWithBytes:sceneExp
										 length:127]];
    
	[writeFile closeFile];
}

- (void)loadSceneExpFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:sceneExpFileName];
	
	if(readFile == nil)
	{
		memset(sceneExp, 0x00, 127);
		return;
	}
	
	//버전정보확인
	int ver = readInt(readFile);

	if (ver == 1)
	{
		NSData *data;
		data = [readFile readDataOfLength:127];
		[data getBytes:sceneExp];
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadSceneExpFile : 버전정보이상" value:0];
	}
#endif

	[readFile closeFile];
}

- (int)getSaveData:(int)idx
{
	return saveData[idx];
}

- (NSDate*)getSaveDate:(int)idx
{
	return [NSDate dateWithTimeIntervalSince1970:saveDate[idx]];
}

- (void)setSceneExp:(int)idx
{
	if (sceneExp[idx]) return;
	
	sceneExp[idx] = true;
	[self saveSceneExpFile];
}

- (bool)getSceneExp:(int)idx
{
	return true;
	return sceneExp[idx];
}

- (void)saveSceneExp2File:(bool)force
{
	if (sceneExpDirty == 0) return;

	if (!force && (sceneExpDirty < 30)) return;
	
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:sceneExp2FileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:sceneExp2FileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:sceneExp2FileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}
	
	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);
	
	[writeFile writeData: [NSData dataWithBytes:sceneExp2
										 length:2757]];
    
	[writeFile closeFile];

	sceneExpDirty = false;
}

- (void)loadSceneExp2File
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:sceneExp2FileName];
	
	if(readFile == nil)
	{
		memset(sceneExp2, 0x00, 2757);
		return;
	}
	
	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		NSData *data;
		data = [readFile readDataOfLength:2757];
		[data getBytes:sceneExp2];
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadSceneExpFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];

	sceneExpDirty = 0;
}

- (void)setSceneExp2:(int)idx
{
	int i = (int)(idx / 8);
	if ([self getSceneExp2:idx]) return;
	sceneExp2[i] |= 0x01 << (idx % 8);
	++sceneExpDirty;
	
	[self saveSceneExp2File:false];
}

- (bool)getSceneExp2:(int)idx
{
	return true;
	int i = (int)(idx / 8);
	int check = sceneExp2[i] & (0x01 << (idx % 8));
	return (check != 0);
}

- (void)setItemFlag:(int)idx
{
	if (itemFlag[idx]) return;

	itemFlag[idx] = true;
	[self saveItemFlagFile];
}

- (bool)getItemFlag:(int)idx
{
	return itemFlag[idx];
}

- (void)saveItemFlagFile
{
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:itemFlagFileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:itemFlagFileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:itemFlagFileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}
	
	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);
	
	for (int i=0; i<23; ++i)
	{
		if (itemFlag[i])
			writeInt(writeFile, 1);
		else
			writeInt(writeFile, 0);
	}
    
	[writeFile closeFile];
}

- (void)loadItemFlagFile
{
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:itemFlagFileName];
	
	if(readFile == nil)
	{
		for (int i=0; i<23; ++i)
		{
			itemFlag[i] = false;
		}
		return;
	}
	
	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		int value;
		for (int i=0; i<23; ++i)
		{
			value = readInt(readFile);
			itemFlag[i] = (value == 1);
		}
	}
#ifdef __DEBUGGING__	
	else
	{
		[[ErrorManager getInstance] ERROR:"loadSaveFile : 버전정보이상" value:0];
	}
#endif
	
	[readFile closeFile];
}

- (void)save:(int)idx data:(int)data
{
	saveData[idx] = data;
	saveDate[idx] = [[NSDate date] timeIntervalSince1970];
	memcpy(saveFlag[idx], flag, 20);
	memcpy(saveFlag2[idx], flag2, 30);
	
	[self saveSaveFile];
}

- (void)setOpt:(int)o1 :(int)o2
{
	opt1 = o1;
	opt2 = o2;
	[self saveOptionFile];
}

@end
