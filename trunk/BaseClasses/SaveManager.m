#import "SaveManager.h"
#import "DataManager.h"

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
	[SaveManagerInst resetFlag];
}

- (void)closeManager
{

}

- (void)resetFlag
{
	memset(flag, 0x00, 20);
	memset(flag2, 0x00, 30);
}

- (void)setFlag:(int)idx
{
	if (idx > 500) idx -= 400;
	int i = (int)(idx / 8);
	int j = idx % 8;
	flag[i] |= (0x01 << j);
}

- (bool)getFlag:(int)idx
{
	if (idx > 500) idx -= 400;
	int i = (int)(idx / 8);
	int j = idx % 8;
	return ((flag[i] & (0x01 << j)) != 0x00);
}

- (void)setFlag2:(int)idx data:(int)data
{
	idx -= 400;
	flag2[idx] = (char)data;
}

- (int)getFlag2:(int)idx
{
	idx -= 400;
	return (int)flag2[idx];
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
	else
	{
		for (int i=0; i<28; ++i)
		{
			writeInt(writeFile, saveData[i]);
			if (saveData[i] > 0) writeInt(writeFile, saveDate[i]);
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
	
	for (int i=0; i<28; ++i)
	{
		saveData[i] = readInt(readFile);
		if (saveData[i] > 0) saveDate[i] = readInt(readFile);
	}
	
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
	else
	{
		for (int i=0; i<15; ++i)
		{
			writeInt(writeFile, [[DataManager getInstance] getEventData:i]);
		}
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
	
	for (int i=0; i<15; ++i)
	{
		[[DataManager getInstance] setEventData:i :readInt(readFile)];
	}

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
	else
	{
		for (int i=0; i<34; ++i)
		{
			if ([[DataManager getInstance] getMusicShow:i])
				writeInt(writeFile, 1);
			else
				writeInt(writeFile, 0);
		}
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
	
	for (int i=0; i<34; ++i)
	{
		int temp = readInt(readFile);
		if (temp != 0)
		{
			[[DataManager getInstance] setMusicShow:i];
		}
	}
	
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
	else
	{
		writeInt(writeFile, opt1);
		writeInt(writeFile, opt2);
	}
    
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
		}
		return;
	}
	
	opt1 = readInt(readFile);
	opt2 = readInt(readFile);
	
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

- (void)save:(int)idx data:(int)data
{
	saveData[idx] = data;
	saveDate[idx] = [[NSDate date] timeIntervalSince1970];
	
	[self saveSaveFile];
}

- (void)setOpt:(int)o1 :(int)o2
{
	opt1 = o1;
	opt2 = o2;
	[self saveOptionFile];
}

@end
