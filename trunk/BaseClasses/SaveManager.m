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

+ (SaveManager*)getInstance
{
	return SaveManagerInst;
}

+ (void)initManager;
{
	SaveManagerInst = [SaveManager alloc];
	[SaveManagerInst loadSaveFile];
}

- (void)closeManager
{

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

@end
