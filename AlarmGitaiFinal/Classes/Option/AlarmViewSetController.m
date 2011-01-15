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
		if (select_index == 0)
		{
			[sourceController setValue:@"alarm01" forEditedProperty:editedPropertyKey];
		}
		else
		{
			[sourceController setValue:[NSString stringWithFormat:@"bgm%02d",select_index]  forEditedProperty:editedPropertyKey];
		}
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

	switch (indexPath.row)
	{
		case 0:		cell.textLabel.text = @"００。Simple Alarm";		break;
		case 1:		cell.textLabel.text = @"０１。現実との境界線";	break;
		case 2:		cell.textLabel.text = @"０２。平和な時";	break;
		case 3:		cell.textLabel.text = @"０３。世にも怪奇な物語";	break;
		case 4:		cell.textLabel.text = @"０４。神社";	break;
		case 5:		cell.textLabel.text = @"０５。ゆらめく斜陽";	break;
		case 6:		cell.textLabel.text = @"０６。プラン６９ From M";	break;
		case 7:		cell.textLabel.text = @"０７。仮面夫婦クオリア";	break;
		case 8:		cell.textLabel.text = @"０８。純愛幻ヒプノツス";	break;
		case 9:		cell.textLabel.text = @"０９。東京エイリアン";	break;
		case 10:	cell.textLabel.text = @"１０。マインドシーカー村越";	break;
		case 11:	cell.textLabel.text = @"１１。混濁していく意識";	break;
		case 12:	cell.textLabel.text = @"１２。表から裏へ";	break;
		case 13:	cell.textLabel.text = @"１３。それはあまりに絶望的な";	break;
		case 14:	cell.textLabel.text = @"１４。ほとんど無害";	break;
		case 15:	cell.textLabel.text = @"１５。宇宙で一番愛しい人";	break;
		case 16:	cell.textLabel.text = @"１６。インドアゲーム";	break;
		case 17:	cell.textLabel.text = @"１７。神様はオレ様？";	break;
		case 18:	cell.textLabel.text = @"１８。同棲";	break;
		case 19:	cell.textLabel.text = @"１９。そして誰もいなくなった";	break;
		case 20:	cell.textLabel.text = @"２０。村越の野望";	break;
	}

	NSString* compareName;
	if (indexPath.row == 0)
	{
		compareName = @"alarm01";
	}
	else
	{
		compareName = [NSString stringWithFormat:@"bgm%02d",indexPath.row];
	}
	
	if(![compareName compare:[editedObject valueForKey:editedPropertyKey]])
	{
		select_index = indexPath.row;
		cell.accessoryType = UITableViewCellAccessoryCheckmark; 
	}
	else {
		if(	cell.accessoryType == UITableViewCellAccessoryCheckmark)
			cell.accessoryType = UITableViewCellAccessoryNone;
	}
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
	
	[[SoundManager getInstance] playSound:thisCell.textLabel.text];

 } 


- (void)dealloc {
    [super dealloc];
}



@end
