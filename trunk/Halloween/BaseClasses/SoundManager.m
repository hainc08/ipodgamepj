#import "SoundManager.h"

static SoundManager *SoundManagerInst;

@implementation SoundManager

+ (SoundManager*)getInstance
{
	return SoundManagerInst;
}

+ (void)initManager
{
	SoundManagerInst = [SoundManager alloc];

    NSBundle *mainBundle = [NSBundle mainBundle];
	SoundManagerInst->mute = false;

	for (int i=0; i<Max_Sound; ++i)
	{
		SoundManagerInst->requestCount[i] = 0;
	}
}

- (void)setSound:(int)idx sound:(SoundEffect*)sound
{
	sounds[idx] = sound;	
}

- (void)closeManager
{
	for (int i=0; i<Max_Sound; ++i)
	{
		[sounds[i] release];
	}
}

- (void)setMute:(bool)m
{
	mute = m;
}

- (bool)getMute
{
	return mute;
}

- (void)playSound:(int)idx
{
	if (mute) return;
	[sounds[idx] play];
}

- (void)soundRequest:(int)idx
{
	if (mute) return;
	++requestCount[idx];
}

- (void)playRequest
{
	if (mute) return;

	for (int i=0; i<Max_Sound; ++i)
	{
		if (requestCount[i] == 0) continue;
		[sounds[i] play];
		//요청이 여러개 들어오면 다음 프레임에도 사운드를 발생시킨다.
		//단, 두번 이상의 요청은 그냥 두번으로 취급한다.
		if (requestCount[i] >= 2) requestCount[i] = 1; 
		else requestCount[i] = 0;
	}
}

@end
