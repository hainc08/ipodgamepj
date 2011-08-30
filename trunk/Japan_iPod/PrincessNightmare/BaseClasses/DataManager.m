#import "DataManager.h"
#import "SaveManager.h"
#import <sys/time.h>

//Tag정보와 Index정보 미리 읽어오기위한 부분
//실제로 어플이 돌아갈 때는 필요없는 부분이라 주석처리...
//int tagData[1000000];
//int indexData[1000000];
//int nowIdx;
//int nowScene;
//int tagCount = 0;
//int maxIndex = 0;

int readInteger(char* data, int* offset)
{
	int intVal = 0;
	int offsetVal = *offset;
	
	while(1)
	{
		if ((data[offsetVal] == ',')||
			(data[offsetVal] == ';')||
			(data[offsetVal] == ']')) break;
		
		if (data[offsetVal] != ' ') intVal = intVal * 10 + (data[offsetVal] - '0');
		
		++offsetVal;
	}
	
	++offsetVal;
	
	*offset = offsetVal;
	
	return intVal;
}

NSString* readString(char* data, int* offset)
{
	int idx = 0;
	char temp[256];
	bool isStart = false;
	int offsetVal = *offset;
	
	while(1)
	{
		if (data[offsetVal] == '"')
		{
			if (isStart) break;
			
			++offsetVal;
			isStart = true;
			continue;
		}
		
		if (isStart)
		{
			//라인피드를 처리할래니 일본어 인코딩되면서 \문자가 정상적으로 인식이 되지 않는다.
			//고로 라인피드를 문자열 속에서 안쓰이는 z 문자를 이용해서 처리하는 꼼수를 좀 쓴다.
			if (data[offsetVal] == 'z')
			{
				temp[idx] = '\r';
			}
			else 
			{
				temp[idx] = data[offsetVal];
			}

			++idx;
		}
		
		++offsetVal;
	}
	
//	Tag, Index 프리로딩
//	if ((temp[0] == 't')&&(temp[1] == 'a')&&(temp[2] == 'g')&&(temp[3] == '_'))
//	{
//		int test = 0;
//
//		for (int i=4; i<idx; ++i)
//		{
//			test = test * 10 + (temp[i] - '0');
//		}
//
//		if (tagData[nowScene * 1000 + test] == 0) ++tagCount;
//		tagData[nowScene * 1000 + test] = nowIdx;
//	}
//
//	if ((temp[0] == 'i')&&(temp[1] == 'n')&&(temp[2] == 'd')&&(temp[3] == 'e')&&(temp[4] == 'x')&&(temp[5] == '_'))
//	{
//		int test = 0;
//		
//		for (int i=6; i<idx; ++i)
//		{
//			test = test * 10 + (temp[i] - '0');
//		}
//		if (test > maxIndex) maxIndex = test;
//		indexData[test] = nowIdx;
//	}
	
	offsetVal += 2;
	temp[idx] = '\0';
	
	*offset = offsetVal;
	
	NSString* str = [[NSString alloc] initWithUTF8String:temp];
	return str;
}

static DataManager *DataManagerInst;
static NSString* ResourcePath;

@implementation Scenario

@synthesize startIdx;
@synthesize endIdx;

- (void)setIntVal:(int)idx val:(int)val
{
	intVal[idx] = val;
}

- (int)getIntVal:(int)idx
{
	return intVal[idx];
}

- (void)setStrVal:(NSString*)val
{
	strVal = val;
}

- (NSString*)getStrVal
{
	return strVal;
}

@end

@implementation VName

@synthesize valCount;

- (void)addStrVal:(NSString*)val
{
	strVal[valCount] = val;
	++valCount;
}

- (NSString*)getStrVal:(int)idx
{
	return strVal[idx];
}

@end

@implementation EventList

@synthesize valCount;

- (void)addIntVal:(int)val
{
	intVal[valCount] = val;
	++valCount;
}

- (int)getIntVal:(int)idx
{
	return intVal[idx];
}

- (bool)getIsShow:(int)idx
{
	return true;
	return isShow[idx];
}

- (void)setIsShow:(int)idx :(bool)h
{
	isShow[idx] = h;
}

- (bool)setIsShowByIdx:(int)eventIdx
{
	for (int i=0; i<valCount; ++i)
	{
		if (intVal[i] == eventIdx)
		{
			if (isShow[i]) return false;
			isShow[i] = true;
			return true;
		}
	}
	return false;
}

@end

@implementation Msg

@synthesize valCount;

- (void)setIntVal:(int)idx val:(int)val
{
	intVal[idx] = val;
}

- (int)getIntVal:(int)idx
{
	return intVal[idx];
}

- (void)addStrVal:(NSString*)val
{
	strVal[valCount] = val;
	++valCount;
}

- (NSString*)getStrVal:(int)idx
{
	return strVal[idx];
}

@end

@implementation Scene

@synthesize isLoaded;
@synthesize sceneId;
@synthesize willSceneId;
@synthesize sceneType;
@synthesize nextChapter;
@synthesize endNum;
@synthesize preLoadBgIdx;
@synthesize preLoadBgmIdx;
@synthesize FXIdx;
@synthesize FXrepeat;
@synthesize subTitleIdx;
@synthesize flagStrCount;
@synthesize animeType;
@synthesize serihuIdx;

- (bool)isLoadOk
{
	return isLoaded && (sceneId == willSceneId);
}

