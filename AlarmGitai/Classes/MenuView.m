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
#import "AlarmConfig.h"

#import "MenuController.h"

@implementation MenuView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	

	
}


- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	
//	[self initValue];
	[self CreatedAlarmView];
	return self;
}
/*
- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
		
	return self;
}
*/

- (void)viewDidLoad
{
	[self viewDidLoad];
	MenuController *menucontrol = [[MenuController alloc]  initWithStyle:UITableViewStyleGrouped]; 
	
	menuNavi = [[UINavigationController alloc] 
				initWithRootViewController:menucontrol];
	
	[menucontrol release];

	[self addSubview:menuNavi.view];
	
#if 0

	for( int loop = 0 ; loop < 4 ;loop++)
	{
		
		alarmView[loop] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		
		[alarmView[loop] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"layout%d.png", loop]] forState:UIControlStateNormal];
		[alarmView[loop] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
		[alarmView[loop] setCenter:CGPointMake(85 + ((loop/2)*110),235 + ((loop%2)*160))];
		[alarmView[loop] setAlpha:1];

		[alarmView[loop] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:alarmView[loop]];
	
/* config menu */
		if(loop  < 2 )
		{
		configmenu[loop] = [[UIButton alloc] initWithFrame:CGRectMake(50 + (loop*50), 115, 87, 46) ];
		[configmenu[loop] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"config%d.png", loop] ] forState:UIControlStateNormal];
		[configmenu[loop] addTarget:self action:@selector(ConfigButton:) forControlEvents:UIControlEventTouchUpInside];
		[configmenu[loop] setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
		[configmenu[loop] setAlpha:1];
		[self addSubview:configmenu[loop]];
		}
/*Font */
		Font[loop] = [[UIButton alloc] initWithFrame:CGRectMake(50 + (loop*50), 115, 87, 46) ];
		//[configmenu[loop] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"config%d.png", loop] ] forState:UIControlStateNormal];
		
		[Font[loop] addTarget:self action:@selector(FontButton:) forControlEvents:UIControlEventTouchUpInside];
		[Font[loop] setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
		[Font[loop] setAlpha:0];
		[self addSubview:Font[loop]];
	}

/* xbox Button */
	Xbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30) ];
	[Xbox setBackgroundImage:[UIImage imageNamed:@"xbox.png" ] forState:UIControlStateNormal];
	[Xbox addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[Xbox setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
//	[Xbox setCenter:CGPointMake(40, 160)];
	[Xbox setAlpha:0];
	[self addSubview:Xbox];
	choice=1;

#endif

}

- (IBAction)ButtonClick:(id)sender
{
	if(choice)
	{
	for( int loop = 0 ; loop < 4 ;loop++)
	{
		if(sender == alarmView[loop])
		{
			[alarmView[loop] setCenter:CGPointMake(85 + ((loop/2)*110),235 + ((loop%2)*160))];
			[Xbox setCenter:CGPointMake(45 + ((loop/2)*110), 165 + ((loop%2)*160))];

			[UIView	 beginAnimations:@"View" context:NULL];
			[UIView setAnimationDuration:0.7];
			[Xbox setCenter:CGPointMake(45,165)];
			[Xbox setAlpha:1];
			

			[alarmView[loop] setCenter:CGPointMake(140,312)];
			[alarmView[loop] setTransform:CGAffineTransformMake(0.6, 0,0,0.6, 0,0)];
			for( int l_loop = 0 ; l_loop < 4 ;l_loop++)
			{
				if(l_loop != loop)
				[alarmView[l_loop] setAlpha:0.3];
			}
			[alarmView[loop] setAlpha:1];
			
			[UIView commitAnimations];
			
			choicenum = loop;
			[self bringSubviewToFront:alarmView[loop]];
			[self bringSubviewToFront:Xbox];
			break;
		}
	}	
	}

	if( sender == Xbox)
	{
		[UIView beginAnimations:@"Xbox" context:nil];
		[UIView setAnimationDuration:0.7];		

		[alarmView[choicenum] setCenter:CGPointMake(85 + ((choicenum/2)*110),235 + ((choicenum%2)*160))];
		[Xbox	 setCenter:CGPointMake(45 + ((choicenum/2)*110), 165 + ((choicenum%2)*160))];
		
		[alarmView[choicenum] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
	
		for( int loop = 0 ; loop < 4 ;loop++)
		{
			[alarmView[loop] setAlpha:1];
		}
	
		[Xbox    setAlpha:0];
		
		[UIView commitAnimations];
		choice= 1;
	}
	
	
	if( sender == alarmView[choicenum] )
	{
		if(!choice)
		{
		[Xbox    setAlpha:0];
		
		[UIView	 beginAnimations:@"full" context:NULL];
		[UIView setAnimationDuration:0.7];
		
		[alarmView[choicenum] setCenter:CGPointMake(160,390)];
		[alarmView[choicenum] setTransform:CGAffineTransformMake(1, 0,0,1, 0,0)];
		
		for( int loop = 0 ; loop < 4 ;loop++)
			[alarmView[loop] setAlpha:0];
		

		[UIView commitAnimations];
			choice= 1;
		
			[AlarmConfig getInstance].heightnum = choicenum;
		}
		else
			choice = 0;
	}
}

- (void)initAlarmView
{
	for( int loop = 0 ; loop < 4 ;loop++)
	{
		[alarmView[loop] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
		[alarmView[loop] setCenter:CGPointMake(85 + ((loop/2)*110),235 + ((loop%2)*160))];
		[alarmView[loop] setAlpha:1];
	}
	[Xbox setAlpha:0];
}

- (IBAction)ConfigButton:(id)sender
{
	if(sender == configmenu[0])
	{
		for(int loop = 0 ; loop < 4 ; loop++ )
			[alarmView[loop] setAlpha:0];
		
	}
	else if ( sender == configmenu[1])
	{
		[self initAlarmView];
	}
	
	
}

- (void)dealloc {
	[super dealloc];	
}
@end
