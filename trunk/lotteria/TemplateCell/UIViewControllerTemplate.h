//
//  UITableViewControllerTemplate.h
//  lotteria
//
//  Created by embmaster on 11. 2. 23..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineMessage.h"

@interface UIViewControllerTemplate : UIViewController {
	UINavigationController *navi;

	NSObject* backView;
	UIButton *backButton;
	
	int naviImgIdx;
	
	NSString* lastMsg;
}

@property (nonatomic , retain) UINavigationController *navi;
@property (nonatomic , retain) NSObject* backView;
@property (nonatomic , retain) UIButton* backButton;
@property (readonly) int naviImgIdx;

- (void)back;
- (void)ShowOKAlert:(NSString *)title msg:(NSString *)message;
- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (bool)checkSession:(XmlParser*)parser;

@end

@interface UIViewControllerDownTemplate : UIViewControllerTemplate {
	bool	closetype;
	UIButton *closeButton;
}

@property (assign) bool closetype;

- (void)closePopUp;

@end
