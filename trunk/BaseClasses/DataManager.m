#import "DataManager.h"

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
			temp[idx] = data[offsetVal];
			++idx;
		}
		
		++offsetVal;
	}
	
	offsetVal += 2;
	temp[idx] = '\0';
	
	*offset = offsetVal;
	
	NSString* str = [[NSString alloc] initWithUTF8String:temp];
	return str;
}

static DataManager *DataManagerInst;

@implementation Scenario

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

- (void)reset
{
	sceneId = -1;
	willSceneId = -1;
	isLoaded = false;
	preLoadCharIdx[0] = preLoadCharIdx[1] = preLoadCharIdx[2] = 0;
	preLoadChar[0] = preLoadChar[1] = preLoadChar[2] = NULL;
}

- (void)setChar:(int)idx img:(UIImage*)chr chrId:(int)chrId
{
	preLoadCharIdx[idx] = chrId;
	preLoadChar[idx] = chr;
}

- (UIImage*)getChar:(int)idx
{
	return preLoadChar[idx];
}

- (UIImage*)findChar:(int)chrId
{
	for (int i=0; i<3; ++i)
	{
		if (preLoadCharIdx[i] == chrId) return preLoadChar[i];
	}
	return NULL;
}

- (void)setBg:(UIImage*)bg bgId:(int)bgId;
{
	preLoadBgIdx = bgId;
	preLoadBg = bg;
}

- (UIImage*)getBg
{
	return preLoadBg;
}

- (UIImage*)findBg:(int)bgId
{
	if (bgId == preLoadBgIdx) return preLoadBg;

	return NULL;
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

+ (DataManager*)getInstance
{
	return DataManagerInst;
}

+ (void)initManager;
{
	DataManagerInst = [DataManager alloc];
	[DataManagerInst setLoadingDone:false];
}

- (void)closeManager
{
	for (int i=0; i<127; ++i)
		[scenario[i] release];

	for (int i=0; i<18; ++i)
		[vname[i] release];
	
	for (int i=0; i<15; ++i)
		[eventList[i] release];
	
	for (int i=0; i<22031; ++i)
		[msg[i] release];

	for (int i=0; i<10; ++i)
		[preloadScene[i] release];
}

- (bool)parseData
{
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
	BGMname[2] = @"愛すべき日?";
	BGMname[3] = @"百万回の朝食";
	BGMname[4] = @"どうか??に";
	BGMname[5] = @"不吉な予兆";
	BGMname[6] = @"高まる緊張";
	BGMname[7] = @"クライマックス";
	BGMname[8] = @"彷徨う思惑";
	BGMname[9] = @"聖ロ?ザ?園";
	BGMname[10] = @"ハロウィンで\r?の胸?ぎ！";
	BGMname[11] = @"魔界のテ?マ";
	BGMname[12] = @"夕暮れピエロ";
	BGMname[13] = @"スラップスティック";
	BGMname[14] = @"?つきエンジェルの\r??話";
	BGMname[15] = @"誰にも言えない";
	BGMname[16] = @"OP\r東京ジオラマ";
	BGMname[17] = @"ED \r?夢の?君";
	BGMname[18] = @"ラドウ\r千の?＋唯一の愛";
	BGMname[19] = @"ドラクレア\r煉獄への警鐘";
	BGMname[20] = @"フランケン\rイコ?ル";
	BGMname[21] = @"犬飼\rお前だけのヒ?ロ?";
	BGMname[22] = @"ヘルシング\rアレストゲ?ム";
	BGMname[23] = @"プリンス\r共犯者";
	BGMname[24] = @"ファントム\r不可侵グランドオペラ";
	BGMname[25] = @"メフィスト\r光を憎み、闇を抱くもの";
	BGMname[26] = @"月光";
	BGMname[27] = @"SonataⅠ\rAdagio";
	BGMname[28] = @"SonataⅢ\rLargo";
	//--------------여기까지 하드코딩--------------
	
	msgCount = 0;
	
	char buffer[512];

	NSString *filePath = [NSString stringWithFormat: @"%@/scenario.txt", [[NSBundle mainBundle] resourcePath]];
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
			case 'i':
				[self parseItemName:&buffer[0]];
				break;
		}
	}
	
	fclose(hFile);
	
	loadingDone = true;

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
	
	eventList[idx] = [EventList alloc];
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

	[m setValCount:0];

	for (int i=0; i<8; ++i)
	{
		[m setIntVal:i val:readInteger(data, &offset)];
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
	return msg[msgIdx[idx] + idx2];
}

- (void)preload
{
	UIImage* tempImg;

	while(1)
	{
		int c = curIdx;
		for (int i=0; i<10; ++i)
		{
			int j = (c + i)%10;

			int willSceneId = [preloadScene[j] willSceneId];

			if ([preloadScene[j] sceneId] != willSceneId)
			{
				[preloadScene[j] setIsLoaded:false];
				
				//여기서 프리로딩...
				for (int k=0; k<3; ++k)
				{
					int chrId = [msg[willSceneId] getIntVal:k+1];
					if (chrId == 0)
					{
						[preloadScene[j] setChar:k img:NULL chrId:0];
					}
					else
					{
						//일단 미리로딩되어있는 데이터가 있는지 찾는다.
						for (int l=0; l<10; ++l)
						{
							//같은 캐릭터가 계속 반복적으로 나오는 경우가 많으므로
							//바로직전의 씬에서부터 찾아본다.
							int ll = (j + l + 9)%10;
							tempImg = [preloadScene[ll] findChar:chrId];
							if (tempImg != NULL) goto FIND_OK;
						}

						if (chrId < 100)
							tempImg = [[UIImage imageNamed:[NSString stringWithFormat:@"Achr_0%d.png", chrId]] autorelease];
						else
							tempImg = [[UIImage imageNamed:[NSString stringWithFormat:@"Achr_%d.png", chrId]] autorelease];
					FIND_OK:
						[preloadScene[j] setChar:k img:tempImg chrId:chrId];
					}
				}

				int bgId = [msg[willSceneId] getIntVal:5];

				for (int l=0; l<10; ++l)
				{
					//같은 캐릭터가 계속 반복적으로 나오는 경우가 많으므로
					//바로직전의 씬에서부터 찾아본다.
					int ll = (j + l + 9)%10;
					tempImg = [preloadScene[ll] findBg:bgId];
					if (tempImg != NULL) goto FIND_OK2;
				}
				
				if (bgId < 10)
					tempImg = [[UIImage imageNamed:[NSString stringWithFormat:@"Abg_00%d.png", bgId]] autorelease];
				else if (bgId < 100)
					tempImg = [[UIImage imageNamed:[NSString stringWithFormat:@"Abg_0%d.png", bgId]] autorelease];
				else
					tempImg = [[UIImage imageNamed:[NSString stringWithFormat:@"Abg_%d.png", bgId]] autorelease];

			FIND_OK2:
				[preloadScene[j] setBg:tempImg bgId:bgId];
				
				[preloadScene[j] setSceneId:willSceneId];
				[preloadScene[j] setIsLoaded:true];
			}
		}
		sleep(1);
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
		preloadScene[i] = [Scene alloc];
		[preloadScene[i] reset];
	}
	
	curScene = preloadScene[0];
}

@end
