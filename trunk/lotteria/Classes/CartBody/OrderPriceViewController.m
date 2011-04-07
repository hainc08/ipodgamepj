//
//  OrderSettlementViewController.m
//  lotteria
//
//  Created by embmaster on 11. 2. 27..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OrderPriceViewController.h"
#import "OrderEndViewController.h"
#import "HttpRequest.h"
#import "XmlParser.h"
#import <time.h>
@implementation OrderPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];

	Comment.returnKeyType = UIReturnKeyDone;
	[MoneyTxt setText:[[DataManager getInstance] getPriceStr:[[DataManager getInstance] getCartPrice]]];
	self.navigationItem.title = @"결제하기";
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if(httpRequest != nil)
		[httpRequest release];
    [super dealloc];
}
#pragma mark  -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction) OrderButton:(id)sender
{
	
	if(sender == Money)
	{
				OrderType = MONEY;
		[self ShowOKCancleAlert:ORDER_TITLE msg:MONEY_PAY_MSG];

	}
	else if(sender == Money2)
	{
				OrderType = MONEY_PERSONAL;
		[self ShowOKCancleAlert:ORDER_TITLE msg:MONEY_PERSONAL_PAY_MSG];
	}
	else if(sender == Card)
	{
				OrderType = CARD;
		[self ShowOKCancleAlert:ORDER_TITLE msg:CARD_PAY_MSG];
	}
	else if(sender == Card2)
	{
			OrderType = ONLINE;
		[self ShowOKAlert:nil msg:ONLINE_PAY_MSG];
	}
}

#pragma mark -
#pragma mark AlertView

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[super alertView:actionSheet clickedButtonAtIndex:buttonIndex];

	if(buttonIndex)
	{
		[self OrderParamSetting];
	}
}


