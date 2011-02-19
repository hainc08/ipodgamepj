int readInt(NSFileHandle* readFile);
void writeInt(NSFileHandle* writeFile, int value);
float readFloat(NSFileHandle* readFile);
void writeFloat(NSFileHandle* writeFile, float value);
void writeString(NSFileHandle* writeFile, NSString* value);
NSString* readString(NSFileHandle* readFile);

NSFileHandle* openFileToRead(NSString* name);
NSFileHandle* makeFileToWrite(NSString* name);
bool deleteFile(NSString* name);
void closeFile(NSFileHandle* fileHandle);
