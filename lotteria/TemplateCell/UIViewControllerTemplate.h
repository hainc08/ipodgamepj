//
//  UITableViewControllerTemplate.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewControllerTemplate : UIViewController {
	UINavigationController *navi;
	UIViewController* backView;
}

@property (nonatomic , retain) UINavigationController *navi;
@property (nonatomic , retain) UIViewController* backView;

@end

@interface UIViewControllerDownTemplate : UIViewController {

}

@end
