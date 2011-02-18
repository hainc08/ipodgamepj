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