- (NSArray *) GetMenuData:(NSString *)menuId group_id:(int)g_id  cnt:(int)ordercnt
{
	NSMutableArray	*MenuData = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
	ProductData *prdata = [[DataManager getInstance] getProduct:menuId];
						   
	[MenuData	 addObject:[NSString stringWithFormat:@"item_menu_id=%@", 
				[ menuId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
						   
	[MenuData addObject:[NSString stringWithFormat:@"item_menu_dis=%@", 
				[[prdata menuDIS] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 할인코드		
	[MenuData addObject:[NSString stringWithFormat:@"item_group_id=%d", g_id]];	// GroupID 는 하나의 세트 내용을 모두
	[MenuData addObject:[NSString stringWithFormat:@"item_disc_flag="]];	// 할인 플레그 
	[MenuData addObject:[NSString stringWithFormat:@"item_free_flag=%@", 
				( [[prdata category] compare:@"Z10"] == NSOrderedSame ) ? @"Y" : @"" ]];
	[MenuData addObject:[NSString stringWithFormat:@"item_disc_cd=%@",
				( [[prdata category] compare:@"Z10"] == NSOrderedSame ) ? @"04" : @"" ]];	// 할인 코드  ( 장난감 '04' )
	[MenuData addObject:[NSString stringWithFormat:@"item_qty=%d", ordercnt]];	// 주문 개수 
	[MenuData addObject:[NSString stringWithFormat:@"item_pay_money=%d", [prdata price ]]]; // 매뉴 가격
	[MenuData addObject:[NSString stringWithFormat:@"item_disc_money=%d", 
				( [[prdata category] compare:@"Z10"] == NSOrderedSame ) ? [prdata price] : 0 ]];	// 할인 가격 ( 장난감은 넣어야한다 )

	return [[MenuData copy] autorelease];
}

- (void)OrderParamSetting
{
	
	NSUInteger GroupIDIndex = 0;
	NSMutableArray	*Body = [[NSMutableArray alloc] initWithCapacity:0];
	httpRequest = [[HTTPRequest alloc] init];
	
	Order *Temp = [[DataManager getInstance] UserOrder];
	

	
	NSMutableArray	*MenuData = [[NSMutableArray alloc] initWithCapacity:0];

	NSMutableArray *ShopItemArr = [[DataManager getInstance] getShopCart];
	
	for (CartItem *objectInstance in ShopItemArr) {
		if (objectInstance.menuId  != nil )
		{
			ProductData *prdata = [[DataManager getInstance] getProduct:objectInstance.menuId];
						
			[MenuData addObjectsFromArray:[self GetMenuData:objectInstance.menuId group_id:GroupIDIndex cnt:objectInstance.count]];
			if	 ( [[prdata set_flag] compare:@"3"] == NSOrderedSame )
			{
				/* 이달에 장난감을 찾아 해당 장난감코드를 준다. */
				time_t cur_time =time(NULL);
				struct tm *time = localtime(&cur_time);
				NSString *MenuID = [NSString stringWithFormat:@"LE00%02d", time->tm_mon+1];
				[MenuData addObjectsFromArray:[self GetMenuData:MenuID group_id:GroupIDIndex cnt:objectInstance.count]];
			}
		}
		
		if (objectInstance.dessertId  != nil)
		{
			[MenuData addObjectsFromArray:[self GetMenuData:objectInstance.dessertId group_id:GroupIDIndex cnt:objectInstance.count]];
			
		}
		if (objectInstance.drinkId  != nil)
		{
			[MenuData addObjectsFromArray:[self GetMenuData:objectInstance.drinkId group_id:GroupIDIndex cnt:objectInstance.count]];
		}
		GroupIDIndex++;
	}
	[Body	 addObject:[NSString stringWithFormat:@"cust_delivery_seq=%@", Temp.UserAddr.Seq ]];
	
	[Body	 addObject:[NSString stringWithFormat:@"cust_id=%@", [[DataManager getInstance] cust_id] ]];
	[Body	 addObject:[NSString stringWithFormat:@"branch_id=%@", Temp.UserAddr.branchid ]];
	[Body	 addObject:[NSString stringWithFormat:@"cust_nm=%@", 
						[ Temp.UserName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]];
	[Body	 addObject:[NSString stringWithFormat:@"phone=%@", 
						[ Temp.UserPhone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]];
	
	[Body	 addObject:[NSString stringWithFormat:@"order_memo=%@", 
						(Comment.text != nil ? [Comment.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"") ]];
	
	[Body	 addObject:@"order_flag=3"];	//아이폰은  3번  
	
	[Body	 addObject:[NSString stringWithFormat:@"terminal_flag=%@",(OrderType == CARD ? @"Y" : @"N")]];
	[Body	 addObject:[NSString stringWithFormat:@"business_date=%@",Temp.UserAddr.business_date]];
	
	[Body	 addObject:[NSString stringWithFormat:@"reser_flag=%@", Temp.OrderType ? @"Y" : @"N"  ]]; //예약 플래그
	
	[Body	 addObject:[NSString stringWithFormat:@"reser_time=%@00", 
						Temp.OrderType ?	[Temp.OrderTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  : @"" ]];	// 6자리 시간
	
	[Body	 addObject:[NSString stringWithFormat:@"pay_money=%d", Temp.OrderMoney + Temp.OrderSaleMoney ]];
	[Body	 addObject:[NSString stringWithFormat:@"disc_money=%d", Temp.OrderSaleMoney ]];

	
	
	[Body addObjectsFromArray:MenuData];		[MenuData release];
	
	[Body addObject:[NSString stringWithFormat:@"pay_master_pay_money=%d", Temp.OrderMoney ]];  // 결제금액    
	[Body addObject:[NSString stringWithFormat:@"pay_master_disc_money=%d", Temp.OrderSaleMoney ]];  // 할인금액
	[Body addObject:[NSString stringWithFormat:@"pay_master_save_money=%d", 0 ]];  // 적립금액	
	[Body addObject:[NSString stringWithFormat:@"pay_master_receipt_flag=%@", ( OrderType == MONEY_PERSONAL ? @"Y" : @"") ]];  // 영수증사용여부
					
	 
	[Body addObject:[NSString stringWithFormat:@"pay_detail_pay_cd=%@", 
					 (OrderType == MONEY) ? @"02" : @"01" ]];  // 결제종류 (01 : 카드 , 현금영수증  02:현금  03: 교환권 04:할인 05:적립)
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 카드번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_ex=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 유효기간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_acc=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 할부
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_control_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인넘버
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_money=%d",Temp.OrderMoney]];  // 승인금액 ( 토탈금액 )
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_date=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인일자
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_time=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인시간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_cd=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사코드
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_nm=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사명
	[Body addObject:[NSString stringWithFormat:@"pay_detail_terminal_id=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 터미널 ID 
	[Body addObject:[NSString stringWithFormat:@"pay_detail_msg=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인메시지
	 
	 
	if(Temp.OrderSaleMoney > 0)
	 {
	[Body addObject:[NSString stringWithFormat:@"pay_detail_pay_cd=%@",@"04"]];  // 결제종류 ( 장난감은 추가해야됨.)
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 카드번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_ex=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 유효기간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_acc=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 할부
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_control_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인넘버
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_money=%d",Temp.OrderSaleMoney] ];  // 승인금액 ( 장난감 금액 )
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_date=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인일자
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_time=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인시간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_cd=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사코드
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_nm=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사명
	[Body addObject:[NSString stringWithFormat:@"pay_detail_terminal_id=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 터미널 ID 
	[Body addObject:[NSString stringWithFormat:@"pay_detail_msg=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인메시지
	 }
	
	//if(Temp.UserPhone)  // 일반전화 ? 핸드폰 체크 ( 핸드폰 번호는 배송입력받거나 , 로그인 사용자 번호던가 
	[Body addObject:[NSString stringWithFormat:@"personal_mobile=%@", (OrderType == MONEY_PERSONAL ?  Temp.UserPhone : @"") ]];  // 현금영수증 전화번호
	
	
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbOrder.asmx/ws_insOrderXml" bodyObject:nil bodyArray:Body];
}

- (void)didReceiveFinished:(NSString *)result
{
	
	// 로그인 성공하면 이뷰는 사라진다. 
	// xml에서 로그인처리 
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:ERROR_TITLE msg:HTTP_ERROR_MSG];	
	}
	else {
		
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		if ([self checkSession:xmlParser] == false) 
		{
			[xmlParser release];
			[httpRequest release];
			httpRequest = nil;
			return;
		}
		Element* root = [xmlParser getRoot:@"RESULT_CODE"];
	
		if(![[root getValue] compare:@"Y"])
		{
			[[DataManager getInstance] allremoveCartItem];
		
			OrderEndViewController* popView = [[OrderEndViewController alloc] initWithNibName:@"OrderEnd"  bundle:nil];
			[[ViewManager getInstance] popUp:popView owner:nil];
		
		}
		else if([[root getValue] compare:@"N"] == NSOrderedSame || [[root getValue] compare:@"C"] == NSOrderedSame  )
			[self ShowOKAlert:ERROR_TITLE msg:ORDER_ERROR_MSG];	// 장바구니 첫하면으로 이동하자~


		[xmlParser release];
	}
	[httpRequest release];
	httpRequest = nil;
}
- (void) refresh
{

}
@end
