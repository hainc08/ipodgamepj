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
}

- (void)loadFromFile
{
	//파일에서 점수정보를 읽어들인다.
	for (int i=0; i<MaxTop10Count; ++i)
	{
		for (int j=0; j<10; ++j)
		{
			top10s[i].rank[j].totScore = -1;
			top10s[i].rank[j].score[0] = 0;
			top10s[i].rank[j].score[1] = 0;
			top10s[i].rank[j].score[2] = 0;
			top10s[i].rank[j].score[3] = 0;
			top10s[i].rank[j].score[4] = 0;
		}
	}
}

//들어온 점수가 몇 등인지를 리턴한다.
- (int)addNewScore:(ScoreCon)score
{
	return [self addNewScore:score index:0];
}

- (int)addNewScore:(ScoreCon)score index:(int)idx
{
	if (idx >= MaxTop10Count) return -1;
	ScoreCon scoreTemp;
	
	for(int i=0; i<10; ++i)
	{
		if(top10s[idx].rank[i].totScore == -1)
		{
			top10s[idx].rank[i] = score;
			[self saveToFile];
			return i;
		}
		
		if(top10s[idx].rank[i].totScore <= score.totScore)
		{
			for(int j=i; j<10; ++j)
			{
				scoreTemp = top10s[idx].rank[j];
				top10s[idx].rank[j] = score;
				score = scoreTemp;
			}
			[scoreTemp.playerName release];
			[self saveToFile];
			return i;
		}
	}
	return -1;
}

@end
