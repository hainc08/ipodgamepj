#import "GameView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"

@implementation GameParam

@synthesize startScene;

@end

@implementation GameView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	
	GameParam* gParam = (GameParam*)param;
	
	if (isInit == false)
	{
		gameMenu = nil;

		for (int i=0; i<4; ++i)
		{
			chrView[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 320)];
			[self addSubview:chrView[i]];
			[self sendSubviewToBack:chrView[i]];

			oldChrView[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 320)];
			[self addSubview:oldChrView[i]];
			[self sendSubviewToBack:oldChrView[i]];
			
			[oldChrView[i] setAlpha:0.f];
		}

		[self bringSubviewToFront:oldChrView[3]];
		[self bringSubviewToFront:chrView[3]];

		bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[bgView setCenter:CGPointMake(240, 160)];
		[self addSubview:bgView];
		[self sendSubviewToBack:bgView];
		

		oldBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[oldBgView setCenter:CGPointMake(240, 160)];
		[self addSubview:oldBgView];
		[self sendSubviewToBack:oldBgView];
		[oldBgView setAlpha:0.f];
		
		
		isInit = true;
	}
	
	nowBgmIdx = 0;
	scene = NULL;
	curSceneId = [gParam startScene];
	showOK = false;

	[selectPanel1 setAlpha:0];
	[selectPanel2 setAlpha:0];
	[selectPanel3 setAlpha:0];
	
	[[DataManager getInstance] resetPreload];
	[[DataManager getInstance] setCurIdx:curSceneId];
}

- (IBAction)ButtonClick:(id)sender
{
	if ( showOK )
	{
		if ( sender == menuButton )
		{
			[self showMenu];
		}
		
		switch ([scene sceneType])
		{
			case 1:
				if (sender == next)
				{
					if ( [scene endNum] != -1 )
					{
						[[DataManager getInstance] gotoEnding:0 idx:[scene endNum]];
					}
					else if ([scene nextChapter] == -1)
					{
						++curSceneId;
						[[DataManager getInstance] setNextIdx:curSceneId];
					}
					else
					{
						curSceneId = [[DataManager getInstance] gotoChapter:[scene nextChapter]];
					}

					showOK = false;
					scene = NULL;
				}
				break;
			case 6:
				if (sender == next)
				{
					int tag = [scene getSelectTag:0];
					if (tag == 9999)
					{
						if ( [scene endNum] != -1 )
						{
							[[DataManager getInstance] gotoEnding:0 idx:[scene endNum]];
						}
						else
						{
							curSceneId = [[DataManager getInstance] gotoChapter:[scene nextChapter]];
						}
					}
					else
					{
						curSceneId = [[DataManager getInstance] getTagInfo:tag];
						[[DataManager getInstance] setCurIdx:curSceneId];
					}

					showOK = false;
					scene = NULL;
				}
				break;
			case 3:
			case 4:
				if ((sender == selectButton1) || (sender == selectButton2) || (sender == selectButton3))
				{
					int tagIdx = 0;
					if (sender == selectButton1) tagIdx = 0;
					else if (sender == selectButton2) tagIdx = 1;
					else if (sender == selectButton3) tagIdx = 2;

					curSceneId = [[DataManager getInstance] getTagInfo:[scene getSelectTag:tagIdx]];
					[[DataManager getInstance] setCurIdx:curSceneId];
					showOK = false;
					scene = NULL;
					
					[selectPanel1 setAlpha:0];
					[selectPanel2 setAlpha:0];
					[selectPanel3 setAlpha:0];
				}
				break;
		}
	}
}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	[super dealloc];	
}