- (void)reset
{
	sceneId = -1;
	willSceneId = -1;
	nextChapter = -1;
	endNum = -1;
	isLoaded = false;
	preLoadCharIdx[0] = preLoadCharIdx[1] = preLoadCharIdx[2] = preLoadCharIdx[3] = 0;
	preLoadData[0] = preLoadData[1] = preLoadData[2] = preLoadData[3] = preLoadData[4] = nil;
	
	preLoadBgIdx = 0;
	FXIdx = -1;
	preLoadBgmIdx = 0;
	subTitleIdx = -1;

	for (int i=0; i<flagStrCount; ++i)
	{
		flagStr[i] = nil;
	}
	
	flagStrCount = 0;
	animeType = 0;
}

- (NSData*)getBgData
{
	return preLoadData[4];
}

- (NSData*)getCharData:(int)idx
{
	return preLoadData[idx];
}

- (void)setBgData:(NSData*)data bgId:(int)bgId
{
	preLoadBgIdx = bgId;
	preLoadData[4] = data;
}

- (void)setCharData:(int)idx data:(NSData*)data chrId:(int)chrId
{
	preLoadCharIdx[idx] = chrId;
	preLoadData[idx] = data;
}

- (int)findChar:(int)chrId
{
	for (int i=0; i<3; ++i)
	{
		if (preLoadCharIdx[i] == chrId) return i;
	}
	return -1;
}

- (int)findSChar:(int)chrId
{
	if (preLoadCharIdx[3] == chrId) return 3;
	return -1;
}

- (int)getCharIdx:(int)idx
{
	return preLoadCharIdx[idx];
}

- (bool)findBg:(int)bgId
{
	return (bgId == preLoadBgIdx);
}

- (void)setSerihu:(NSString*)str
{
	serihu = str;
}

- (NSString*)getSerihu
{
	return serihu;
}

- (void)setChara:(NSString*)str
{
	chara = str;
}

- (NSString*)getChara
{
	return chara;
}

- (void)setSelect:(int)idx str:(NSString*)str
{
	selectStr[idx] = str;
}

- (NSString*)getSelect:(int)idx
{
	return selectStr[idx];
}

- (void)setSelectTag:(int)tag1 :(int)tag2 :(int)tag3 :(int)tag4
{
	selectTag[0] = tag1;
	selectTag[1] = tag2;
	selectTag[2] = tag3;
	selectTag[3] = tag4;
}

- (int)getSelectTag:(int)idx
{
	return selectTag[idx];
}

- (void)addFlagStr:(NSString*)str
{
	flagStr[flagStrCount] = str;
	++flagStrCount;
}

- (NSString*)getFlagStr:(int)idx
{
	return flagStr[idx];
}

@end

@implementation DataManager

/* --------------Sample Data--------------
 subTitle[0] = "プロロ?グ";
 scenario[1] = [0, 1, 74, "プロロ?グ"];
 moveBG[0] = 142;
 chrID[0] = [0, 19];
 BGMname[1] = "プリンセス\rナイトメア";
 VName[1] = ["リトル", "リトルの?", "?いドレスの少女", "リトル（？）"];
 eventlist[1] = [1, 2, 3, 5, 6, 8, 11, 12, 14, 15, 16, 17];
 itemName[1] = ["ストロベリ??ブ?ケ", "淡く甘い?心をイメ?ジした\rカクテル。夢見る少女に。"];
 msg[0][1] = [1, 0, 0, 0, 0, 1, 0, 0, "", "　タン、タン、タン、タン……", "seL_3"];
 */

@synthesize loadingDone;
@synthesize loadingTime;
@synthesize recollMsg;
@synthesize recollChr;

+ (DataManager*)getInstance
{
	return DataManagerInst;
}

+ (void)initManager;
{
	DataManagerInst = [DataManager alloc];
	ResourcePath = [[[NSBundle mainBundle] resourcePath] retain];

	[DataManagerInst setLoadingDone:false];
	[DataManagerInst reset];
	
// Tag, Index 프리로딩
//	for (int i=0; i<1000000; ++i)
//	{
//		tagData[i] = indexData[i] = 0;
//	}
}

- (void)closeManager
{
	for (int i=0; i<127; ++i)
		[scenario[i] release];

	for (int i=0; i<18; ++i)
		[vname[i] release];
	
	for (int i=0; i<EVENTCOUNT; ++i)
		[eventList[i] release];
	
	for (int i=0; i<22031; ++i)
		[msg[i] release];

	for (int i=0; i<10; ++i)
		[preloadScene[i] release];
}

- (void)reset
{
	for (int i=0; i<EVENTCOUNT; ++i)
	{
		eventList[i] = nil;
	}

	for (int i=0; i<10; ++i)
	{
		preloadScene[i] = [Scene alloc];
		[preloadScene[i] setFlagStrCount:0];
	}
	
	[self resetData];
}

- (void)resetData
{
	//어떠한 경우에도 50개가 넘지는 않는다.
	for (int i=0; i<50; ++i)
	{
		if (DataCollector[i] != nil) [DataCollector[i] release];
		DataCollector[i] = nil;
	}
	
	[self resetPreload];
	[self resetRecoll];
	DataCount = 0;
}

- (void)saveRecoll:(int)idx
{
	NSString* fileName = [NSString stringWithFormat:@"recoll%d.dat", idx];
	NSFileHandle *writeFile = [NSFileHandle fileHandleForWritingAtPath:fileName];
	if (writeFile == nil)
	{
		[[NSFileManager defaultManager] createFileAtPath:fileName
												contents:nil attributes:nil];
		
		writeFile = [NSFileHandle fileHandleForWritingAtPath:fileName];
	}
	
	if (writeFile == nil)
	{
		NSLog(@"fail to open file");
		return;
	}
	
	//버전정보심기
	int ver = 1;
	writeInt(writeFile, ver);
	writeInt(writeFile, recollEnd);
	[writeFile writeData: [NSData dataWithBytes:recoll
										 length:sizeof(int) * recollEnd]];
	
	[writeFile closeFile];
}

