//
//  AlarmViewSetController.m
//  AlarmGitaiFinal
//
//  Created by embmaster on 10. 11. 30..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewSetController.h"
#import "SoundManager.h"


@implementation AlarmViewSetController
@synthesize editedObject,EditType,editedPropertyKey,sourceController, delegate ,optionTableView, viewbar, u_Label;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	select_index=0;
	SoundList = [[NSArray alloc] initWithObjects: @"Simple Alarm", 
												  @"現実との境界線",
													@"平和な時",
													@"世にも怪奇な物語"
													@"神社",	
													@"ゆらめく斜陽",
													@"プラン６９ From M",
													@"仮面夫婦クオリア",
													@"純愛幻ヒプノツス",
													@"東京エイリアン",
													@"マインドシーカー村越",
													@"混濁していく意識",
													@"表から裏へ",
													@"それはあまりに絶望的な",
													@"ほとんど無害",
													@"宇宙で一番愛しい人",
													@"インドアゲーム",
													@"神様はオレ様？",
													@"同棲",
													@"そして誰もいなくなった",
													@"村越の野望", nil];
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	// Title 지정 
	self.viewbar.topItem.title = editedPropertyKey;
	
	textField.hidden = NO;
	optionTableView.hidden = YES;
		if (EditType == TIMETYPE) {
		NSLocale *locale	=	[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		dateFormatter	=	[[NSDateFormatter alloc] init];
		[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[dateFormatter setDateStyle:NSDateFormatterLongStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setLocale:locale];
		[dateFormatter setDateFormat:@"h:mm a"];
		[locale release];
		
		[datePicker addTarget:self action:@selector(controlEventValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.hidden = NO;

		NSDate *date = [[NSDate alloc] init];
		if ( [editedObject valueForKey:editedPropertyKey] == nil) 
			date =  [NSDate date];
		else {
			date = [dateFormatter dateFromString:[editedObject valueForKey:editedPropertyKey]];
		}

		NSString *_retvalue =  [dateFormatter stringFromDate:date];
		
		datePicker.date = date;
		[textField setText:_retvalue];
		textField.enablesReturnKeyAutomatically = NO;
	 	
    }
	else if( EditType == NAME)  {
        datePicker.hidden = YES;
		NSString *name = [editedObject valueForKey:editedPropertyKey];
        [textField setText:name];
        [textField becomeFirstResponder];
	}
	else if( EditType == SOUND)
	{
		datePicker.hidden = YES;
		textField.hidden = YES;
		optionTableView.hidden = NO;
		[optionTableView reloadData];
	}
}

- (IBAction)done  {
	if(EditType == SOUND )
	{
			
		[sourceController setValue:[SoundList objectAtIndex:select_index]  forEditedProperty:editedPropertyKey];
		[[SoundManager getInstance] stopSound];
	}
	else
		[sourceController setValue:textField.text forEditedProperty:editedPropertyKey];
	[[SoundManager getInstance] stopSound];
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)cancel  {
	[[SoundManager getInstance] stopSound];
	[self.delegate flipsideViewControllerDidFinish:self];	

}


-(void)controlEventValueChanged:(id)sender
{
	[dateFormatter setDateFormat:@"h:mm a"];
	NSString *_retvalue =  [dateFormatter stringFromDate:[datePicker date]];
	[textField setText:_retvalue];
}
- (void)flipsideViewControllerDidFinish:(UIViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if( EditType == SOUND )
		return 19;
	return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
		
	static NSString *CellIdentifier = @"List";
		
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
	}
	
	if(![[SoundList objectAtIndex:indexPath.row] compare:[editedObject valueForKey:editedPropertyKey]])
	{
		select_index = indexPath.row;
		cell.accessoryType = UITableViewCellAccessoryCheckmark; 
	}
	else {
		if(	cell.accessoryType == UITableViewCellAccessoryCheckmark)
			cell.accessoryType = UITableViewCellAccessoryNone;
	}
	cell.textLabel.text = [NSString stringWithFormat:@"%02d。%@" , indexPath.row,  [SoundList objectAtIndex:indexPath.row]];
	return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath]; 
	NSIndexPath *oldindex = [NSIndexPath indexPathForRow:select_index inSection:0];
	UITableViewCell *oldcell = [tableView cellForRowAtIndexPath:oldindex];
	oldcell.accessoryType = UITableViewCellAccessoryNone;
 
		
	
	thisCell.accessoryType = UITableViewCellAccessoryCheckmark; 
	select_index = indexPath.row;
	NSString* Sound;
	 if (indexPath.row == 0)	Sound = @"alarm01";
	 else	Sound = [NSString stringWithFormat:@"bgm%02d",indexPath.row];
	
	[[SoundManager getInstance] playSound:Sound];
 } 


- (void)dealloc {
	[SoundList release];
    [super dealloc];
}



@end
