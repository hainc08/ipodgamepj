//
//  CostomerCell.m
//  lotteria
//
//  Created by embmaster on 11. 2. 22..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCellTemplate.h"


@implementation ShippingCell
@synthesize ShippingName;
@synthesize ShippingAddress;
@synthesize ShippingCall;
@synthesize delbutton;

-(void)setInfo:(NSString*)_inName :(NSString *)_inMin :(NSString *)_inAddr :(NSString *)_inCall
{
	NSString *temp = [NSString stringWithFormat:@"%@ (%@)", _inName,   _inMin];
	[ShippingName setText: temp ];
	[ShippingAddress setText:_inAddr];
	[ShippingCall setText:_inCall];
	
}
-(void)setDelButtonEnable:(bool)_inenable
{
	[delbutton setAlpha:_inenable ? 1 : 0];
}
@end



@implementation ShippingOrderCell 
@synthesize ShippingName;  
@synthesize ShippingAddress;
@synthesize OrderName; 
@synthesize OrderPhone;

-(void)setInfo:(NSString*)_inName :(NSString *)_inCall :(NSString *)_inAddr :(NSString *)_inOrdrName :(NSString *)_inPhone
{
	NSString *Temp = [NSString stringWithFormat:@"%@%@",_inName, _inCall];
	[ShippingName setText:Temp];
	[ShippingAddress setText:_inAddr];
	[OrderName setText:_inOrdrName];
	[OrderPhone setText:_inPhone];
}
@end

@implementation OldOrderCell 

@synthesize OrderNumber;  
@synthesize OrderDate;  
@synthesize OrderClass; 
 
-(void)setInfo:(NSString*)_inNumber :(NSString *)_inDate :(NSString *)_inClass
{
	[OrderNumber setText:_inNumber];
	[OrderDate setText:_inDate];
	[OrderClass setText:_inClass];
}
@end

@implementation OrderListTopCell
@end
@implementation OrderListMiddleCell

@synthesize OrderProduct;   
@synthesize OrderCount;  
@synthesize OrderPrice;  

-(void)setInfo:(NSString*)_inOPd :(NSString *)_inOCnt :(NSString *)_inOPr;
{
	[OrderProduct	setText: _inOPd ];
	[OrderCount		setText:_inOCnt];
	[OrderPrice		setText:_inOPr];
}
@end

@implementation OrderListBottomCell

@synthesize OrderMoney;   
@synthesize OrderSale;  
@synthesize OrderTotal;  

-(void)setInfo:(NSString*)_inOrderMoney :(NSString *)_inOrderSale :(NSString *)_inOrderTotal
{
	[OrderMoney		setText:_inOrderMoney];
	[OrderSale		setText:_inOrderSale];
	[OrderTotal		setText:_inOrderTotal];
}
@end



@implementation OrderMenuCell
@synthesize MainCategory;
@synthesize SubCategory;
@synthesize Money;
@synthesize MenuCount;
@synthesize stock;
@synthesize delbutton;

-(void)setInfo:(NSString*)_inMainCategory :(NSString *)_inSubCategory :(NSString *)_inMoney :(NSString *)_inMenuCount
{
	[MainCategory	setText: _inMainCategory ];
	[SubCategory	setText: _inSubCategory ];
	[Money			setText: _inMoney ];
	[MenuCount		setText: _inMenuCount ];	
}
-(void)setBackgroundImage:(bool)_intype
{
	if(_intype)
	{
		[stock setAlpha:0];
		[self.imageView setImage:[UIImage imageNamed:@"bg_order_detail_box.png"]];
	}
	else
	{
		[stock setAlpha:1];
		[self.imageView setImage:[UIImage imageNamed:@"bg_order_detail_box_2.png"]];
	}
}
@end



@implementation OrderMoneyCell

@synthesize OrderMoney;  
@synthesize SaleMoney;  
@synthesize TotalMoney;  

-(void)setInfo:(NSString*)_inOMoney :(NSString *)_inSMoney :(NSString *)_inTMoney;
{
	[OrderMoney setText: _inOMoney ];
	[SaleMoney	setText:_inSMoney];
	[TotalMoney	setText:_inTMoney];
}
@end