- (void)loadRecoll:(int)idx
{
	NSString* fileName = [NSString stringWithFormat:@"recoll%d.dat", idx];
	NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:fileName];
	
	if(readFile == nil)
	{
		[self resetRecoll];
		return;
	}
	
	//버전정보확인
	int ver = readInt(readFile);
	
	if (ver == 1)
	{
		recollEnd = readInt(readFile);
		NSData *data;
		data = [readFile readDataOfLength:sizeof(int)*recollEnd];
		[data getBytes:recoll];
	}
	
	[readFile closeFile];	
}

- (NSData*)getData:(NSString*)path
{
	NSString* filePath = [NSString stringWithFormat: @"%@/%@", ResourcePath, path];
	NSData* tempData = [[NSData alloc] initWithContentsOfFile:filePath];

	for (int i=0; i<50; ++i)
	{
		if (DataCollector[i] == nil)
		{
			DataCollector[i] = tempData;
			++DataCount;
			break;
		}
	}

	[filePath release];
	
	return tempData;
}

- (bool)parseData
{
	struct timeval newtime;
	gettimeofday(&newtime,0);
	int test = newtime.tv_sec;
	msgCount = 0;

	for (int i=0; i<22031; ++i)
	{
		msg[i] = nil;
	}

	for (int i=1; i<91; ++i)
	{
		msgIdx[i] = 0;
	}
	
	//--------------간단하고 몇개 안되는 것들은 하드코딩...--------------
	versionNum = @"sn1.0";
	int temp[39] = {0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 25, 26, 31, 32, 36, 41, 51, 52, 53, 54, 55, 56, 81, 82, 83, 84, 85, 86, 90};
	
	for (int i=0; i<39; ++i)
	{
		tempVoiceList[i] = temp[i];
	}
	
	moveBG[0] = 142;
	moveBG[1] = 605;
	moveBG[2] = 607;
	moveBG[3] = 609;
	moveBG[4] = 615;
	moveBG[5] = 628;
	moveBG[6] = 689;
	moveBG[7] = 738;
	moveBG[8] = 791;
	moveBG[9] = 900;
	moveBG[10] = 901;
	moveBG[11] = 902;
	moveBG[13] = 617;
	moveBG[14] = 789;
	moveBG[15] = 963;
	moveBG[15] = 793;

	BGMname[1] = @"プリンセス\rナイトメア";
	BGMname[2] = @"愛すべき日々";
	BGMname[3] = @"百万回の朝食";
	BGMname[4] = @"どうか内緒に";
	BGMname[5] = @"不吉な予兆";
	BGMname[6] = @"高まる緊張";
	BGMname[7] = @"クライマックス";
	BGMname[8] = @"彷徨う思惑";
	BGMname[9] = @"聖ローザ学園";
	BGMname[10] = @"ハロウィンで\r恋の胸騒ぎ！";
	BGMname[11] = @"魔界のテーマ";
	BGMname[12] = @"夕暮れピエロ";
	BGMname[13] = @"スラップスティック";
	BGMname[14] = @"嘘つきエンジェルの\r内緒話";
	BGMname[15] = @"誰にも言えない";
	BGMname[16] = @"OP\r東京ジオラマ";
	BGMname[17] = @"ED \r悪夢の姫君";
	BGMname[18] = @"ラドウ\r千の嘘＋唯一の愛";
	BGMname[19] = @"ドラクレア\r煉獄への警鐘";
	BGMname[20] = @"フランケン\rイコール";
	BGMname[21] = @"犬飼\rお前だけのヒーロー";
	BGMname[22] = @"ヘルシング\rアレストゲーム";
	BGMname[23] = @"プリンス\r共犯者";
	BGMname[24] = @"ファントム\r不可侵グランドオペラ";
	BGMname[25] = @"メフィスト\r光を憎み、闇を抱くもの";
	BGMname[26] = @"月光";
	BGMname[27] = @"SonataⅠ\rAdagio";
	BGMname[28] = @"SonataⅢ\rLargo";

	itemName[1][0] = @"ストロベリー・ブーケ";	itemName[1][1] = @"淡く甘い恋心をイメージした\rカクテル。夢見る少女に。";
	itemName[2][0] = @"ラズベリー・ムーン";		itemName[2][1] = @"甘酸っぱい２度目の恋の\rカクテル。背伸びした貴女に。";
	itemName[3][0] = @"ホワイト・レディー";		itemName[3][1] = @"高潔な貴婦人のカクテル。\r誇り高い貴女に。";
	itemName[4][0] = @"ラビアン・ローズ";		itemName[4][1] = @"バラ色の人生を演出する\rカクテル。微笑の麗しい淑女に。";
	itemName[5][0] = @"ブラッディ・マリー";		itemName[5][1] = @"わがままな略奪愛を表現した\rカクテル。罪深い貴女に。";
	itemName[6][0] = @"プリンセス・ナイトメア";	itemName[6][1] = @"愛の悪夢を表現したカクテル。\r世界は貴女にひざまづく。";
	itemName[7][0] = @"キラー・クイーン";		itemName[7][1] = @"愛の猟奇殺人。\r誰も貴女に敵わない。";
	itemName[9][0] = @"お守りのペンダント";		itemName[9][1] = @"危険からリトルの\r身を守るペンダント。";
	itemName[10][0] = @"ムーンストーンの指輪";	itemName[10][1] = @"ラドウとの結婚指輪。\r月の光を宿す。";
	itemName[11][0] = @"未来の指輪";			itemName[11][1] = @"ドラクレアからのプレゼント。\r永遠の時の向こうにある想い。";
	itemName[12][0] = @"ちょっと大きい指輪";	itemName[12][1] = @"ヘルシングからのプレゼント。\r少し背伸びした想い。";
	itemName[13][0] = @"おもちゃの指輪";		itemName[13][1] = @"真治からのプレゼント。\rすぐ側に居てくれる想い。";
	itemName[14][0] = @"鍵のペンダント";		itemName[14][1] = @"犬飼からのプレゼント。\r束縛と略奪の間にある想い。";
	itemName[15][0] = @"クローバーの指輪";		itemName[15][1] = @"フランケンからのプレゼント。\r永遠の幸福を願う想い。";
	itemName[16][0] = @"宵光草の種";			itemName[16][1] = @"霜降の日、一夜だけ咲く\r宵光草の種。一瞬の煌き。";
	itemName[17][0] = @"銀のナイフ";			itemName[17][1] = @"開かずの間で引き抜いたナイフ。\rドラクレア家、過去への鍵。";
	itemName[20][0] = @"研究所長のバッチ";		itemName[20][1] = @"ムラサメから略奪。\rこれで貴女も一日所長？";
	itemName[21][0] = @"卒業証書";			itemName[21][1] = @"由香ちゃんと聖ローザ中等部\r夜間を卒業。";
	itemName[22][0] = @"ハロウィンのお菓子";	itemName[22][1] = @"トリックオアトリート、\r食べたら生きて帰れない！？";
	
	//--------------여기까지 하드코딩--------------

	char buffer[512];

	NSString* filePath = [[NSString stringWithFormat: @"%@/scenario.txt", ResourcePath] autorelease];
	FILE *hFile = fopen([filePath UTF8String] , "r");
	
	if ( hFile == nil )
	{
		NSLog(@"no file to read");
		return false;
	}

	while(fgets(buffer, 512, hFile))
	{
		buffer[strlen(buffer) - 1] = '\0';

		switch (buffer[0])
		{
			case 's':
				if (buffer[1] == 'u') [self parseSubTitle:&buffer[0]];
				else [self parseScenario:&buffer[0]];
				break;
			case 'm':
				[self parseMsg:&buffer[0]];
				break;
			case 'c':
				[self parseChrID:&buffer[0]];
				break;
			case 'V':
				[self parseVName:&buffer[0]];
				break;
			case 'e':
				[self parseEventList:&buffer[0]];
				break;
//			case 'i':
//				[self parseItemName:&buffer[0]];
//				break;
		}
	}
	
	fclose(hFile);
	
	for (int i=1; i<127; ++i)
	{
		int idx1 = [scenario[i] getIntVal:0];
		[scenario[i] setStartIdx:msgIdx[idx1] + [scenario[i] getIntVal:1] - 1];
		[scenario[i] setEndIdx:msgIdx[idx1] + [scenario[i] getIntVal:2] - 1];
	}

//	Tag, Index 프리로딩
//	hFile = fopen("tagIndex.dat", "w");
//	{
//		fwrite(&tagCount, 1, sizeof(int), hFile);
//		for (int i=0; i<1000000; ++i)
//		{
//			if (tagData[i] != 0)
//			{
//				fwrite(&i, 1, sizeof(int), hFile);
//				fwrite(&tagData[i], 1, sizeof(int), hFile);
//			}
//		}
//		
//		fwrite(&maxIndex, 1, sizeof(int), hFile);
//
//		for (int i=0; i<maxIndex; ++i)
//		{
//			fwrite(&indexData[i], 1, sizeof(int), hFile);
//		}
//	}
//	
//	fclose(hFile);
	
	filePath = [NSString stringWithFormat: @"%@/tagIndex.dat", ResourcePath];
	hFile = fopen([filePath UTF8String] , "r");
	[filePath release];
	
	int tagCount, indexCount;

	fread(&tagCount, 1, sizeof(4), hFile);
	for (int i=0; i<tagCount; ++i)
	{
		fread(&tagInfo[0][i], 1, sizeof(4), hFile);
		fread(&tagInfo[1][i], 1, sizeof(4), hFile);
	}
	
	fread(&indexCount, 1, sizeof(4), hFile);
	for (int i=0; i<indexCount; ++i)
	{
		fread(&indexInfo[i], 1, sizeof(4), hFile);
	}
    
	fclose(hFile);

	loadingDone = true;
	gettimeofday(&newtime,0);
	loadingTime = newtime.tv_sec - test;

	return true;
}

