//
//  MenuView.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuView.h"
#import "AlarmView.h"
#import "ViewManager.h"
#import "DateView.h"
#import "ClockView.h"

@implementation MenuView



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	

	
}


- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	[self CreatedAlarmView];
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
		
	return self;
}

- (void)CreatedAlarmView
{

	for( int loop = 0 ; loop < 5 ;loop++)
	{
		View[loop] = (AlarmView *)[[ViewManager getInstance] getInstView:@"AlarmView"];
		buttonView[loop] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		
		[View[loop] setFrame:CGRectMake(0, 0, 320, 480) ];
		
		[View[loop] setDate:CGPointMake(100, 200) transform:CGAffineTransformMake(0.4, 0,0,0.4, 0,0)  enable:1];
		[View[loop] setClock:CGPointMake(100, 200) transform:CGAffineTransformMake(0.4, 0,0,0.4, 0,0)   enable:1];
		[View[loop] setCenter:CGPointMake(85 + ((loop/2)*110),235 + ((loop%2)*160))];
		[View[loop] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
			
		if(loop == 4)
			[View[loop] setAlpha:0];
		else
			[View[loop] setAlpha:1];

		[buttonView[loop] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[View[loop] addSubview:buttonView[loop]];
		[self addSubview:View[loop]];
	}
	
	Xbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30) ];
	[Xbox setBackgroundImage:[UIImage imageNamed:@"xbox.png" ] forState:UIControlStateNormal];
	[Xbox addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[Xbox setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
//	[Xbox setCenter:CGPointMake(40, 160)];
	[Xbox setAlpha:0];
	[self addSubview:Xbox];
}

- (IBAction)ButtonClick:(id)sender
{
	
	for( int loop = 0 ; loop < 4 ;loop++)
	{
		if(sender == buttonView[loop])
		{
			[View[4] setCenter:CGPointMake(85 + ((loop/2)*110),235 + ((loop%2)*160))];
			[Xbox setCenter:CGPointMake(45 + ((loop/2)*110), 165 + ((loop%2)*160))];

			[UIView	 beginAnimations:@"View" context:NULL];
			[UIView setAnimationDuration:0.7];
			[Xbox setCenter:CGPointMake(45,165)];
			[Xbox setAlpha:1];
			
			[View[4] setAlpha:1];
			[View[4] setCenter:CGPointMake(140,312)];
			[View[4] setTransform:CGAffineTransformMake(0.6, 0,0,0.6, 0,0)];
			for( int loop = 0 ; loop < 4 ;loop++)
			{
				[View[loop] setAlpha:0.3];
			}
			[UIView commitAnimations];
			
			choicenum = loop;
			break;
		}
	}	

	if( sender == Xbox)
	{
		[UIView beginAnimations:@"Xbox" context:nil];
		[UIView setAnimationDuration:0.7];		

		[View[4] setCenter:CGPointMake(85 + ((choicenum/2)*110),235 + ((choicenum%2)*160))];
		[Xbox	 setCenter:CGPointMake(45 + ((choicenum/2)*110), 165 + ((choicenum%2)*160))];
		
		[View[4] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
	
		for( int loop = 0 ; loop < 4 ;loop++)
			[View[loop] setAlpha:1];
	
		[View[4] setAlpha:0];
		[Xbox    setAlpha:0];
		
		[UIView commitAnimations];
		
		
	}
	
	
	if( sender == buttonView[4])
	{
		[Xbox    setAlpha:0];
		
		[UIView	 beginAnimations:@"full" context:NULL];
		[UIView setAnimationDuration:0.7];
		
		[View[4] setCenter:CGPointMake(160,390)];
		[View[4] setTransform:CGAffineTransformMake(1, 0,0,1, 0,0)];
		
		for( int loop = 0 ; loop < 4 ;loop++)
			[View[loop] setAlpha:0];
		

		[UIView commitAnimations];
		
	}
}

- (void) BaseSoundPlay
{
}

- (void)dealloc {
	[super dealloc];	
}
@end
