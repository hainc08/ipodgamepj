//
//  AlarmConfig.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 08.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmConfig.h"

static AlarmConfig *AlarmConfigInst;

@implementation AlarmConfig



+ (AlarmConfig *)getInstance
{
	return AlarmConfigInst;
}
+ (void) initmanager {
	AlarmConfigInst = [AlarmConfig alloc];
	[AlarmConfigInst loadConfig];
}
- (void)loadConfig
{
	FontType = 1;
	FontUpImageType = [[NSString alloc] initWithString:@"ub"];
	FontBgImageType = [[NSString alloc] initWithString:@"dw"];
}
- (int)getFontType
{
	return FontType;
}

- (NSString *)getUpImageType
{
	return FontUpImageType;
}

- (NSString *)getBgImageType
{
	return FontBgImageType;
}

- (void)dealloc {
	[super dealloc];	
	[FontUpImageType  release];
	[FontBgImageType  release];
}
- (void) closeManager {
}

@end
