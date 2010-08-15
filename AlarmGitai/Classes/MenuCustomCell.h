//
//  MenuCustomCell.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuCustomCell : UITableViewCell < UITextFieldDelegate > {
	UILabel *titleName;
    UILabel *selectName;
	UIImageView *charImage;
	UITextField *textField;
	BOOL keyboardHiden ;
}
@property (nonatomic, retain) IBOutlet UILabel *titleName;
@property (nonatomic, retain) IBOutlet UILabel *selectName;
@property (nonatomic, retain) IBOutlet UIImageView *charImage;
@property (nonatomic, retain) IBOutlet	UITextField *textField;

- (void)setHidenTextField;
@end

