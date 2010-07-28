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

@implementation SaveManager

@synthesize opt1;
@synthesize opt2;

+ (SaveManager*)getInstance
{
	return SaveManagerInst;
}

+ (void)initManager;
{
	SaveManagerInst = [SaveManager alloc];
	[SaveManagerInst loadSaveFile];
	[SaveManagerInst loadOptionFile];
	[SaveManagerInst loadSceneExpFile];
	[SaveManagerInst resetFlag];
}

- (void)closeManager
{

}

- (void)resetFlag
{
	memset(flag, 0x00, 20);
	memset(flag2, 0x00, 30);
	
	for (int i=0; i<28; ++i)
	{
		saveFlag[i] = nil;
		saveFlag2[i] = nil;
	}
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
	memcpy(flag, saveFlag[idx], 20);
	memcpy(flag2, saveFlag2[idx], 30);
}

- (void)saveSaveFile
{
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/save.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
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

				NSData *data;
				data = [readFile readDataOfLength:sizeof(char)*20];
				saveFlag[i] = (char*)malloc(20);
				[data getBytes:saveFlag[i]];
				data = [readFile readDataOfLength:sizeof(char)*30];
				saveFlag2[i] = (char*)malloc(30);
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/extra.dat", recordingDirectory];
	
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

	for (int i=0; i<15; ++i)
	{
		writeInt(writeFile, [[DataManager getInstance] getEventData:i]);
	}
    
	[writeFile closeFile];
}

- (void)loadExtraFile
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/extra.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];

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

	if (ver == 1)
	{
		for (int i=0; i<15; ++i)
		{
			[[DataManager getInstance] setEventData:i :readInt(readFile)];
		}
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/music.dat", recordingDirectory];
	
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
	
	for (int i=0; i<34; ++i)
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/music.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
	if(readFile == nil)
	{
		return;
	}

	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		for (int i=0; i<34; ++i)
		{
			int temp = readInt(readFile);
			if (temp != 0)
			{
				[[DataManager getInstance] setMusicShow:i];
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/option.dat", recordingDirectory];
	
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

	writeInt(writeFile, opt1);
	writeInt(writeFile, opt2);
    
	[writeFile closeFile];
}

- (void)loadOptionFile
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/option.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
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
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/sceneExp.dat", recordingDirectory];
	
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

	[writeFile writeData: [NSData dataWithBytes:sceneExp
										 length:127]];
    
	[writeFile closeFile];
}

- (void)loadSceneExpFile
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/sceneExp.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
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
	return sceneExp[idx];
}

- (void)save:(int)idx data:(int)data
{
	saveData[idx] = data;
	saveDate[idx] = [[NSDate date] timeIntervalSince1970];
	if (saveFlag[idx] == nil) saveFlag[idx] = (char*)malloc(20);
	if (saveFlag2[idx] == nil) saveFlag2[idx] = (char*)malloc(30);
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
