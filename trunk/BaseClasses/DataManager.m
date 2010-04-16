#import "DataManager.h"

static DataManager *DataManagerInst;

@implementation DataManager

/* --------------Sample Data--------------
 versionNum = "sn1.0";
 tempVoiceList = [0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 25, 26, 31, 32, 36, 41, 51, 52, 53, 54, 55, 56, 81, 82, 83, 84, 85, 86, 90];
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

+ (DataManager*)getInstance
{
	return DataManagerInst;
}

+ (void)initManager;
{
	DataManagerInst = [DataManager alloc];
	[DataManagerInst parseData];
}

- (void)closeManager
{

}

- (void)parseData
{
	
}

@end
