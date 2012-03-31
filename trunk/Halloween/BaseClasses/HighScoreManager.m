#import "HighScoreManager.h"
static HighScoreManager *highScoreManagerInst;

@implementation HighScoreManager

+ (HighScoreManager*)getInstance
{
	return highScoreManagerInst;
}

+ (void)initManager;
{
	highScoreManagerInst = [HighScoreManager alloc];
	highScoreManagerInst->dOK = false;
	[highScoreManagerInst loadFromFile];
}

- (void)closeManager
{
	for (int i=0; i<MaxTop10Count; ++i)
	{
		for (int j=0; j<10; ++j)
		{
			[top10s[i].rank[j].playerName release];
		}
	}
}

- (void)saveToFile
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/highScore.dat", recordingDirectory];
	
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
		for (int i=0; i<MaxTop10Count; ++i)
		{
			for (int j=0; j<10; ++j)
			{
				ScoreCon* con = &top10s[i].rank[j];
				NSData* d = [con->playerName dataUsingEncoding:NSUTF8StringEncoding];
				int len = [d length];
				
				[writeFile writeData: [NSData dataWithBytes:&len
													 length:sizeof(int)]];
				[writeFile writeData: d];
				[writeFile writeData: [NSData dataWithBytes:&con->score
													 length:sizeof(int)]];
				[writeFile writeData: [NSData dataWithBytes:&con->isSubmit
													 length:sizeof(int)]];
			}
		}
		[writeFile writeData: [NSData dataWithBytes:&dOK
											 length:sizeof(bool)]];
	}
    
	[writeFile closeFile];
}

- (void)loadFromFile
{
	NSArray *filePaths =	NSSearchPathForDirectoriesInDomains (
																 NSDocumentDirectory, 
																 NSUserDomainMask,
																 YES
																 ); 
	NSString* recordingDirectory = [filePaths objectAtIndex: 0];
	NSString* saveFile = [NSString stringWithFormat: @"%@/highScore.dat", recordingDirectory];
	
	NSFileHandle *readFile;
	
	readFile = [NSFileHandle fileHandleForReadingAtPath:saveFile];
	
	if(readFile == nil)
	{
		return;
	}
	
    {
		for (int i=0; i<MaxTop10Count; ++i)
		{
			for (int j=0; j<10; ++j)
			{
				ScoreCon* con = &top10s[i].rank[j];
				
				int len;
				NSData *lenData = [readFile readDataOfLength:sizeof(int)];
				[lenData getBytes:&len];
				
				NSData *data = [readFile readDataOfLength:len];
				con->playerName = [[NSString alloc] initWithData: data 
														encoding: NSUTF8StringEncoding];
				
				NSData *scoreData = [readFile readDataOfLength:sizeof(int)];
				[scoreData getBytes:&con->score];

				NSData *submitData = [readFile readDataOfLength:sizeof(int)];
				[submitData getBytes:&con->isSubmit];
			}
		}
		
		NSData *dokData = [readFile readDataOfLength:sizeof(bool)];
		[dokData getBytes:&dOK];
	}
	
	[readFile closeFile];
}

//들어온 점수가 몇 등인지를 리턴한다.
- (int)addNewScore:(ScoreCon)score
{
	return [self addNewScore:score index:0];
}

- (int)addNewScore:(ScoreCon)score index:(int)idx
{
	if (idx >= MaxTop10Count) return -1;
	
	int rank = [self findRank:score.score index:idx];
	
	if (rank == -1) return -1;
	
	for(int i=9; i>rank; --i)
	{
		top10s[idx].rank[i] = top10s[idx].rank[i-1];
	}

	top10s[idx].rank[rank] = score;

	[self saveToFile];
	return rank;
}

- (bool)getDescOK
{
	return dOK;
}

- (void)DescOK
{
	dOK = true;
	[self saveToFile];
}

- (void)setPlayerName:(int)setIdx index:(int)idx name:(NSString*)pName
{
	top10s[setIdx].rank[idx].playerName = pName;
	[self saveToFile];
}

- (void)setSubmitInfo:(int)setIdx index:(int)idx
{
	top10s[setIdx].rank[idx].isSubmit = true;
	[self saveToFile];	
}

- (bool)isSubmit:(int)idx rank:(int)rank
{
	return (top10s[idx].rank[rank].isSubmit == 1);
}

- (int)findRank:(int)score index:(int)idx
{
	if (idx >= MaxTop10Count) return -1;
	
	for(int i=0; i<10; ++i)
	{
		if(top10s[idx].rank[i].score == 0) return i;
		if(top10s[idx].rank[i].score <= score) return i;
	}
	return -1;
}

- (ScoreCon)getScoreCon:(int)setIdx index:(int)idx
{
	return top10s[setIdx].rank[idx];
}

- (int)getHighScore:(int)idx
{
	return top10s[idx].rank[0].score;
}

- (void)resetScore:(int)level
{
	for(int i=0; i<10; ++i)
	{
		top10s[level].rank[i].playerName = @"";
		top10s[level].rank[i].score = 0;
		top10s[level].rank[i].isSubmit = false;
	}
}

@end
