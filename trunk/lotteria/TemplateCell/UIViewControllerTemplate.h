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

	NSObject* backView;
	UIButton *backButton;
	
	int naviImgIdx;
}

@property (nonatomic , retain) UINavigationController *navi;
@property (nonatomic , retain) NSObject* backView;
@property (nonatomic , retain) UIButton* backButton;
@property (readonly) int naviImgIdx;

- (void)back;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface UIViewControllerDownTemplate : UIViewControllerTemplate {
	bool	closetype;
}

@property (assign) bool closetype;

@end
