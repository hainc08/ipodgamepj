//
//  FontSelectController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 06.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontSelectController : UITableViewController {
	NSString *type;
	NSArray  *FontArrName;
	int		SelectIndex;
	NSIndexPath    *lastIndexPath;
}
@property (nonatomic , retain ) NSString *type;
@end