- (void)parseSubTitle:(char*)data
{
	int offset = 9;
	int idx = readInteger(data, &offset);
	
	offset += 3;
	
	subTitle[idx] = readString(data, &offset);
}

- (NSString*)getSubTitle:(int)idx
{
	return subTitle[idx];
}

- (void)parseScenario:(char*)data
{
	int offset = 9;
	int idx = readInteger(data, &offset);
	
	offset += 4;

	scenario[idx] = [Scenario alloc];
	for (int i=0; i<3; ++i)
	{
		[scenario[idx] setIntVal:i val:readInteger(data, &offset)];
	}

	[scenario[idx] setStrVal:readString(data, &offset)];
}

- (Scenario*)getScenario:(int)idx
{
	return scenario[idx];
}

- (void)parseChrID:(char*)data
{
	int offset = 6;
	int idx = readInteger(data, &offset);
	
	offset += 4;

	chrID[idx].x = readInteger(data, &offset);
	chrID[idx].y = readInteger(data, &offset);
}

- (CGPoint)getChrID:(int)idx
{
	return chrID[idx];
}

- (void)parseVName:(char*)data
{
	int offset = 6;
	int idx = readInteger(data, &offset);
	
	offset += 4;

	vname[idx] = [VName alloc];
	[vname[idx] setValCount:0];

	while(data[offset] != ';')
	{
		[vname[idx] addStrVal:readString(data, &offset)];
	}
}

