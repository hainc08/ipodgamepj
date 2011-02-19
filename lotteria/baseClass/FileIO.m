#import "FileIO.h"

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

float readFloat(NSFileHandle* readFile)
{
	float temp;
	
	NSData *data;
	data = [readFile readDataOfLength:sizeof(float)];
	[data getBytes:&temp];
	
	return temp;
}

void writeFloat(NSFileHandle* writeFile, float value)
{
	[writeFile writeData: [NSData dataWithBytes:&value
										 length:sizeof(float)]];
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

NSFileHandle* openFileToRead(NSString* name)
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* filename = [NSString stringWithFormat: @"%@/%@", recordingDirectory, name];
	
	return [NSFileHandle fileHandleForReadingAtPath:filename];
}

NSFileHandle* makeFileToWrite(NSString* name)
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* filename = [NSString stringWithFormat: @"%@/%@", recordingDirectory, name];
	
	NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:filename];
	
	if (file == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:filename
												contents:nil attributes:nil];
		
		file = [NSFileHandle fileHandleForWritingAtPath:filename];
	}
	
	return file;
}

bool deleteFile(NSString* name)
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* filename = [NSString stringWithFormat: @"%@/%@", recordingDirectory, name];
	return [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
}

void closeFile(NSFileHandle* fileHandle)
{
	[fileHandle closeFile];
}
