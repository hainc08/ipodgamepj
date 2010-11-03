//
//  MenuController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import	"AlarmConfig.h"
#include "MainView.h"
#include "ActionManager.h"


@implementation MenuController

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }

    return self;
}
		
- (void)viewDidLoad {
	defaultdata = 5;
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/
- (void)reset:(int)param
{
	defaultdata = param;
	[self.tableView reloadData];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [ NSString stringWithFormat: @"%d:%d", [ indexPath indexAtPosition: 0 ], [ indexPath indexAtPosition:1 ]];
	
	UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	
	if (cell == nil) {
		cell = [ [ [ UITableViewCell alloc ] initWithFrame:CGRectMake(0, 0, 20, 20) reuseIdentifier: CellIdentifier] autorelease ];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		switch(indexPath.row) {
			case(0):
			
			break;
			case(1):
			{
				UISlider *viewsize = [ [ UISlider alloc ] initWithFrame: CGRectMake(50, 0, 100, 20) ];
				viewsize.minimumValue = 1.0;
				viewsize.maximumValue = 6.0;
				viewsize.tag = 1;
				viewsize.value = defaultdata;
				viewsize.continuous = YES;
				[viewsize addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
				[cell addSubview:viewsize ];
				[ viewsize release ];
			}
				break;
		}
	}
	else
	{ /* Reload */
		switch(indexPath.row) {
			case(0):
				
				break;
			case(1):
			{
				NSArray *ctlarr = cell.subviews;
				
				for (id oneObject in ctlarr)
					if ([oneObject isKindOfClass:[UISlider class]])
					{
						UISlider *viewsize = (UISlider *)oneObject;
						viewsize.value = defaultdata;
						break;
					}
			}
			break;
		}
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
	return 20.0;  
}  
#pragma mark ControlEventTarget Actions

- (void)sliderAction:(UISlider*)sender
{
	DataParam *data = [[DataParam alloc ] init];
	[data setIData:sender.value];
//	[[ActionManager getInstance] setRootAction:TRANSUPDATE value:data];
	[data	 release];
}

		 
@end