- (VName*)getVName:(int)idx
{
	return vname[idx];
}

- (void)parseEventList:(char*)data
{
	int offset = 10;
	int idx = readInteger(data, &offset);
	
	offset += 4;
	
	if (eventList[idx] == nil) eventList[idx] = [EventList alloc];
	[eventList[idx] setValCount:0];
	
	while(data[offset] != ';')
	{
		[eventList[idx] addIntVal:readInteger(data, &offset)];
	}

	
}

- (EventList*)getEventList:(int)idx
{
	return eventList[idx];
}

- (void)parseItemName:(char*)data
{
	int offset = 9;
	int idx = readInteger(data, &offset);
	
	offset += 4;
	
	itemName[idx][0] = readString(data, &offset);
	itemName[idx][1] = readString(data, &offset);
}

- (NSString*)getItemName:(int)idx idx2:(int)idx2
{
	return itemName[idx][idx2];
}

- (void)parseMsg:(char*)data
{
	int offset = 4;
	int idx = readInteger(data, &offset);
	++offset;
	int idx2 = readInteger(data, &offset);
	
	offset += 4;
	
	Msg* m = [Msg alloc];
	msg[msgCount] = m;
	
//	static int temp = 0;
//	static int last = 0;
//	
//	if (temp != idx)
//	{
//		static FILE* temp2 = NULL;
//		
//		if (temp2 == NULL) temp2 = fopen("test.txt","w+");
//
//		for (int i=temp+1; i<idx; ++i)
//		{
//			fprintf(temp2, "0, ", last);
//		}
//
//		fprintf(temp2, "%d, ", last);
//
//		temp = idx;
//	}
//	last = idx2;
	
	
//	Tag, Index 프리로딩
//	nowScene = idx;
//	nowIdx = msgCount;

	[m setValCount:0];

	for (int i=0; i<8; ++i)
	{
		[m setIntVal:i val:readInteger(data, &offset)];
	}
	
	int bgIdx = [m getIntVal:5];
	switch (bgIdx)
	{
		case 606:
		case 608:
		case 610:
		case 612:
		case 616:
		case 618:
		case 629:
		case 690:
		case 739:
		case 754:
		case 790:
		case 792:
		case 794:
			[m setIntVal:5 val:bgIdx-1];
			--bgIdx;
	}

	int strCount, intCount;
	
	switch ([m getIntVal:0])
	{
		case 1:
			strCount = 2;
			intCount = 0;
			break;
		case 6:
			strCount = 2;
			intCount = 1;
			break;
		default:
			strCount = [m getIntVal:0] + 1;
			intCount = [m getIntVal:0];
			break;
	}

	for (int i=0; i<strCount; ++i)
	{
		[m addStrVal:readString(data, &offset)];
	}

	for (int i=0; i<intCount; ++i)
	{
		[m setIntVal:8+i val:readInteger(data, &offset)];
	}

	while(data[offset] != ';')
	{
		[m addStrVal:readString(data, &offset)];
	}
	
	if (idx2 == 1) msgIdx[idx] = msgCount;
	++msgCount;
}
	
- (Msg*)getMsg:(int)idx idx2:(int)idx2
{
	return msg[msgIdx[idx] + idx2 - 1];
}

- (Msg*)getMsg2:(int)idx
{
	return msg[idx];
}

- (int)getMsgIdx:(int)idx idx2:(int)idx2
{
	return msgIdx[idx] + idx2 - 1;
}

