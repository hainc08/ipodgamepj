//
//  FontSelectController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FontSelectController.h"
#import "AlarmConfig.h"


@implementation FontSelectController
@synthesize type;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
 
}
*/

- (void)viewDidLoad {

	FontArrName = [[AlarmConfig getInstance] getFontArr];
	SelectIndex = [[AlarmConfig getInstance] getFontType]; 
	
	
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
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


#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [FontArrName count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CharSelect = @"Font";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CharSelect];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CharSelect] autorelease];
    }
    NSUInteger row = [indexPath row];
	if (row == SelectIndex )   lastIndexPath = indexPath;
    cell.textLabel.text = [FontArrName objectAtIndex:row];
    cell.accessoryType = (row == SelectIndex) ? 
	 UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;
    
    if ((newRow != oldRow ) || (newRow != SelectIndex) )
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                    indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: 
                                    lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;
    }
    SelectIndex = newRow;
	type = [FontArrName objectAtIndex:SelectIndex];
	[self.navigationController viewWillAppear:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)dealloc {
    [super dealloc];
}


@end

