//
//  MapSearchViewController.h
//  lotteria
//
//  Created by embmaster on 11. 3. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTemplate.h"

@class HTTPRequest;


@interface MapSearchViewController : UIViewControllerTemplate {
	
	IBOutlet UILabel *SearchLabel;
	IBOutlet UITableView *SearchTable;
	IBOutlet UIButton *MapButton;
	NSMutableArray *AddressArr;
	
	int			StoreType;
	HTTPRequest *httpRequest;
	NSString	*Dong;	// 검색 동 
}
@property (nonatomic, retain) NSString *Dong;
- (void)GetStoreInfo;
- (IBAction)MapButton;
@end
