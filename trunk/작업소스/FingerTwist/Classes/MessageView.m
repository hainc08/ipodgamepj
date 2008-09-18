#import "MessageView.h"

@implementation MessageView

- (void)setMessage:(NSString*)msg
{	
	if (msg == msgCache) return;
	[self reset];

/*	if (msg == @"GameOver")
	{
		[GameOver setAlpha:1.f];
	}
	else if ( msg == @"StageClear" )
	{
		[StageClear setAlpha:1.f];
	}
	else*/
	{
		[Undefined setText:msg];
		[Undefined setAlpha:1.f];
	}
	msgCache = msg;
}

- (void)reset
{
	[GameOver setAlpha:0.f];
	[StageClear setAlpha:0.f];
	[Undefined setAlpha:0.f];
}

@end
