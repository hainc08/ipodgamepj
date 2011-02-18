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

@end
