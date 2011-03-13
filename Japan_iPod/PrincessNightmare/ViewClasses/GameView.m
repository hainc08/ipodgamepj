#import "GameView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"
#import "ScineView.h"
#import "EndView.h"

@implementation GameParam

@synthesize startScene;
@synthesize endScene;
@synthesize isReplay;
@synthesize replayIdx;

@end

@implementation GameView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	framePerSec = 20.f;

	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	framePerSec = 20.f;

	return self;
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	
	if (gParam != nil) [gParam release];
	gParam = (GameParam*)param;
	
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

		movieBoard = (MovieBoard*)[[ViewManager getInstance] getInstView:@"MovieBoard"];
		[movieBoard setCenter:CGPointMake(240, 160)];
		[movieUI addSubview:movieBoard];

		if ([[ViewManager getInstance] movieMode] == 1)
		{
			//4.0이하의 버전
			serihuBoard2 = nil;
		}
		else
		{
			serihuBoard2 = [[SerihuBoard alloc] init];
			[serihuBoard2.view setCenter:CGPointMake(290, 260)];
			[movieUI addSubview:serihuBoard2.view];
			[movieUI bringSubviewToFront:next2];
		}

		[self sendSubviewToBack:movieUI];
		[movieUI setAlpha:0];
		
		serihuBoard = [[SerihuBoard alloc] init];
		[serihuBoard.view setCenter:CGPointMake(290, 260)];
		[self addSubview:serihuBoard.view];

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
		
		[self bringSubviewToFront:msgClose];
		[self bringSubviewToFront:skip];

		sceneView = (SceneView*)[[ViewManager getInstance] getInstView:@"SceneView"];
		[self addSubview:sceneView];
		[sceneView setAlpha:0];

		timer = (Timer*)[[ViewManager getInstance] getInstView:@"Timer"];
		[self addSubview:timer];
		[timer setCenter:CGPointMake(40,50)];
		[timer setTransform:CGAffineTransformMake(0.8f, 0, 0, 0.8f, 0, 0)];
		[timer setAlpha:0];
		
		[self bringSubviewToFront:blackBoard];

		isInit = true;
	}
	else
	{
		[gameMenu setAlpha:0.f];
		
		for (int i=0; i<4; ++i)
		{
			[chrView[i] setImage:nil];
			[chrView[i] setAlpha:0.f];
			[oldChrView[i] setImage:nil];
			[oldChrView[i] setAlpha:0.f];
		}
		
		[movieUI setAlpha:0.f];

		[bgView setImage:nil];
		[bgView setAlpha:0.f];
		[oldBgView setImage:nil];
		[oldBgView setAlpha:0.f];
		
		[sceneView setAlpha:0];

		[timer setAlpha:0];
		[timer stop];
	}
	
	scene = NULL;
	curSceneId = [gParam startScene];
	updateWait = 0;
	phase = LOAD;

	[self clearView];
	[blackBoard setAlpha:1];
	
	[[DataManager getInstance] setCurIdx:curSceneId];

	isSkipMode = false;

	chrData[0] = chrData[1] = chrData[2] = chrData[3] = nil;
	bgData = nil;
}

- (IBAction)SkipButtonClick:(id)sender
{
	if (isSkipMode) isSkipMode = false;
	else
	{
		if ([[SaveManager getInstance] getSceneExp2:curSceneId])
		{
			isSkipMode = true;
		}

		[self ButtonClick:next];

//		for (int i=1; i<=127; ++i)
//		{
//			Scenario* scenario = [[DataManager getInstance] getScenario:i];
//			if ([scenario startIdx] > curSceneId) return;
//			if ([scenario endIdx] < curSceneId) continue;
			
			//if ([[SaveManager getInstance] getSceneExp:i])
//			{
//				isSkipMode = true;
//				skipEnd = [scenario endIdx];
//				[self ButtonClick:next];
//			}
//			return;
//		}
	}
	return;
}