- (void)update
{
	//전체적으로 페이드인.아웃을 만들면서 살짝 복잡해보이게 되었지만
	//페이드인.아웃이 끝나고 다음 씬으로 넘어간다는게 일단의 기본적인 마인드
	if (scene == NULL)
	{
		scene = [[DataManager getInstance] getCurScene];

		if ([scene isLoadOk])
		{
			[blackBoard setAlpha:0];
	
			CGRect imgRect;
			UIImage* img;

			showOkTick = frameTick;

			//이미지 보여주고...
			for (int i=0; i<4; ++i)
			{
				img = [scene getChar:i];
				
				if ([chrView[i] image] != img)
				{
					[oldChrView[i] setImage:[chrView[i] image]];
					[oldChrView[i] setFrame:[chrView[i] frame]];
					[oldChrView[i] setAlpha:1.f];
					[chrView[i] setImage:img];
					[chrView[i] setAlpha:0.f];
					
					if (img != NULL)
					{
						int cen = 240;

						if (i == 1) cen = 120;
						else if (i == 2) cen = 360;

						if (i == 3)
							imgRect = CGRectMake(0, 320 - [img size].height, [img size].width, [img size].height);
						else if ([img size].height > 150)
							imgRect = CGRectMake(cen - ([img size].width * 0.5f), 320 - [img size].height, [img size].width, [img size].height);
						else
							imgRect = CGRectMake(cen - ([img size].width * 0.5f), 160 - ([img size].height * 0.5f), [img size].width, [img size].height);

						[chrView[i] setFrame:imgRect];
					}

					showOkTick = frameTick + (0.2 * framePerSec);
				}
			}
			
			NSString* bgmName;
			int bgmIdx = [scene preLoadBgmIdx];
			
			if (nowBgmIdx != bgmIdx)
			{
				if (bgmIdx == 0)
				{
					[[SoundManager getInstance] stopBGM];
				}
				else
				{
					[[DataManager getInstance] setMusicShow:bgmIdx];
					if (bgmIdx < 10) bgmName = [[NSString alloc] initWithFormat:@"Abgm_0%d-1.mp3",bgmIdx];
					else bgmName = [[NSString alloc] initWithFormat:@"Abgm_%d-1.mp3",bgmIdx];
					
					[[SoundManager getInstance] playBGM:bgmName];
					[bgmName dealloc];
				}
				
				nowBgmIdx = bgmIdx;
			}

			int fxIdx = [scene FXIdx];
			if (fxIdx == 0)
			{
				[[SoundManager getInstance] stopFX];
			}
			else if (fxIdx != -1)
			{
				if ([scene FXrepeat])
				{
					[[SoundManager getInstance] playFX:[[NSString alloc] initWithFormat:@"seLoop-%d.mp3",fxIdx] repeat:true];
				}
				else
				{
					[[SoundManager getInstance] playFX:[[NSString alloc] initWithFormat:@"se-%d.mp3",fxIdx] repeat:false];
				}
			}
			
			img = [scene getBg];
			if ([bgView image] != img)
			{
				[oldBgView setImage:[bgView image]];
				[oldBgView setAlpha:1.f];
				[bgView setImage:img];
				[bgView setAlpha:0.f];
				
				if ([scene preLoadBgIdx] > 500)
				{
					[[DataManager getInstance] setEventShow:[scene preLoadBgIdx] - 500];
					[[SaveManager getInstance] saveExtraFile];
				}

				showOkTick = frameTick + (0.3 * framePerSec);
			}

			//지난 씬은 패이드 아웃
			if (([oldChrView[0] image] != NULL)||([oldChrView[1] image] != NULL)||
				([oldChrView[2] image] != NULL)||([oldChrView[3] image] != NULL)||([oldBgView image] != NULL))
			{
				[UIView beginAnimations:@"swap1" context:NULL];
				[UIView setAnimationDuration:0.2];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				if ([oldChrView[0] image] != NULL) [oldChrView[0] setAlpha:0];
				if ([oldChrView[1] image] != NULL) [oldChrView[1] setAlpha:0];
				if ([oldChrView[2] image] != NULL) [oldChrView[2] setAlpha:0];
				if ([oldChrView[3] image] != NULL) [oldChrView[3] setAlpha:0];
				if ([oldBgView image] != NULL) [oldBgView setAlpha:0];
				[UIView commitAnimations];
			}
			
			//새로운 씬은 패이드 인
			if (([chrView[0] image] != NULL)||([chrView[1] image] != NULL)||
				([chrView[2] image] != NULL)||([chrView[3] image] != NULL)||([bgView image] != NULL))
			{
				[UIView beginAnimations:@"swap2" context:NULL];
				[UIView setAnimationDuration:0.2];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				[UIView setAnimationDelay:0.1];
				if ([chrView[0] image] != NULL) [chrView[0] setAlpha:1];
				if ([chrView[1] image] != NULL) [chrView[1] setAlpha:1];
				if ([chrView[2] image] != NULL) [chrView[2] setAlpha:1];
				if ([chrView[3] image] != NULL) [chrView[3] setAlpha:1];
				if ([bgView image] != NULL) [bgView setAlpha:1];
				[UIView commitAnimations];
			}
			
			switch ([scene sceneType])
			{
				case 1:
				case 6:
					[selectPanel1 setAlpha:0];
					[selectPanel2 setAlpha:0];
					[selectPanel3 setAlpha:0];
					[next setAlpha:1];
					break;
				case 3:
					[selectPanel1 setAlpha:1];
					[selectPanel2 setAlpha:1];
					[selectPanel3 setAlpha:0];
					[selectLabel1 setText:[scene getSelect:0]];
					[selectLabel2 setText:[scene getSelect:1]];

					[selectPanel1 setCenter:CGPointMake(110+65,110)];
					[selectPanel2 setCenter:CGPointMake(240+65,110)];
					[next setAlpha:0];
					break;
				case 4:
					[selectPanel1 setAlpha:1];
					[selectPanel2 setAlpha:1];
					[selectPanel3 setAlpha:1];
					[selectLabel1 setText:[scene getSelect:0]];
					[selectLabel2 setText:[scene getSelect:1]];
					[selectLabel3 setText:[scene getSelect:2]];
					[selectPanel1 setCenter:CGPointMake(110,110)];
					[selectPanel2 setCenter:CGPointMake(240,110)];
					[selectPanel3 setCenter:CGPointMake(370,110)];
					[next setAlpha:0];
					break;
			}
			
			NSString* str = [scene getChara];
			
			if ([str length] == 0) [nameBoard setAlpha:0];
			else [nameBoard setAlpha:1];

			[charaLabel setText:str];
			[charaLabel2 setText:str];
			[charaLabel3 setText:str];

			str = [scene getSerihu];

			[serihuLabel setText:str];
			[serihuLabel2 setText:str];
			[serihuLabel3 setText:str];
			[debugLabel setText:[[DataManager getInstance] getSceneIdxStr]];
		}
		else
		{
			scene = NULL;
		}
	}

	if (showOkTick == frameTick) showOK = true;

	[super update];
}

- (void)showMenu
{
	if (gameMenu == nil)
	{
		gameMenu = [[ViewManager getInstance] getInstView:@"GameMenu"];
		[gameMenu reset];
		[self addSubview:gameMenu];
		[gameMenu setCenter:CGPointMake(240,160)];
	}
	
	[gameMenu setAlpha:1];
}

@end