- (void)preload
{
	NSData* tempData;

	while(1)
	{
		int c = curIdx;
		for (int i=0; i<10; ++i)
		{
			int j = (c + i)%10;
			
			int willSceneId = [preloadScene[j] willSceneId];
			
			if (willSceneId >= 22050)
			{
				continue;
			}

			if ([preloadScene[j] sceneId] != willSceneId)
			{
				[preloadScene[j] setIsLoaded:false];
				
				for (int k=1; k<91; ++k)
				{
					if (msgIdx[k] > willSceneId) break;
					if (msgIdx[k] == 0) continue;

					[preloadScene[j] setSubTitleIdx:k];
					[preloadScene[j] setSerihuIdx:(willSceneId - msgIdx[k])];
				}

				int chrId;

				[preloadScene[j] setPreLoadBgmIdx:[msg[willSceneId] getIntVal:6]];
				[preloadScene[j] setAnimeType:0];

				//여기서 프리로딩...
				for (int k=0; k<3; ++k)
				{
					chrId = [msg[willSceneId] getIntVal:k+1];
					if (chrId == 0)
					{
						[preloadScene[j] setCharData:k data:NULL chrId:0];
					}
					else
					{
						//일단 미리로딩되어있는 데이터가 있는지 찾는다.
						for (int l=0; l<10; ++l)
						{
							//같은 캐릭터가 계속 반복적으로 나오는 경우가 많으므로
							//바로직전의 씬에서부터 찾아본다.
							int ll = (j + l + 9)%10;
							int idx = [preloadScene[ll] findChar:chrId];
							if (idx != -1)
							{
								tempData = [preloadScene[ll] getCharData:idx];
								goto FIND_OK;
							}
						}

						NSString* imgName = [NSString stringWithFormat:@"Achr_%03d.png", chrId];

						tempData = [self getData:imgName];
						
						[imgName release];
					FIND_OK:
						[preloadScene[j] setCharData:k data:tempData chrId:chrId];
					}

					if (chrId == 985) [preloadScene[j] setAnimeType:4];
				}

				chrId = [msg[willSceneId] getIntVal:4];
				if (chrId == 0)
				{
					[preloadScene[j] setCharData:3 data:NULL chrId:0];
				}
				else
				{
					//일단 미리로딩되어있는 데이터가 있는지 찾는다.
					for (int l=0; l<10; ++l)
					{
						//같은 캐릭터가 계속 반복적으로 나오는 경우가 많으므로
						//바로직전의 씬에서부터 찾아본다.
						int ll = (j + l + 9)%10;
						int idx = [preloadScene[ll] findSChar:chrId];
						if (idx != -1)
						{
							tempData = [preloadScene[ll] getCharData:idx];
							goto FIND_OK2;
						}
					}

					NSString* imgName = [NSString stringWithFormat:@"Achr_s%03d.png", chrId];

					tempData = [self getData:imgName];

					[imgName release];
				FIND_OK2:
					[preloadScene[j] setCharData:3 data:tempData chrId:chrId];
				}

				int bgId = [msg[willSceneId] getIntVal:5];

				for (int l=0; l<10; ++l)
				{
					//같은 캐릭터가 계속 반복적으로 나오는 경우가 많으므로
					//바로직전의 씬에서부터 찾아본다.
					int ll = (j + l + 9)%10;
					if ([preloadScene[ll] findBg:bgId])
					{
						tempData = [preloadScene[ll] getBgData];
						goto FIND_OK3;
					}
				}

				if (bgId > 500)
				{
					bgId -= 500;

					NSString* imgName = [NSString stringWithFormat:@"Aev_%03d.jpg", bgId];
					
					tempData = [self getData:imgName];

					[imgName release];

					bgId += 500;
				}
				else
				{
					NSString* imgName = [NSString stringWithFormat:@"Abg_%03d.jpg", bgId];
					
					tempData = [self getData:imgName];

					[imgName release];
				}

			FIND_OK3:
				[preloadScene[j] setBgData:tempData bgId:bgId];
				
				[preloadScene[j] setChara:[msg[willSceneId] getStrVal:0]];
				[preloadScene[j] setSerihu:[msg[willSceneId] getStrVal:1]];

				int sceneType = [msg[willSceneId] getIntVal:0];
				[preloadScene[j] setSceneType:sceneType];
				
				switch (sceneType)
				{
					case 3:
						[preloadScene[j] setSelect:0 str:[msg[willSceneId] getStrVal:2]];
						[preloadScene[j] setSelect:1 str:[msg[willSceneId] getStrVal:3]];
						
						[preloadScene[j] setSelectTag:[msg[willSceneId] getIntVal:8]
						 :[msg[willSceneId] getIntVal:9]
						 :[msg[willSceneId] getIntVal:10]
						 :0];
						break;
					case 4:
						[preloadScene[j] setSelect:0 str:[msg[willSceneId] getStrVal:2]];
						[preloadScene[j] setSelect:1 str:[msg[willSceneId] getStrVal:3]];
						[preloadScene[j] setSelect:2 str:[msg[willSceneId] getStrVal:4]];
						
						[preloadScene[j] setSelectTag:[msg[willSceneId] getIntVal:8]
						 :[msg[willSceneId] getIntVal:9]
						 :[msg[willSceneId] getIntVal:10]
						 :[msg[willSceneId] getIntVal:11]];
						break;
					case 6:
						[preloadScene[j] setSelectTag:[msg[willSceneId] getIntVal:8] :0 :0: 0];
						break;
					default:
						[preloadScene[j] setSelectTag:0 :0 :0 :0];
						break;
				}
				
				NSString* optionStr = nil;
				int fxIdx = [msg[willSceneId] getIntVal:7];
				if (fxIdx == 0) fxIdx = -1;
				[preloadScene[j] setFXrepeat:false];
				[preloadScene[j] setNextChapter:-1];
				[preloadScene[j] setFlagStrCount:0];

				int strcount = 2;
				if ((sceneType != 1) && (sceneType != 6)) strcount = sceneType + 1;

				for (int l=strcount; l<[msg[willSceneId] valCount]; ++l)
				{
					optionStr = [msg[willSceneId] getStrVal:l];

					if (optionStr != nil)
					{
						if ([optionStr compare:@"anime"] == NSOrderedSame)
						{
							int temp = [msg[willSceneId] getIntVal:5] - 500;
							if (temp < 400)
							{
								if (temp == 291) [preloadScene[j] setAnimeType:3];
								else [preloadScene[j] setAnimeType:1];
							}
							else [preloadScene[j] setAnimeType:temp];
							continue;
						}
						
						NSArray *listItems = [optionStr componentsSeparatedByString:@"_"];
						if ([listItems count] < 2)
						{
							[listItems release];
							continue;
						}
						
						NSString* item0 = (NSString*)[listItems objectAtIndex:0];
						NSString* item1 = (NSString*)[listItems objectAtIndex:1];
						
						if ([item0 compare:@"nxtC"] == NSOrderedSame)
						{
							[preloadScene[j] setNextChapter:[item1 intValue]];
						}
						else if ([item0 compare:@"endA"] == NSOrderedSame)
						{
							[preloadScene[j] setEndNum:[item1 intValue]];
						}
						else if ([item0 compare:@"endB"] == NSOrderedSame)
						{
							[preloadScene[j] setEndNum:[item1 intValue] + 100];
						}
						else if ([item0 compare:@"seL"] == NSOrderedSame)
						{
							fxIdx = [item1 intValue];
							[preloadScene[j] setFXrepeat:true];
						}
						else if (([item0 compare:@"fgE"] == NSOrderedSame)||
								([item0 compare:@"fgE2"] == NSOrderedSame)||
								([item0 compare:@"fgS"] == NSOrderedSame)||
								([item0 compare:@"fgS2"] == NSOrderedSame))
						{
							[preloadScene[j] addFlagStr:optionStr];
						}
						[listItems release];
					}
				}
				
				[preloadScene[j] setFXIdx:fxIdx];
				
				[preloadScene[j] setSceneId:willSceneId];
				[preloadScene[j] setIsLoaded:true];
			}
		}
		
		if (DataCount > 20)
		{
			//20개가 넘어가면 클리어링을 한번씩 해준다.
			for (int i=0; i<50; ++i)
			{
				if (DataCollector[i] == nil) continue;
				
				for (int j=0; j<10; ++j)
				{
					if ([preloadScene[j] getCharData:0] == DataCollector[i]) goto GABBAGE_CHECK_OK;
					if ([preloadScene[j] getCharData:1] == DataCollector[i]) goto GABBAGE_CHECK_OK;
					if ([preloadScene[j] getCharData:2] == DataCollector[i]) goto GABBAGE_CHECK_OK;
					if ([preloadScene[j] getCharData:3] == DataCollector[i]) goto GABBAGE_CHECK_OK;
					if ([preloadScene[j] getBgData] == DataCollector[i]) goto GABBAGE_CHECK_OK;
				}
				
				[DataCollector[i] release];
				DataCollector[i] = nil;
				--DataCount;
GABBAGE_CHECK_OK:
				continue;
			}
		}
		
		[NSThread sleepForTimeInterval:0.1];
	}
}

