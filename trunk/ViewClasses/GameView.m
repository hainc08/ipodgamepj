#import "GameView.h"
#import "ViewManager.h"

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
	
	if (isInit == false)
	{
		for (int i=0; i<3; ++i)
		{
			chrView[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 320)];
			[self addSubview:chrView[i]];
			[self sendSubviewToBack:chrView[i]];

			oldChrView[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 320)];
			[self addSubview:oldChrView[i]];
			[self sendSubviewToBack:oldChrView[i]];
			
			[oldChrView[i] setAlpha:0.f];
		}
		
		bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
		[bgView setCenter:CGPointMake(240, 160)];
		[self addSubview:bgView];
		[self sendSubviewToBack:bgView];
		

		oldBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
		[oldBgView setCenter:CGPointMake(240, 160)];
		[self addSubview:oldBgView];
		[self sendSubviewToBack:oldBgView];
		[oldBgView setAlpha:0.f];

		isInit = true;
	}
	
	scene = NULL;
	curSceneId = 0;
	showOK = false;

	[[DataManager getInstance] resetPreload];
	[[DataManager getInstance] setCurIdx:curSceneId];
}

- (IBAction)ButtonClick:(id)sender
{
	if ( showOK )
	{
		++curSceneId;
		[[DataManager getInstance] setNextIdx:curSceneId];
		showOK = false;
		scene = NULL;
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

		if ([scene isLoaded])
		{
			CGRect imgRect;
			UIImage* img;

			showOkTick = frameTick;

			//이미지 보여주고...
			for (int i=0; i<3; ++i)
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
						imgRect = CGRectMake(i*50, 320 - [img size].height, [img size].width, [img size].height);
						[chrView[i] setFrame:imgRect];
					}

					showOkTick = frameTick + (0.2 * framePerSec);
				}
			}

			img = [scene getBg];
			if ([bgView image] != img)
			{
				[oldBgView setImage:[bgView image]];
				[oldBgView setAlpha:1.f];
				[bgView setImage:img];
				[bgView setAlpha:0.f];

				showOkTick = frameTick + (0.3 * framePerSec);
			}

			//지난 씬은 패이드 아웃
			if (([oldChrView[0] image] != NULL)||([oldChrView[1] image] != NULL)||
				([oldChrView[2] image] != NULL)||([oldBgView image] != NULL))
			{
				[UIView beginAnimations:@"swap1" context:NULL];
				[UIView setAnimationDuration:0.2];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				if ([oldChrView[0] image] != NULL) [oldChrView[0] setAlpha:0];
				if ([oldChrView[1] image] != NULL) [oldChrView[1] setAlpha:0];
				if ([oldChrView[2] image] != NULL) [oldChrView[2] setAlpha:0];
				if ([oldBgView image] != NULL) [oldBgView setAlpha:0];
				[UIView commitAnimations];
			}
			
			//새로운 씬은 패이드 인
			if (([chrView[0] image] != NULL)||([chrView[1] image] != NULL)||
				([chrView[2] image] != NULL)||([bgView image] != NULL))
			{
				[UIView beginAnimations:@"swap2" context:NULL];
				[UIView setAnimationDuration:0.2];
				[UIView setAnimationCurve:UIViewAnimationCurveLinear];
				[UIView setAnimationDelay:0.1];
				if ([chrView[0] image] != NULL) [chrView[0] setAlpha:1];
				if ([chrView[1] image] != NULL) [chrView[1] setAlpha:1];
				if ([chrView[2] image] != NULL) [chrView[2] setAlpha:1];
				if ([bgView image] != NULL) [bgView setAlpha:1];
				[UIView commitAnimations];
			}
			
			[serihuLabel setText:[scene getSerihu]];
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

@end