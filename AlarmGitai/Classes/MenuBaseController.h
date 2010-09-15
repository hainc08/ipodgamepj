//
//  MenuBaseController.h
//  AlarmGitai
//
//  Created by embmaster on 10. 08. 05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuBaseController : UIViewController  {
	NSString *type;
	UIImage  *image;
	NSString *typevalue;
}
@property (nonatomic , retain) NSString *type;
@property (nonatomic , retain) UIImage  *image;
@end
