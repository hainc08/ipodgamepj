#define MaxTop10Count 5

typedef struct
{
	NSString* playerName;
	int score[5];
	int totScore;
} ScoreCon;

typedef struct
{
	ScoreCon rank[10];
} Top10;

@interface HighScoreManager : NSObject
{	
	//5개만 만들어둔다. (플렉서블과는 안드로메다급 거리있는 코딩...쿠쿠쿠...) 
	Top10 top10s[MaxTop10Count];
}

+ (HighScoreManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadFromFile;
- (void)saveToFile;
- (int)addNewScore:(ScoreCon)score;
- (int)addNewScore:(ScoreCon)score index:(int)idx;

@end
