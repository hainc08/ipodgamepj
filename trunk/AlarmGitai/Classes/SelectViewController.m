//
//  SelectViewController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SelectViewController.h"


@implementation SelectViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	for( int loop = 0 ; loop < 4 ;loop++)
	{
 
		alarmView[loop] = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		[alarmView[loop] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"layout%d.png", loop]] forState:UIControlStateNormal];
		[alarmView[loop] setTransform:CGAffineTransformMake(0.32, 0,0,0.32, 0,0)];
		[alarmView[loop] setCenter:CGPointMake(85 + ((loop/2)*110),85 + ((loop%2)*160))];
		[alarmView[loop] setAlpha:1];
 
		[alarmView[loop] addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:alarmView[loop]];
 }
	
	/* xbox Button */
	Xbox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30) ];
	[Xbox setBackgroundImage:[UIImage imageNamed:@"xbox.png" ] forState:UIControlStateNormal];
	[Xbox addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[Xbox setTransform:CGAffineTransformMake(0.7, 0,0,0.7, 0,0)];
	//	[Xbox setCenter:CGPointMake(40, 160)];
	[Xbox setAlpha:0];
	[self.view addSubview:Xbox];
	choice=1;
}


- (IBAction)ButtonClick:(id)sender
{
	if(choice)
	{
		for( int loop = 0 ; loop < 4 ;loop++)
		{
			if(sender == alarmView[loop])
			{
				[alarmView[loop] setCenter:CGPointMake(85 + ((loop/2)*110),85 + ((loop%2)*160))];
				[Xbox setCenter:CGPointMake(45 + ((loop/2)*110),15 + ((loop%2)*160))];
				
				[UIView	 beginAnimations:@"View" context:NULL];
				[UIView setAnimationDuration:0.7];
				[Xbox setCenter:CGPointMake(45,15)];
				[Xbox setAlpha:1];
				
				
				[alarmView[loop] setCenter:CGPointMake(140,162)];
				[alarmView[loop] setTransform:CGAffineTransformMake(0.6, 0,0,0.6, 0,0)];
				for( int l_loop = 0 ; l_loop < 4 ;l_loop++)
				{
					if(l_loop != loop)
						[alarmView[l_loop] setAlpha:0.3];
				}
				[alarmView[loop] setAlpha:1];
				
				[UIView commitAnimations];
				
				choicenum = loop;
				[self.view bringSubviewToFront:alarmView[loop]];
				[self.view bringSubviewToFront:Xbox];
				break;
			}
		}	
	}
	
	if( sender == Xbox)
	{
		[UIView beginAnimations:@"Xbox" context:nil];
		[UIView setAnimationDuration:0.7];		
		
		[alarmView[choicenum] setCenter:CGPointMake(85 + ((choicenum/2)*110),85 + ((choicenum%2)*160))];
		[Xbox	 setCenter:CGPointMake(45 + ((choicenum/2)*110), 15 + ((choicenum%2)*160))];
		
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
			[self setType:[[NSString alloc] initWithFormat:@"Type_%d", choicenum]];
			[self.navigationController viewDidAppear:YES];
			[self.navigationController popToRootViewControllerAnimated:YES];
		}
		else
			choice = 0;
	} 
}

- (IBAction)SaveButton:(id)sender
{
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