- (void)setCurIdx:(int)idx
{
	curIdx = 0;

	for (int i=0; i<10; ++i)
	{
		[preloadScene[(curIdx+i)%10] setWillSceneId:idx+i];
	}
}

- (void)setNextIdx:(int)idx
{
	curIdx = (curIdx + 1)%10;

	for (int i=0; i<10; ++i)
	{
		[preloadScene[(curIdx+i)%10] setWillSceneId:idx+i];
	}
}

- (Scene*)getCurScene
{
	return preloadScene[curIdx];
}

- (void)resetPreload
{
	for (int i=0; i<10; ++i)
	{
		[preloadScene[i] reset];
	}
	
	curScene = preloadScene[0];
}

- (NSString*)getSceneIdxStr
{
	int idx, idx2;
	
	idx = 0;
	idx2 = [preloadScene[curIdx] sceneId];

	for (int i=1; i<91; ++i)
	{
		if (msgIdx[i] > idx2) break;
		if (msgIdx[i] != 0) idx = i;
	}

	return [NSString stringWithFormat: @"%d - %d", idx, idx2 - msgIdx[idx] + 1];
}

- (int)getIndexInfo:(int)idx
{
	return indexInfo[idx];
}

- (int)gotoChapter:(int)chp
{
	[self setCurIdx:msgIdx[chp]];
	return msgIdx[chp];
}

- (void)gotoEnding:(int)type idx:(int)idx
{
	//엔딩처리...
}

- (int)getTagInfo:(int)tag
{
	int idx, idx2;
	
	idx = 0;
	idx2 = [preloadScene[curIdx] sceneId];
	
	for (int k=1; k<91; ++k)
	{
		if (msgIdx[k] > idx2) break;
		if (msgIdx[k] == 0) continue;
		
		idx = k;
	}

	for (int i=0; i<800; ++i)
	{
		if (tagInfo[0][i] == (idx * 1000) + tag) return tagInfo[1][i];
	}
	
	return 0;
}

- (void)setEventData:(int)idx :(char)data
{
	if (eventList[idx] == nil) eventList[idx] = [EventList alloc];
	for (int i=0; i<4; ++i)
	{
		[eventList[idx] setIsShow:i :(0x01 == ((data >> i) & 0x01))];
	} 
}

- (char)getEventData:(int)idx
{
	char data = 0;
	for (int i=0; i<4 ; ++i)
	{
		if ([eventList[idx] getIsShow:i]) data |= (0x01 << i);
	}
	return data;
}

- (bool)setEventShow:(int)eventIdx
{
	bool result = false;
	for (int i=0; i<124; ++i)
	{
		result = result || [eventList[i] setIsShowByIdx:eventIdx];
	}
	
	return result;
}

- (void)setMusicShow:(int)idx
{
	if (musicShowData[idx] == false)
	{
		musicShowData[idx] = true;
		[[SaveManager getInstance] saveMusicFile];
	}
}

- (void)setMusicShowWithoutSave:(int)idx
{
	musicShowData[idx] = true;
}

- (bool)getMusicShow:(int)idx
{
	return true;
	return musicShowData[idx];
}

- (NSString*)getBGMname:(int)idx
{
	return BGMname[idx];
}

