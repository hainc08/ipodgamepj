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

-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr :(NSString *)_inCall
{
	[ShippingName setText: _inName ];
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
@synthesize OrderPhone;

-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr :(NSString *)_inPhone
{
	[ShippingName setText:_inName];
	[ShippingAddress setText:_inAddr];
	[OrderPhone setText:_inPhone];
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
	[OrderProduct	setText: [[DataManager getInstance] getCategoryName:_inOPd]];
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
@synthesize target;
@synthesize selector;

-(void)setMenuData:(int)category :(CartItem *)_inData
{
	item = _inData;
	ProductData *p_data = [[DataManager getInstance] getProduct:_inData.menuId];
	[MainCategory	setText: [[DataManager getInstance] getCategoryName:p_data.category]];
	[SubCategory	setText: p_data.name ];
	[Money			setText: [[DataManager getInstance] getPriceStr:p_data.price ]];
	[MenuCount		setText: [NSString stringWithFormat:@"%d", _inData.count]];	
	
	[self setBackgroundImage:item.StoreMenuOnOff];
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

-(IBAction)CellDeleteButton
{
	[[DataManager getInstance]  removeCartItem:item];
	[target performSelector:selector withObject:@"delete" ];
}
- (void)setDelegate:(id)aTarget selector:(SEL)aSelector
{
	self.target = aTarget;
	self.selector = aSelector;
}

@end



@implementation StoreAddressCell
@synthesize StoreName;
@synthesize StoreAddress;

-(void)setInfo:(NSString*)_inName :(NSString *)_inAddr
{
	[StoreName setText: _inName ];
	[StoreAddress setText:_inAddr];
	
}

@end


