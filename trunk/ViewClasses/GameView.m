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
		chrView[0] = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 320)];
		chrView[1] = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 300, 320)];
		chrView[2] = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 300, 320)];
		
		[self addSubview:chrView[0]];
		[self addSubview:chrView[1]];
		[self addSubview:chrView[2]];

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
					[chrView[i] setAlpha:1];
					[chrView[i] setImage:img];
				}
			}
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