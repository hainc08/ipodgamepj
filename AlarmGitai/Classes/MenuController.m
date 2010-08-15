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

#import "SelectViewController.h"
#import "MenuBaseController.h"
#import "FontSelectController.h"
#import	"AlarmConfig.h"

@implementation UINavigationBar (UINavigationBarCategory)
- (void)setBackgroundImage:(UIImage *)image {
	if(image == nil)
	{
		return;
	}
	
	UIImageView *aTabBarImage = [[UIImageView alloc] initWithImage:image];
	aTabBarImage.frame = CGRectMake(0,0, self.frame.size.width	, self.frame.size.height );
	[self addSubview:aTabBarImage];
	[self sendSubviewToBack:aTabBarImage];
	[aTabBarImage release];
}

- (void)drawRect:(CGRect)rect{
	
	UIColor *color = [UIColor redColor];
	CGContextRef context  = UIGraphicsGetCurrentContext();
	CGContextSetFillColor(context, CGColorGetComponents([color CGColor]) );
	CGContextFillRect(context, rect);
}

@end


@implementation MenuController
@synthesize controllers;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }

    return self;
}



- (void)viewDidLoad {
	OldPath = nil;
	self.title = [AlarmConfig getInstance].CharName;
    NSMutableArray *array = [[NSMutableArray alloc] init];

    // Disclosure Button

	
    SelectViewController *hightviewController = [[SelectViewController alloc] init];
    hightviewController.title = @"HightViewType";
	hightviewController.type  = [[NSString alloc] initWithFormat:@"Type%d", [AlarmConfig getInstance].heightnum];
	[array addObject:hightviewController]; 
    [hightviewController release]; 
	
    SelectViewController *widthviewController = [[SelectViewController alloc] init];
    widthviewController.title = @"WidthViewType";
	widthviewController.type  = [[NSString alloc] initWithFormat:@"Type%d", [AlarmConfig getInstance].widthnum];
	[array addObject:widthviewController];		
    [widthviewController release];  
	
    FontSelectController *FontColtroller = [[FontSelectController alloc] initWithStyle:UITableViewStylePlain];
    FontColtroller.title = @"Font";
	FontColtroller.type  = [[AlarmConfig getInstance] getCurrFontName];
	[array addObject:FontColtroller];
    [FontColtroller release]; 
    
	
	MenuBaseController *charrotatetime	= [[MenuBaseController alloc] init];
	charrotatetime.title = @"Char Rotate";
	charrotatetime.type  = @"Time (sec)" ;
	[array addObject:charrotatetime]; 
    [charrotatetime release]; 

	self.controllers = array;
    [array release];
    [super viewDidLoad];
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
	self.title = MenuName;
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
	
	if( row != 2)
	{
    MenuBaseController *controller = [controllers objectAtIndex:row];
	
    cell.titleName.text = controller.title;
	cell.selectName.text = controller.type ; /* 선택된 캐릭명, 폰트명 .. 등등 표시 */
//	[cell.charImage setBackgroundImage:controller.image forState:];	


		if( row ==3)
		{
			[ cell.textField setAlpha:1];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		else
		{
			[ cell.textField setAlpha:0];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
	}
	else
	{
		FontSelectController *controller = [controllers objectAtIndex:row];
		
		cell.titleName.text = controller.title;
		cell.selectName.text = controller.type ; /* 선택된 캐릭명, 폰트명 .. 등등 표시 */
		//	[cell.charImage setBackgroundImage:controller.image forState:];	
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[ cell.textField setAlpha:0];
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	OldPath = indexPath;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
	
	if( OldPath != nil  )
	{
		MenuCustomCell *oldcell  = (MenuCustomCell *)[tableView cellForRowAtIndexPath:OldPath];
		[oldcell.textField resignFirstResponder];
	}
	
	if( row  != 2 )
	{
		if(row == 3)
		{
			MenuCustomCell *cell  = (MenuCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
			[cell.textField  becomeFirstResponder];
			return;
		}
		MenuBaseController *nextController = [self.controllers  objectAtIndex:row];
		[self.navigationController pushViewController:nextController animated:YES];
	}
	else
	{
		FontSelectController *nextController = [self.controllers  objectAtIndex:row];
	    [self.navigationController pushViewController:nextController animated:YES];
	}

}

		 
@end
