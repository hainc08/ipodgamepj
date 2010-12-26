#import "RepeatSetView.h"

@implementation RepeatSetView

@synthesize delegate;
@synthesize alarm;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Alarm Repeat";

	img[0] = [[UIImage imageNamed:@"Unselected.png"] retain];
	img[1] = [[UIImage imageNamed:@"Selected.png"] retain];
	
	img[2] = [[UIImage imageNamed:@"WeekUnselected.png"] retain];
	img[3] = [[UIImage imageNamed:@"WeekSelected.png"] retain];

	[neverRepeat setBackgroundImage:img[0] forState:UIControlStateNormal];
	[everyDay setBackgroundImage:img[0] forState:UIControlStateNormal];
	[everyWeek setBackgroundImage:img[0] forState:UIControlStateNormal];
	[weekView setAlpha:0];

	if (alarm.RepeatIdx == 0)
	{
		lastSelect = neverRepeat;
		[neverRepeat setBackgroundImage:img[1] forState:UIControlStateNormal];
	}
	else if (alarm.RepeatIdx == 1)
	{
		lastSelect = everyDay;
		[everyDay setBackgroundImage:img[1] forState:UIControlStateNormal];
	}
	else
	{
		lastSelect = everyWeek;
		[everyWeek setBackgroundImage:img[1] forState:UIControlStateNormal];
		[weekView setAlpha:1];
		
		int rIdx = alarm.RepeatIdx - 2;

		int idx;

		if (rIdx & 0x01) idx = 3; else idx = 2;
		[sonDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x02) idx = 3; else idx = 2;
		[monDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x04) idx = 3; else idx = 2;
		[tueDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x08) idx = 3; else idx = 2;
		[wedDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x10) idx = 3; else idx = 2;
		[theDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x20) idx = 3; else idx = 2;
		[friDay setBackgroundImage:img[idx] forState:UIControlStateNormal];

		if (rIdx & 0x40) idx = 3; else idx = 2;
		[satDay setBackgroundImage:img[idx] forState:UIControlStateNormal];
	}
}

- (IBAction)selectOption:(id)sender
{
	if (lastSelect == sender) return;
	
	lastSelect = sender;

	[neverRepeat setBackgroundImage:img[0] forState:UIControlStateNormal];
	[everyDay setBackgroundImage:img[0] forState:UIControlStateNormal];
	[everyWeek setBackgroundImage:img[0] forState:UIControlStateNormal];

	[sender setBackgroundImage:img[1] forState:UIControlStateNormal];

	if (sender == neverRepeat)
	{
		[weekView setAlpha:0];
	}
	else if (sender == everyDay)
	{
		[weekView setAlpha:0];
	}
	else if (sender == everyWeek)
	{
		[weekView setAlpha:1];

		//평일만 선택해놓자.
		[sonDay setBackgroundImage:img[2] forState:UIControlStateNormal];
		[monDay setBackgroundImage:img[3] forState:UIControlStateNormal];
		[tueDay setBackgroundImage:img[3] forState:UIControlStateNormal];
		[wedDay setBackgroundImage:img[3] forState:UIControlStateNormal];
		[theDay setBackgroundImage:img[3] forState:UIControlStateNormal];
		[friDay setBackgroundImage:img[3] forState:UIControlStateNormal];
		[satDay setBackgroundImage:img[2] forState:UIControlStateNormal];
	}
}

- (IBAction)selectWeekday:(id)sender
{
	if ([sender backgroundImageForState:UIControlStateNormal] == img[2])
		[sender setBackgroundImage:img[3] forState:UIControlStateNormal];
	else
		[sender setBackgroundImage:img[2] forState:UIControlStateNormal];
}

- (IBAction)done:(id)sender {

	int result = 0;

	if (lastSelect == neverRepeat)
	{
		result = 0;
	}
	else if (lastSelect == everyDay)
	{
		result = 1;
	}
	else
	{
		if ([sonDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x01;
		if ([monDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x02;
		if ([tueDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x04;
		if ([wedDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x08;
		if ([theDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x10;
		if ([friDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x20;
		if ([satDay backgroundImageForState:UIControlStateNormal] == img[3]) result |= 0x40;

		result += 2;
	}
	
	[alarm setRepeatIdx:result];
	[[AlarmConfig getInstance] SaveConfig];
	
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (void)dealloc {
	[img[0] release];
	[img[1] release];
	[img[2] release];
	[img[3] release];
	[super dealloc];	
}

@end
