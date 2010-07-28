#import "GameView.h"
#import "ViewManager.h"
#import "SaveManager.h"
#import "SoundManager.h"
#import "ScineView.h"
#import "EndView.h"

void swapView(UIView* v1, UIView* v2)
{
	UIView* swap;
	swap = v1;
	v1 = v2;
	v2 = swap;
}

@implementation GameParam

@synthesize startScene;
@synthesize endScene;
@synthesize isReplay;
@synthesize replayIdx;

@end

@implementation GameView

@synthesize player;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	return self;
}

- (void)playVideoWithURL:(NSURL *)url showControls:(BOOL)showControls {
    if (!player) {
        player = [[MPMoviePlayerController alloc] initWithContentURL:url];
		
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlaying:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
		
        if (!showControls) {
            player.scalingMode = MPMovieScalingModeAspectFill;
            player.movieControlMode = MPMovieControlModeHidden;
        }
		
        [player play];
    }
}

- (IBAction)playAnime:(NSString*)name {
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:moviePath];
	
    [self playVideoWithURL:url showControls:NO];
}

- (void)didFinishPlaying:(NSNotification *)notification {
    if (player == [notification object]) {   
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
        [player release];
        player = nil;
		
		[self playBGM:scene];
    }
}

- (void)reset:(NSObject*)param
{
	[super reset:param];
	
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

		serihuBoard = (SerihuBoard*)[[ViewManager getInstance] getInstView:@"SerihuBoard"];
		[serihuBoard setCenter:CGPointMake(290, 260)];
		[self addSubview:serihuBoard];
		
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
	
	nowBgmIdx = 0;
	lastScene = NULL;
	scene = NULL;
	curSceneId = [gParam startScene];
	updateWait = 0;
	phase = LOAD;

	[self clearView];
	[blackBoard setAlpha:1];
	
	[[DataManager getInstance] resetPreload];
	[[DataManager getInstance] setCurIdx:curSceneId];
}

- (IBAction)ButtonClick:(id)sender
{
	if (phase != WAITINPUT) return;
	
	if ( sender == msgClose )
	{
		[msgClose setAlpha:0];
		[chrView[3] setAlpha:0];
		[menuButton setAlpha:0];
		[serihuBoard setAlpha:0];
		return;
	}
	if ( sender == menuButton )
	{
		[self showMenu];
		return;
	}

	if ( [msgClose alpha] == 0)
	{
		[msgClose setAlpha:1];
		[chrView[3] setAlpha:1];
		[menuButton setAlpha:1];
		[serihuBoard setAlpha:1];
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
		nowBgmIdx = 0;
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
		lastScene = scene;
		phase = LOAD;
		return;
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
				
				lastScene = scene;
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
				
				lastScene = scene;
				phase = LOAD;
			}
			break;
		case 3:
		case 4:
			if ((sender == selectButton1) || (sender == selectButton2) || (sender == selectButton3))
			{
				[[SoundManager getInstance] playFX:@"009_jg.mp3" repeat:false];
				
				int tagIdx = 0;
				if (sender == selectButton1) tagIdx = 0;
				else if (sender == selectButton2) tagIdx = 1;
				else if (sender == selectButton3) tagIdx = 2;
				
				curSceneId = [[DataManager getInstance] getTagInfo:[scene getSelectTag:tagIdx]];
				[[DataManager getInstance] setCurIdx:curSceneId];
				lastScene = scene;
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

		lastScene = scene;
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
				lastScene = NULL;
				
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
				
				[self hideScene];
				
				if ([sceneView makeBeforeScene:scene])
				{
					[self clearView];
					phase = BEFORE;
					
					[[SoundManager getInstance] stopAll];
					[[SoundManager getInstance] playFX:@"002_jg.mp3" repeat:false];
					[sceneView setAlpha:1];
					
					nowBgmIdx = 0;
					return;
				}
				
				phase = PLAY;
			}
			break;
		case PLAYWAIT:
			if (showOkTick <= frameTick) phase = WAITINPUT;
	}
	
	[super update];
}

