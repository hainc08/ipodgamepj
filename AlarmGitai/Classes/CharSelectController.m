//
//  CharSelectController.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CharSelectController.h"


@implementation CharSelectController
@synthesize charlist;
@synthesize charimage;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}


/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

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

- (void)viewDidLoad {
	NSMutableArray *tmparray = [[NSMutableArray alloc] init];
    NSArray *array = [[NSArray alloc] initWithObjects:@"あかり (Akari)",
                      @"エリカ (Erika)", @"なつこ (Natsuko)", @"はるか (Haruka)",
                      @"ひとみ (Hitomi)", @"レイナ (Reina)", @"文子 (Fumiko)",
                      @"우주인 (Utsyuzin)", nil];
	NSArray *imagenames = [[NSArray alloc] initWithObjects:@"natsuko", @"natsuko", @"natsuko", @"natsuko", 
						   @"natsuko", @"reina", @"natsuko", @"natsuko", nil];
/*	NSArray *imagenames = [[NSArray alloc] initWithObjects:@"akari", @"arika", @"natsuko", @"haruka", 
						  @"hitomi", @"reina", @"fumiko", @"utsyuzin", nil];*/
    self.charlist = array;
	for(int loop =0 ; loop < [imagenames count]; loop++)
	{
		UIImage *charImg;
		charImg= [UIImage imageNamed:[NSString stringWithFormat:@"char_%@.png", [imagenames objectAtIndex:loop]]];
		[tmparray addObject:charImg];
	}
	self.charimage = tmparray;
	[tmparray release];
    [array release];
    [imagenames release];
    [super viewDidLoad];
}
- (void)viewDidUnload {
    self.charlist = nil;
    [super viewDidUnload];
}
- (void)dealloc {
    [charlist release];
    [super dealloc];
}
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [charlist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CharSelect = @"CharSelect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CharSelect];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CharSelect] autorelease];
    }
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    cell.textLabel.text = [charlist objectAtIndex:row];
	cell.imageView.image = [charimage objectAtIndex:row];
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? 
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}
#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int newRow = [indexPath row];
    int oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;
    
    if (newRow != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
                                    indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: 
                                    lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        lastIndexPath = indexPath;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

