#import "LoadSaveBar.h"
#import "DataManager.h"

@implementation LoadSaveBar

@synthesize saveIdx;

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	bgImgIdx = 0;
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	bgImgIdx = 0;

	return self;
}

-(void)setSaveIdx:(int)idx
{
	saveIdx = idx;

	if (saveIdx == 0)
	{
		[sceneImg setAlpha:0];
	}
	else
	{
		[sceneImg setAlpha:1];

		int imgIdx = [[[DataManager getInstance] getMsg2:idx] getIntVal:5];
		
		if (imgIdx != bgImgIdx)
		{
			bgImgIdx = imgIdx;
			
			UIImage* bgImg;
			
			if (bgImgIdx > 500)
			{
				bgImgIdx -= 500;

				if (bgImgIdx < 10)
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_00%ds.jpg", bgImgIdx]];
				else if (bgImgIdx < 100)
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_0%ds.jpg", bgImgIdx]];
				else
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"ev_%ds.jpg", bgImgIdx]];
			}
			else
			{
				if (bgImgIdx < 10)
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"bg_00%ds-1.jpg", bgImgIdx]];
				else if (bgImgIdx < 100)
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"bg_0%ds-1.jpg", bgImgIdx]];
				else
					bgImg = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%ds-1.jpg", bgImgIdx]];
			}
			
			[sceneImg setImage:bgImg forState:UIControlStateNormal];
		}
	}
}

-(void)setSaveDate:(NSDate*)date
{
	if (saveIdx == 0)
	{
		[dateLabel setText:@"----/--/-- --:--"];
	}
	else
	{
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
		[dateLabel setText:[dateFormatter stringFromDate:date]];
	}
}

-(UIButton*)getButton:(int)idx
{
	if (idx == 0) return sceneImg;
	else return bar;
}

@end