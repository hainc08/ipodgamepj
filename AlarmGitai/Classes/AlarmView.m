//
//  AlarmView.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmView.h"
#import "DateView.h"
#import "ClockView.h"

@implementation AlarmView

- (id)init
{
	[self ViewCreate];
	return self;
}

- (void)ViewCreate
{
	clockview = [[ClockView alloc] init];
	[clockview UpdateTime];	
	[self.view addSubview:clockview.view];
	[clockview.view setAlpha:1];
	
	dateview = [[DateView alloc] init];
	[dateview UpdateDate];
	[self.view addSubview:dateview.view];
	[dateview.view setAlpha:1];
}

- (void)setDate:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable
{
	[dateview.view setCenter:point];
	[dateview.view setTransform:trans];
	[dateview.view setAlpha:enable];
}
- (void)setClock:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable
{
	[clockview.view setCenter:point];
	[clockview.view setTransform:trans];
	[clockview.view setAlpha:enable];
}


- (void)dealloc {
	[super dealloc];
	
	
}
@end
