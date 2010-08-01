//
//  CharSelectController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CharSelectController : UITableViewController {
	NSArray *charlist;
	NSArray *charimage;
	NSIndexPath    *lastIndexPath;

}
@property (nonatomic ,retain ) NSArray *charlist;
@property (nonatomic ,retain ) NSArray *charimage;
@end
