#define MaxTop10Count 2

typedef struct
{
	NSString* playerName;
	int score;
	int isSubmit;	
} ScoreCon;

typedef struct
{
	ScoreCon rank[10];
} Top10;

@interface HighScoreManager : NSObject
{	
	//5개만 만들어둔다. (플렉서블과는 안드로메다급 거리있는 코딩...쿠쿠쿠...) 
	Top10 top10s[MaxTop10Count];

	bool dOK;
}

+ (HighScoreManager*)getInstance;
+ (void)initManager;
- (void)closeManager;

- (void)loadFromFile;
- (void)saveToFile;
- (int)findRank:(int)score index:(int)idx;
- (int)addNewScore:(ScoreCon)score;
- (int)addNewScore:(ScoreCon)score index:(int)idx;
- (ScoreCon)getScoreCon:(int)setIdx index:(int)idx;
- (int)getHighScore:(int)idx;
- (void)setPlayerName:(int)setIdx index:(int)idx name:(NSString*)pName;
- (void)resetScore:(int)level;
- (void)setSubmitInfo:(int)setIdx index:(int)idx;
- (bool)isSubmit:(int)idx rank:(int)rank;

- (bool)getDescOK;
- (void)DescOK;

@end
