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
	
	isShowScene = false;
	nowBgmIdx = 0;
	scene = NULL;
	curSceneId = [gParam startScene];
	showOK = false;
	gameEnd = -1;
	updateWait = 0;

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
			showOK = false;
			scene = NULL;
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
					
					[timer stop];
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
		showOK = false;
		scene = NULL;
		
		[selectPanel1 setAlpha:0];
		[selectPanel2 setAlpha:0];
		[selectPanel3 setAlpha:0];
	}
	
	if (isShowScene)
	{
		if ([sceneView showEnd])
		{
			isShowScene = false;
			[[SoundManager getInstance] restart];
			
			[UIView beginAnimations:@"scene" context:NULL];
			[UIView setAnimationDuration:1];
			[UIView setAnimationCurve:UIViewAnimationCurveLinear];
			[sceneView setAlpha:0];
			[UIView commitAnimations];
			
			[self willShow:0.4];
		}
		else
		{
			[sceneView update];
		}
	}
	//전체적으로 페이드인.아웃을 만들면서 살짝 복잡해보이게 되었지만
	//페이드인.아웃이 끝나고 다음 씬으로 넘어간다는게 일단의 기본적인 마인드
	else if (scene == NULL)
	{
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
			
			if (gameEnd != -1)
			{
				[[SoundManager getInstance] stopAll];
				EndParam* endParam = [EndParam alloc];
				[endParam setEndNum:gameEnd];
				[[ViewManager getInstance] changeView:@"EndView" param:endParam];
				return;
			}
			
			gameEnd = [scene endNum];

			[[DataManager getInstance] checkSceneExp:[scene sceneId]];
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
				UIImageView* tempBGView = oldBgView;
				oldBgView = bgView;
				bgView = tempBGView;

				[oldBgView setAlpha:1.f];
				[bgView setImage:img];
				[bgView setAlpha:0.f];
				
				if ([scene preLoadBgIdx] > 500)
				{
					[[DataManager getInstance] setEventShow:[scene preLoadBgIdx] - 500];
					[[SaveManager getInstance] saveExtraFile];
				}

				[bgView setFrame:CGRectMake(0, 0, [img size].width, [img size].height)];
				
				showOkTick = frameTick + (0.3 * framePerSec);

				switch ([scene animeType])
				{
					case 0:
						[bgView setCenter:CGPointMake(240, 160)];
						break;
					case 1:
						showOkTick = frameTick + (3.0 * framePerSec);

						[bgView setCenter:CGPointMake(240, 340 - (int)([img size].height / 2))];

						[UIView beginAnimations:@"anime" context:NULL];
						[UIView setAnimationDuration:2];
						[UIView setAnimationDelay:1];
						[UIView setAnimationCurve:UIViewAnimationCurveLinear];
						[bgView setCenter:CGPointMake(240, (int)([img size].height / 2) - 20)];
						[UIView commitAnimations];
						break;
					case 2:
					{
						//동영상플레이
						SerihuBoard* sBoard = (SerihuBoard*)[[ViewManager getInstance] getInstView:@"SerihuBoard"];
						[sBoard setTransform:CGAffineTransformMake(0, 1, -1, 0, 0, 0)];
						[sBoard setCenter:CGPointMake(60, 290)];
						
						//여기는 적당한 파일이름을 정해주자.
						[self playAnime:@"sample_iPod"];
						
						NSArray *windows = [[UIApplication sharedApplication] windows];
						if ([windows count] > 1)
						{
							// Locate the movie player window
							UIWindow *moviePlayerWindow = [[UIApplication sharedApplication] keyWindow];
							// Add our overlay view to the movie player's subviews so it is 
							// displayed above it.
							[moviePlayerWindow addSubview:sBoard];
						}
						break;
					}
				}
			}

			//지난 씬은 패이드 아웃
			if (([oldChrView[0] image] != NULL)||([oldChrView[1] image] != NULL)||
				([oldChrView[2] image] != NULL)||([oldChrView[3] image] != NULL)||([oldBgView image] != NULL))
			{
				[self nowHide];
			}
			
			isShowScene = [sceneView makeScene:scene];
			if (isShowScene)
			{
				[[SoundManager getInstance] pause];

				[UIView beginAnimations:@"scene" context:NULL];
				[UIView setAnimationDuration:1];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				[sceneView setAlpha:1];
				[UIView commitAnimations];
			}
			//새로운 씬은 패이드 인
			else if (([chrView[0] image] != NULL)||([chrView[1] image] != NULL)||
				([chrView[2] image] != NULL)||([chrView[3] image] != NULL)||([bgView image] != NULL))
			{
				[self willShow:0.2];
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
			
			[serihuBoard setSerihu:[scene getChara] serihu:[scene getSerihu]];
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

- (void)nowHide
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

- (void)willShow:(float)delay
{
	[UIView beginAnimations:@"swap2" context:NULL];
	[UIView setAnimationDuration:delay];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDelay:0.1];
	if ([chrView[0] image] != NULL) [chrView[0] setAlpha:1];
	if ([chrView[1] image] != NULL) [chrView[1] setAlpha:1];
	if ([chrView[2] image] != NULL) [chrView[2] setAlpha:1];
	if ([chrView[3] image] != NULL) [chrView[3] setAlpha:1];
	if ([bgView image] != NULL) [bgView setAlpha:1];
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
	
	[gameMenu setAlpha:1];
}

@end