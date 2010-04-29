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
		}
		
		bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 360)];
		[bgView setCenter:CGPointMake(240, 160)];
		[self addSubview:bgView];
		[self sendSubviewToBack:bgView];

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
	if (scene == NULL)
	{
		scene = [[DataManager getInstance] getCurScene];

		if ([scene isLoaded])
		{
			CGRect imgRect;
			//이미지 보여주고...
			for (int i=0; i<3; ++i)
			{
				UIImage* img = [scene getChar:i];
				if (img == NULL)
				{
					[chrView[i] setAlpha:0];
				}
				else
				{
					imgRect = CGRectMake(i*50, 320 - [img size].height, [img size].width, [img size].height);

					[chrView[i] setAlpha:1];
					[chrView[i] setImage:img];
					[chrView[i] setFrame:imgRect];
				}
			}

			[bgView setImage:[scene getBg]];
			showOK = true;
		}
		else
		{
			scene = NULL;
		}
	}

	if ( showOK )
	{
		++curSceneId;
		[[DataManager getInstance] setNextIdx:curSceneId];
		showOK = false;
		scene = NULL;
	}

	[super update];
}

@end