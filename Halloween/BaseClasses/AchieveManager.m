#import "AchieveManager.h"
#import "FileIO.h"

static AchieveManager *AchieveManagerInst;

@implementation AchieveManager

+ (AchieveManager*)getInstance
{
	return AchieveManagerInst;
}

+ (void)initManager;
{
	AchieveManagerInst = [AchieveManager alloc];
	[AchieveManagerInst loadFile];
	[AchieveManagerInst resumeTimer];
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
	NSString* saveFile = [NSString stringWithFormat: @"%@/Achievement.dat", recordingDirectory];
	
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

	for (int i = 0; i<50; ++i)
	{
		if (achieves[i].isGet) writeInt(writeFile, 1);
		else writeInt(writeFile, 0);
		
		writeInt(writeFile, achieves[i].data);
	}
	
	[writeFile closeFile];

	isDirty = false;
}

- (void)resumeTimer
{
	return;
	//10초단위로 저장하자...
	updateTimer = [[NSTimer scheduledTimerWithTimeInterval: 10.f
													target: self
												  selector: @selector(saveFile)
												  userInfo: self
												   repeats: YES] retain];	
}

- (void)loadFile
{
	//최초 셋팅...
	for (int i=0; i<50; ++i)
	{
		achieves[i].isGet = false;
		achieves[i].data = 0;
		achieves[i].event = -1;
		achieves[i].param1 = -1;
		achieves[i].param2 = -1;
		achieves[i].param3 = -1;
	}

	curAdd = 0;

	[self addEvent:KillGhost :1 :-1 :-1 :-1 :@"First Kill" :0 :@"Kill any Ghost"];
	
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/Achievement.dat", recordingDirectory];
	
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
	if(readFile == nil) return;
	
	//버전정보확인
	int ver = readInt(readFile);

	//Float추가되면서 Ver올림
	if (ver <= 1)
	{
		for (int i = 0; i<50; ++i)
		{
			achieves[i].isGet = (readInt(readFile) == 1);
			achieves[i].data = readInt(readFile);
		}
	}
	
	[readFile closeFile];
	
	isDirty = false;
}

- (void)event:(int)event :(int)param1 :(int)param2 :(int)param3
{
	return;

	for (int i=0; i<50; ++i)
	{
		if (achieves[i].isGet) continue;

		if (achieves[i].event == event)
		{
			if (achieves[i].param1 != -1)
			{
				if (achieves[i].param1 != param1) break;
			}
			if (achieves[i].param2 != -1)
			{
				if (achieves[i].param2 != param1) break;
			}
			if (achieves[i].param3 != -1)
			{
				if (achieves[i].param3 != param1) break;
			}
			continue;
		EVENTOK:
			++achieves[i].data;
			if (achieves[i].data >= achieves[i].goal)
			{
				//회면에 띄워주자...
				achieves[i].isGet = true;
			}
			
			isDirty = true;
		}
	}
}

- (void)addEvent:(int)event :(int)goal :(int)param1 :(int)param2 :(int)param3 :(NSString*)name :(int)iconIdx :(NSString*)desc
{
	Achieve* achieve = &achieves[curAdd];
	achieve->event = event;
	achieve->goal = goal;
	achieve->param1 = param1;
	achieve->param2 = param2;
	achieve->param3 = param3;
	achieve->name = name;
	achieve->iconIdx = iconIdx;
	achieve->desc = desc;

	++curAdd;
}

@end
