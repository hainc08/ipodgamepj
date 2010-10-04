//
//  AlarmView.h
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 17.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@class ClockView;
@class DateView;
@interface AlarmView : UIViewController {
	UIImageView	*BgImage;
	ClockView *clockview;
	DateView  *dateview;
}
- (void)ViewCreate;
- (void)setDate:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable;
- (void)setClock:(CGPoint)point transform:(CGAffineTransform) trans  enable:(int)enable;
@end
