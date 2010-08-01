//
//  MenuController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "CharSelectController.h"
#import "MenuCustomCell.h"


@implementation MenuController
@synthesize controllers;


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}



- (void)viewDidLoad {
	self.title = @"Menu";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Disclosure Button
    CharSelectController *charselectController = [[CharSelectController alloc] initWithStyle:UITableViewStylePlain];
    charselectController.title = @"CharSelect";
	[array addObject:charselectController];		
    [charselectController release];  

    // Disclosure Button
    CharSelectController *charselectController2 = [[CharSelectController alloc] initWithStyle:UITableViewStylePlain];
    charselectController2.title = @"CharSelect2";
	[array addObject:charselectController2];
    [charselectController2 release];  
    
	self.controllers = array;
    [array release];
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

- (void)viewDidUnload {
    self.controllers = nil;
    [super viewDidUnload];
}
- (void)dealloc {
    [controllers release];
    [super dealloc];
}
#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MenuName= @"MENU";
    
    MenuCustomCell *cell = (MenuCustomCell *)[tableView dequeueReusableCellWithIdentifier: 
                             MenuName];
	
	if (cell == nil)  
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCustomCell" 
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[MenuCustomCell class]])
                cell = (MenuCustomCell *)oneObject;
    }
	
	
    NSUInteger row = [indexPath row];
    CharSelectController *controller = [controllers objectAtIndex:row];
	
    cell.titleName.text = controller.title;
	cell.selectName.text = @"ABCDE"; /* 선택된 캐릭명, 폰트명 .. 등등 표시 */

	if(row == 0 )
	cell.charImage  = nil;	         /* 캐릭이선택된경우 캐릭 이미지도 보여주면 좋을듯 */
	else
	cell.charImage  = nil;
	
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
   CharSelectController *nextController = [self.controllers  objectAtIndex:row];

    [self.navigationController pushViewController:nextController animated:YES];
}
@end
