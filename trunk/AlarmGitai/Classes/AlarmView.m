//
//  AlarmView.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmView.h"
#import "ViewManager.h"
#import "DateView.h"
#import "ClockView.h"

@implementation AlarmView
- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self ViewCreate];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	return self;
}

- (void)ViewCreate
{
	
	clockview = (ClockView *)[[ViewManager getInstance] getInstView:@"ClockView"];
	[clockview UpdateTime];	
	[self addSubview:clockview];
	[clockview setAlpha:1];
	
	dateview = (DateView *)[[ViewManager getInstance] getInstView:@"DateView"];
	[dateview UpdateDate];
	[self addSubview:dateview];
	[dateview setAlpha:1];
}

- (void)setDate:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable
{
	[dateview setCenter:point];
	[dateview setTransform:trans];
	[dateview setAlpha:enable];
}
- (void)setClock:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable
{
	[clockview setCenter:point];
	[clockview setTransform:trans];
	[clockview setAlpha:enable];
}


- (void)dealloc {
	[super dealloc];
	
	
}
@end