- (IBAction)ButtonClick:(id)sender
{
	if (phase != WAITINPUT) return;
	if (sender == next2) return [self ButtonClick:next];
	
	if ( sender == msgClose )
	{
		[msgClose setAlpha:0];
		[chrView[3] setAlpha:0];
		[menuButton setAlpha:0];
		[serihuBoard.view setAlpha:0];
		[skip setAlpha:0];
		return;
	}
	if ( sender == menuButton )
	{
		[[SaveManager getInstance] saveSceneExp2File:true];
		[self showMenu];
		return;
	}

	if ( [msgClose alpha] == 0)
	{
		[skip setAlpha:1];
		[msgClose setAlpha:1];
		[chrView[3] setAlpha:1];
		[menuButton setAlpha:1];
		[serihuBoard.view setAlpha:1];
		return;
	}

	if ([self checkEnd:scene]) return;
	
	if ([sceneView makeAfterScene:scene])
	{
		phase = AFTER;
		
		[self hideChr:0.6];
		
		[[SoundManager getInstance] stopAll];
		
		[UIView beginAnimations:@"scene" context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[sceneView setAlpha:1];
		[UIView commitAnimations];
		return;
	}
	
	bool isMoved = false;
	for (int i=0; i<[scene flagStrCount]; ++i)
	{
		NSArray *listItems = [[scene getFlagStr:i] componentsSeparatedByString:@"_"];
		if ([listItems count] < 2) continue;
		
		NSString* item0 = (NSString*)[listItems objectAtIndex:0];
		int idx = [(NSString*)[listItems objectAtIndex:1] intValue];
		int data = 1;
		if ([listItems count] > 2) data = [(NSString*)[listItems objectAtIndex:2] intValue];
		
		if ([item0 compare:@"fgE"] == NSOrderedSame)
			[[SaveManager getInstance] setFlag:idx];
		else if ([item0 compare:@"fgE2"] == NSOrderedSame)
			[[SaveManager getInstance] setFlag2:idx data:data];
		
		if (isMoved == false)
		{
			if ([item0 compare:@"fgS"] == NSOrderedSame)
			{
				if ([[SaveManager getInstance] getFlag:idx])
				{
					curSceneId = [[DataManager getInstance] getTagInfo:data];
					[[DataManager getInstance] setCurIdx:curSceneId];
					isMoved = true;
				}
			}
			else if ([item0 compare:@"fgS2"] == NSOrderedSame)
			{
				if ([[SaveManager getInstance] getFlag2:idx] == data)
				{
					int tag = [(NSString*)[listItems objectAtIndex:3] intValue];
					
					curSceneId = [[DataManager getInstance] getTagInfo:tag];
					[[DataManager getInstance] setCurIdx:curSceneId];
					isMoved = true;
				}
			}
		}
	}
	
	if (isMoved)
	{
		phase = LOAD;
		return;
	}
	
	switch ([scene sceneType])
	{
		case 1:
			if (sender == next)
			{
				if ([movieBoard isPLaying])
				{
					[movieBoard stopMovie];
					[self sendSubviewToBack:movieUI];
					[movieUI setAlpha:0];
				}
				
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
				
				phase = LOAD;
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
				
				phase = LOAD;
			}
			break;
		case 3:
		case 4:
			isSkipMode = false;
			
			if ((sender == selectButton1) || (sender == selectButton2) || (sender == selectButton3))
			{
				[[SoundManager getInstance] playFX:@"009_jg.mp3" repeat:false];
				
				int tagIdx = 0;
				if (sender == selectButton1) tagIdx = 0;
				else if (sender == selectButton2) tagIdx = 1;
				else if (sender == selectButton3) tagIdx = 2;
				
				curSceneId = [[DataManager getInstance] getTagInfo:[scene getSelectTag:tagIdx]];
				[[DataManager getInstance] setCurIdx:curSceneId];
				phase = LOAD;
				
				[selectPanel1 setAlpha:0];
				[selectPanel2 setAlpha:0];
				[selectPanel3 setAlpha:0];
				
				[timer stop];
			}
			break;
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
	if ([[ViewManager getInstance] movieMode] == 1)
	{
		if ([movieBoard isPLaying] && [movieBoard update])
		{
			[self ButtonClick:next2];
		}
	}

	if (updateWait > 0)
	{
		--updateWait;
		[super update];
		return;
	}
	
	if ([timer update] == false)
	{
		//타이머 다되었음...
		updateWait = (1 * framePerSec);

		int tagIdx = 0;

		if ([scene sceneType] == 3) tagIdx = 2;
		else tagIdx = 3;
		
		curSceneId = [[DataManager getInstance] getTagInfo:[scene getSelectTag:tagIdx]];
		[[DataManager getInstance] setCurIdx:curSceneId];

		phase = LOAD;
		
		[selectPanel1 setAlpha:0];
		[selectPanel2 setAlpha:0];
		[selectPanel3 setAlpha:0];
	}
	
	switch (phase) {
		case BEFORE:
		case AFTER:
			if ([sceneView showEnd])
			{
				if (phase == BEFORE) phase = PLAY;
				else if (phase == AFTER)
				{
					curSceneId = [[DataManager getInstance] gotoChapter:[scene nextChapter]];
					phase = LOAD;
				}
			}
			else
			{
				[sceneView update];
			}
			break;
		case PLAY:
			[self playScene:scene];
			phase = PLAYWAIT;
			break;
		case LOAD:
			//전체적으로 페이드인.아웃을 만들면서 살짝 복잡해보이게 되었지만
			//페이드인.아웃이 끝나고 다음 씬으로 넘어간다는게 일단의 기본적인 마인드
			scene = [[DataManager getInstance] getCurScene];
			
			if ((scene != NULL) && [scene isLoadOk])
			{
				if ([gParam isReplay])
				{
					if ([gParam endScene] < [scene sceneId])
					{
						ScineParam* param = [ScineParam alloc];
						[param setReplayIdx:[gParam replayIdx]];
						[[ViewManager getInstance] changeView:@"ScineView" param:param];
					}
				}
				
				[[DataManager getInstance] checkSceneExp:[scene sceneId]];
				if ([blackBoard alpha] == 1)
				{
					[UIView beginAnimations:@"start" context:NULL];
					[UIView setAnimationDuration:1];
					[UIView setAnimationCurve:UIViewAnimationCurveLinear];
					[blackBoard setAlpha:0];
					[UIView commitAnimations];
				}

				if ([sceneView makeBeforeScene:scene])
				{
					[self clearView];
					phase = BEFORE;
					
					[[SoundManager getInstance] stopAll];
					[[SoundManager getInstance] playFX:@"002_jg.mp3" repeat:false];
					[sceneView setAlpha:1];
					
					return;
				}
				
				phase = PLAY;
			}
			break;
		case PLAYWAIT:
			if (showOkTick <= frameTick) phase = WAITINPUT;
			if (isSkipMode)
			{
				[self ButtonClick:next];
			}
	}
	
	[super update];
}

- (void)showChr:(float)delay
{
	[UIView beginAnimations:@"show" context:NULL];
	
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[chrView[0] setAlpha:1];
	[chrView[1] setAlpha:1];
	[chrView[2] setAlpha:1];
	[chrView[3] setAlpha:1];
	[bgView setAlpha:1];
	[UIView commitAnimations];
}

- (void)hideChr:(float)delay
{
	[UIView beginAnimations:@"hide" context:NULL];
	
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[oldChrView[0] setAlpha:0];
	[oldChrView[1] setAlpha:0];
	[oldChrView[2] setAlpha:0];
	[oldChrView[3] setAlpha:0];
	[oldBgView setAlpha:0];
	[UIView commitAnimations];
}

- (void)showMenu
{
	if (gameMenu == nil)
	{
		gameMenu = [[ViewManager getInstance] getInstView:@"GameMenu"];
		[self addSubview:gameMenu];
		[gameMenu setCenter:CGPointMake(240,160)];
	}
	
	[gameMenu reset:[gParam isReplay]];
	[[SoundManager getInstance] playFX:@"010_se.mp3" repeat:false];
	[gameMenu setAlpha:1];
}

- (void)playBGM:(Scene*)s
{
	NSString* bgmName;
	int bgmIdx = [s preLoadBgmIdx];

	if (bgmIdx == 0)
	{
		[[SoundManager getInstance] stopBGM];
	}
	else
	{
		[[DataManager getInstance] setMusicShow:bgmIdx];
		bgmName = [[NSString alloc] initWithFormat:@"Abgm_%02d-1.mp3",bgmIdx];
		
		[[SoundManager getInstance] playBGM:bgmName idx:bgmIdx];
		[bgmName dealloc];
	}
}	

- (void)playFx:(Scene*)s
{
	int fxIdx = [s FXIdx];
	if (fxIdx == 0)
	{
		[[SoundManager getInstance] stopFX];
	}
	else if (fxIdx != -1)
	{
		NSString* fxName;
		if ([scene FXrepeat])
		{
			fxName = [[NSString alloc] initWithFormat:@"seLoop-%d.mp3",fxIdx];
			[[SoundManager getInstance] playFX2:fxName idx:fxIdx-1 repeat:true];
		}
		else
		{
			fxName = [[NSString alloc] initWithFormat:@"se-%d.mp3",fxIdx];
			[[SoundManager getInstance] playFX2:fxName idx:fxIdx+16-1 repeat:false];
		}
		[fxName release];
	}
}

- (void)showChar:(Scene*)s idx:(int)i
{
	CGRect imgRect;
	UIImage* img = nil;

	//985번에 대한 처리가 필요하다.
	//이미지 보여주고...
	NSData* data = [s getCharData:i];
	
	int idx = [s getCharIdx:i];
	if ((idx >= 501)&&(idx <= 522))
	{
		[[SaveManager getInstance] setItemFlag:idx-500];
	}

	if (data != chrData[i])
	{
		if (data == nil) img = nil;
		else if (data == oldChrData[i]) img = [oldChrView[i] image];
		else img = [[[UIImage alloc] initWithData:data] autorelease];
		
		oldChrData[i] = chrData[i];
		chrData[i] = data;
		
		UIImageView* swap = chrView[i];
		chrView[i] = oldChrView[i];
		oldChrView[i] = swap;

		[chrView[i] setImage:img];

		[oldChrView[i] setAlpha:1];
		[chrView[i] setAlpha:0];
		
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

- (void)showBg:(Scene*)s
{
	UIImage* img = nil;
	NSData* data = [s getBgData];
	if (data != bgData)
	{
		if (data == nil) img = nil;
		else img = [[[UIImage alloc] initWithData:data] autorelease];
		bgData = data;

		UIImageView* swap = bgView;
		bgView = oldBgView;
		oldBgView = swap;
		
		[bgView setImage:img];

		[oldBgView setAlpha:1];
		[bgView setAlpha:0];
		
		[bgView setFrame:CGRectMake(0, 0, [img size].width, [img size].height)];
	}

	if ([s preLoadBgIdx] > 500)
	{
		if ([[DataManager getInstance] setEventShow:[s preLoadBgIdx] - 500])
			[[SaveManager getInstance] saveExtraFile];
	}

	//스킵모드에서는 에니를 보여주지 않는다.
	if (isSkipMode) return;
	
	switch ([s animeType])
	{
		case 0:
			if ([[bgView image] size].height == 320)
				[bgView setCenter:CGPointMake(240, 160)];
			else
			{
				if ([s preLoadBgIdx] == 791)
					[bgView setCenter:CGPointMake(240, 340 - (int)([img size].height / 2))];
				else
					[bgView setCenter:CGPointMake(240, (int)([[bgView image] size].height * 0.5f) - 20)];
			}
			showOkTick = frameTick + (0.2 * framePerSec);
			break;
		case 1:
			[bgView setCenter:CGPointMake(240, 340 - (int)([img size].height / 2))];
			
			[UIView beginAnimations:@"anime" context:NULL];
			[UIView setAnimationDuration:2];
			[UIView setAnimationDelay:1];
			[UIView setAnimationCurve:UIViewAnimationCurveLinear];
			[bgView setCenter:CGPointMake(240, (int)([img size].height * 0.5f) - 20)];
			[UIView commitAnimations];
			
			showOkTick = frameTick + (3.0 * framePerSec);
			break;
		case 3:
			[bgView setCenter:CGPointMake(240, (int)([img size].height * 0.5f) - 20)];
			
			[UIView beginAnimations:@"anime" context:NULL];
			[UIView setAnimationDuration:2];
			[UIView setAnimationDelay:1];
			[UIView setAnimationCurve:UIViewAnimationCurveLinear];
			[bgView setCenter:CGPointMake(240, 340 - (int)([img size].height / 2))];
			[UIView commitAnimations];
			
			showOkTick = frameTick + (3.0 * framePerSec);
			break;
		case 400:
		case 401:
		case 402:
		case 403:
		{
			//여기는 적당한 파일이름을 정해주자.
			[self bringSubviewToFront:movieUI];
			[movieUI setAlpha:1];
			[[SoundManager getInstance] stopBGM];
			[movieBoard playScene:s];
			if (serihuBoard2 != nil)
			{
				[serihuBoard2 setSerihu:[s getChara] serihu:[s getSerihu]];
			}
			
			[serihuBoard.view setAlpha:0];
		}
	}
}

- (bool)checkEnd:(Scene*)s
{
	if ([s endNum] != -1)
	{
		[[SoundManager getInstance] stopAll];
		EndParam* endParam = [EndParam alloc];
		[endParam setEndNum:[s endNum]];
		[[ViewManager getInstance] changeView:@"EndView" param:endParam];
		
		return true;
	}
	
	return false;
}

- (void)playScene:(Scene*)s
{
	if (isSkipMode)
	{
		if ([[SaveManager getInstance] getSceneExp2:[s sceneId]] == false) isSkipMode = false;
	}

	[[SaveManager getInstance] setSceneExp2:[s sceneId]];

	[self playBGM:s];
	[self playFx:s];

	for (int i=0; i<4; ++i)
		[self showChar:s idx:i];
	
	[self showBg:s];
	
	[self hideScene];

	if ([s animeType] == 4)
	{
		[UIView beginAnimations:@"show" context:NULL];
		[UIView setAnimationDuration:0.4];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[chrView[2] setAlpha:1];
		[chrView[3] setAlpha:1];
		[bgView setAlpha:1];
		[UIView commitAnimations];
		
		[chrView[0] setAlpha:1];
		[chrView[1] setAlpha:1];
		[chrView[0] setCenter:CGPointMake(240, 160)];
		[chrView[1] setCenter:CGPointMake(240, 160)];

		[UIView beginAnimations:@"anime" context:NULL];
		[UIView setAnimationDuration:4];
		[UIView setAnimationDelay:1];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[chrView[0] setCenter:CGPointMake(480 + 240 + 120, 0 - 160 - 80)];
		[chrView[1] setCenter:CGPointMake(0 - 240 - 120, 320 + 160 + 80)];
		[UIView commitAnimations];
		
		showOkTick = frameTick + (5.0 * framePerSec);
	}
	else
	{
		[self showChr:0];
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
			[timer setAlpha:1];
			[timer startTimer:10 * framePerSec];
			[selectPanel1 setAlpha:1];
			[selectPanel2 setAlpha:1];
			[selectPanel3 setAlpha:0];
			[selectLabel1 setText:[scene getSelect:0]];
			[selectLabel2 setText:[scene getSelect:1]];
			
			[selectPanel1 setCenter:CGPointMake(110+65,110)];
			[selectPanel2 setCenter:CGPointMake(240+65,110)];
			[next setAlpha:0];

			[[SoundManager getInstance] playFX:@"009_jg.mp3" repeat:false];
			isSkipMode = false;
			break;
		case 4:
			[timer setAlpha:1];
			[timer startTimer:10 * framePerSec];
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

			[[SoundManager getInstance] playFX:@"009_jg.mp3" repeat:false];
			isSkipMode = false;
			break;
	}

	[serihuBoard.view setAlpha:1];
	[serihuBoard setSerihu:[scene getChara] serihu:[scene getSerihu]];
//	[debugLabel setText:[[DataManager getInstance] getSceneIdxStr]];
}

- (void)hideScene
{
	[self hideChr:0.f];
}

- (void)clearView
{
	[chrView[0] setAlpha:0];
	[chrView[1] setAlpha:0];
	[chrView[2] setAlpha:0];
	[chrView[3] setAlpha:0];
	[bgView setAlpha:0];
	[serihuBoard.view setAlpha:0];
	
	[selectPanel1 setAlpha:0];
	[selectPanel2 setAlpha:0];
	[selectPanel3 setAlpha:0];
}


@end