- (void)checkSceneExp:(int)idx
{
	for (int i=1; i<127; ++i)
	{
		int endIdx = [scenario[i] endIdx];
		if (endIdx > idx) return;
		if (endIdx == idx)
		{
			[[SaveManager getInstance] setSceneExp:i];
		}
	}
}

- (void)addRecoll:(int)idx :(int)select
{
	curRecoll = idx;

	//선택지는 무조건 따로 저장한다.
	if (select != -1)
	{
		recoll[recollEnd] = 2;
		recoll[recollEnd+1] = idx;
		recoll[recollEnd+2] = select;
		curRecollIdx = recollEnd;
		recollEnd = recollEnd+3;
		return;
	}
	
	if (recollEnd != 0)
	{
		if (recoll[recollEnd-3] == 1)
		{
			if ((recoll[recollEnd-1] + recoll[recollEnd-2] + 1) == idx)
			{
				++recoll[recollEnd-1];
				return;
			}
		}
	}
	
	recoll[recollEnd] = 1;
	recoll[recollEnd+1] = idx;
	recoll[recollEnd+2] = 0;
	curRecollIdx = recollEnd;
	recollEnd = recollEnd+3;
}

- (void)resetRecoll
{
	recollEnd = 0;
	curRecollIdx = -1;
	memset(recoll, 0x00, 512 * sizeof(int));
}

- (bool)can_next_Recoll
{
	if (curRecollIdx == -1) return false;
	if ((recoll[curRecollIdx] == 1) && ((recoll[curRecollIdx + 1] + recoll[curRecollIdx + 2]) > curRecoll)) return true;
	if (curRecollIdx + 3 == recollEnd) return false;
	return true;
}

- (bool)can_prev_Recoll
{
	if (curRecollIdx == -1) return false;
	if ((recoll[curRecollIdx] == 1) && (recoll[curRecollIdx + 1] < curRecoll)) return true;
	if (curRecollIdx == 0) return false;
	return true;
}

- (void)next_Recoll
{
	if ((recoll[curRecollIdx] == 1) && ((recoll[curRecollIdx + 1] + recoll[curRecollIdx + 2]) > curRecoll))
	{
		++curRecoll;
	}
	else
	{
		if (curRecollIdx + 3 == recollEnd) return;
		
		curRecollIdx += 3;
		curRecoll = recoll[curRecollIdx+1];
	}
	
	recollChr = [msg[curRecoll] getStrVal:0];

	if (recoll[curRecollIdx] == 1)
	{
		recollMsg = [msg[curRecoll] getStrVal:1];
	}
	else
	{
		recollMsg = [NSString stringWithFormat: @"●選択「%@」",[msg[curRecoll] getStrVal:2 + recoll[curRecollIdx+2]]];
	}
}

- (void)next2_Recoll
{
	while (1)
	{
		if (curRecollIdx + 3 >= recollEnd)
		{
			if (recoll[curRecollIdx] == 1)
			{
				curRecoll = recoll[curRecollIdx + 1] + recoll[curRecollIdx + 2];
				recollChr = [msg[curRecoll] getStrVal:0];
				recollMsg = [msg[curRecoll] getStrVal:1];
			}
			return;
		}

		curRecollIdx += 3;
		if (recoll[curRecollIdx] == 2)
		{
			curRecoll = recoll[curRecollIdx + 1];
			recollChr = [msg[curRecoll] getStrVal:0];
			recollMsg = [NSString stringWithFormat: @"●選択「%@」",[msg[curRecoll] getStrVal:2 + recoll[curRecollIdx+2]]];
			return;
		}
	}
}

- (void)prev_Recoll
{
	if ((recoll[curRecollIdx] == 1) && (recoll[curRecollIdx + 1] < curRecoll))
	{
		--curRecoll;
	}
	else
	{
		if (curRecollIdx == 0) return;

		curRecollIdx -= 3;
		if (recoll[curRecollIdx] == 1)
		{
			curRecoll = recoll[curRecollIdx+1] + recoll[curRecollIdx+2];
		}
		else
		{
			curRecoll = recoll[curRecollIdx+1];
		}
	}
	
	recollChr = [msg[curRecoll] getStrVal:0];

	if (recoll[curRecollIdx] == 1)
	{
		recollMsg = [msg[curRecoll] getStrVal:1];
	}
	else
	{
		recollMsg = [NSString stringWithFormat: @"●選択「%@」",[msg[curRecoll] getStrVal:2 + recoll[curRecollIdx+2]]];
	}
}

- (void)prev2_Recoll
{
	while (1)
	{
		if (curRecollIdx <= 0)
		{
			if (recoll[curRecollIdx] == 1)
			{
				curRecoll = recoll[curRecollIdx + 1];
				recollChr = [msg[curRecoll] getStrVal:0];
				recollMsg = [msg[curRecoll] getStrVal:1];
			}
			return;
		}
		
		curRecollIdx -= 3;
		if (recoll[curRecollIdx] == 2)
		{
			curRecoll = recoll[curRecollIdx + 1];
			recollChr = [msg[curRecoll] getStrVal:0];
			recollMsg = [NSString stringWithFormat: @"●選択「%@」",[msg[curRecoll] getStrVal:2 + recoll[curRecollIdx+2]]];
			return;
		}
	}
}

- (void)GotoRecollEnd
{
	curRecollIdx = recollEnd - 3;

	curRecoll = recoll[curRecollIdx + 1] + recoll[curRecollIdx + 2];
	recollChr = [msg[curRecoll] getStrVal:0];
	recollMsg = [msg[curRecoll] getStrVal:1];
}

@end
