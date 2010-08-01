//
//  MenuCustomCell.m
//  AlarmGitai
//
//  Created by embmaster on 10. 07. 31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuCustomCell.h"


@implementation MenuCustomCell
@synthesize selectName;
@synthesize charImage;
@synthesize titleName;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];

	
}
- (void)dealloc {
	[titleName release];
    [selectName release];
	[charImage release];
    [super dealloc];
}


@end