- (void)showChr:(float)delay
{
	[UIView beginAnimations:@"show" context:NULL];
	
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:0.4];
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
	[UIView setAnimationDuration:0.4];
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
		[gameMenu reset:[gParam isReplay]];
		[self addSubview:gameMenu];
		[gameMenu setCenter:CGPointMake(240,160)];
	}
	
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
		if (bgmIdx < 10) bgmName = [[NSString alloc] initWithFormat:@"Abgm_0%d-1.mp3",bgmIdx];
		else bgmName = [[NSString alloc] initWithFormat:@"Abgm_%d-1.mp3",bgmIdx];
		
		[[SoundManager getInstance] playBGM:bgmName];
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
		if ([scene FXrepeat])
		{
			[[SoundManager getInstance] playFX:[[NSString alloc] initWithFormat:@"seLoop-%d.mp3",fxIdx] repeat:true];
		}
		else
		{
			[[SoundManager getInstance] playFX:[[NSString alloc] initWithFormat:@"se-%d.mp3",fxIdx] repeat:false];
		}
	}
}

- (void)showChar:(Scene*)s idx:(int)i
{
	CGRect imgRect;
	UIImage* img;

	//985번에 대한 처리가 필요하다.
	//이미지 보여주고...
	img = [s getChar:i];
	if ([chrView[i] image] != img)
	{
		swapView(chrView[i], oldChrView[i]);

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
	UIImage* img = [s getBg];
	if ([bgView image] != img)
	{
		swapView(bgView, oldBgView);
		
		[bgView setImage:img];

		[oldBgView setAlpha:1];
		[bgView setAlpha:0];
		
		if ([s preLoadBgIdx] > 500)
		{
			[[DataManager getInstance] setEventShow:[s preLoadBgIdx] - 500];
			[[SaveManager getInstance] saveExtraFile];
		}
		
		[bgView setFrame:CGRectMake(0, 0, [img size].width, [img size].height)];
	}
	
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
			//동영상플레이
			SerihuBoard* sBoard = (SerihuBoard*)[[ViewManager getInstance] getInstView:@"SerihuBoard"];
			[sBoard setTransform:CGAffineTransformMake(0, 1, -1, 0, 0, 0)];
			[sBoard setCenter:CGPointMake(60, 290)];
			[sBoard setSerihu:[s getChara] serihu:[s getSerihu]];
			
			//여기는 적당한 파일이름을 정해주자.
			[self playAnime:[[NSString alloc] initWithFormat:@"%d",[s animeType]]];
			
			NSArray *windows = [[UIApplication sharedApplication] windows];
			if ([windows count] > 1)
			{
				// Locate the movie player window
				UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
				// Add our overlay view to the movie player's subviews so it is 
				// displayed above it.
				[moviePlayerWindow addSubview:sBoard];
			}
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
	for (int i=0; i<4; ++i)
		[self showChar:s idx:i];
	
	[self showBg:s];

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
			[timer startTimer:5];
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
			[timer setAlpha:1];
			[timer startTimer:5];
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
	
	if ((lastScene == NULL) || ([lastScene preLoadBgmIdx] != [s preLoadBgmIdx])) [self playBGM:s];
	[self playFx:s];

	[serihuBoard setAlpha:1];
	[serihuBoard setSerihu:[scene getChara] serihu:[scene getSerihu]];
	[debugLabel setText:[[DataManager getInstance] getSceneIdxStr]];
}

- (void)hideScene
{
	[self hideChr:0.4];
}

- (void)clearView
{
	[chrView[0] setAlpha:0];
	[chrView[1] setAlpha:0];
	[chrView[2] setAlpha:0];
	[chrView[3] setAlpha:0];
	[bgView setAlpha:0];
	[serihuBoard setAlpha:0];

	nowBgmIdx = 0;
	
	[selectPanel1 setAlpha:0];
	[selectPanel2 setAlpha:0];
	[selectPanel3 setAlpha:0];
}

@end