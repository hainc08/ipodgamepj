#import "MessageView.h"

@implementation MessageView

- (void)setMessage:(NSString*)msg showNext:(bool)showNext
{	
	if (showNext) [TouchNext setAlpha:1.f];
	else [TouchNext setAlpha:0.f];

	if (msg == msgCache) return;

	[self reset];
	
	if (msg == @"GameOver") [GameOver setAlpha:1.f];
	else if ( msg == @"StageClear" ) [StageClear setAlpha:1.f];
	else if ( msg == @"Start" ) [Start setAlpha:1.f];
	else if ( msg == @"Ready" ) [Ready setAlpha:1.f];
	else
	{
		[Undefined setText:msg];
		[Undefined setAlpha:1.f];
	}
	msgCache = msg;
}

- (void)setMessage:(NSString*)msg
{
	[self setMessage:msg showNext:false];	
}

- (void)initImg
{
	for (int i=0; i<10; ++i)
	{
		number[i] = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
		number_s[i] = [UIImage imageNamed:[NSString stringWithFormat:@"s%d.png", i]];
	}
	difficultImg[0] = [UIImage imageNamed:@"easy.png"];
	difficultImg[1] = [UIImage imageNamed:@"normal.png"];
	difficultImg[2] = [UIImage imageNamed:@"hard.png"];
}

- (void)showStageInfo:(int)idx button:(int)count diff:(int)diff
{
	[TouchNext setAlpha:1.f];
	[self reset];
	[StageInfo setAlpha:1.f];
	[StageNumber10 setAlpha:1.f];
    [StageNumber1 setAlpha:1.f];	
	[ButtonNumber10 setAlpha:1.f];
    [ButtonNumber1 setAlpha:1.f];
	[Difficult setAlpha:1.f];

	[StageNumber10 setImage:number[idx/10]];
	[StageNumber1 setImage:number[idx%10]];
	[ButtonNumber10 setImage:number_s[count/10]];
	[ButtonNumber1 setImage:number_s[count%10]];
	[Difficult setImage:difficultImg[diff]];
	
	msgCache = @"StageInfo";
}

- (void)reset
{
	[GameOver setAlpha:0.f];
	[StageClear setAlpha:0.f];
	[Undefined setAlpha:0.f];
    [GameOver setAlpha:0.f];
    [StageClear setAlpha:0.f];
    [Undefined setAlpha:0.f];
    [Ready setAlpha:0.f];
    [Start setAlpha:0.f];
    [StageInfo setAlpha:0.f];
	[StageNumber10 setAlpha:0.f];
    [StageNumber1 setAlpha:0.f];	
	[ButtonNumber10 setAlpha:0.f];
    [ButtonNumber1 setAlpha:0.f];	
    [Difficult setAlpha:0.f];	
}

@end
