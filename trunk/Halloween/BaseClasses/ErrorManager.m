#import "ErrorManager.h"
static ErrorManager *errorManagerInst;

@implementation ErrorManager

+ (ErrorManager*)getInstance
{
	return errorManagerInst;
}

+ (void)initManager
{
	errorManagerInst = [ErrorManager alloc];
}

- (void)closeManager
{

}

- (void)ERROR:(char*)msg value:(int)val
{
	FILE* hFile = fopen("ERROR.txt", "w");
	fprintf(hFile, "%s - Value : %d", msg, val);
	fclose(hFile);
	
	exit(0);
}

- (void)AddTrack:(char*)msg value:(int)val
{
	FILE* hFile = fopen("Track.txt", "r+");

	fseek(hFile,0L,SEEK_END);

	fprintf(hFile, "%s - Value : %d\n", msg, val);
	fclose(hFile);
}

- (void)ClearTrack
{
	FILE* hFile = fopen("Track.txt", "w");
	fprintf(hFile, "Start\n");
	fclose(hFile);
}

@end
