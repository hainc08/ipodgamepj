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

@implementation OrderPriceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
		httpRequest = [[HTTPRequest alloc] init];
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
		[self ShowOKCancleAlert:@"주문" msg:@"현금주문이 맞습니까?"];

	}
	else if(sender == Money2)
	{
				OrderType = MONEY;
		[self ShowOKCancleAlert:@"주문" msg:@"현금+현금영수증 주문이 맞습니까?"];
	}
	else if(sender == Card)
	{
				OrderType = CARD;
		[self ShowOKCancleAlert:@"주문" msg:@"방문 카드결제 주문이 맞습니까?"];
	}
	else if(sender == Card2)
	{
			OrderType = CARD;
		[self ShowOKCancleAlert:@"주문" msg:@"온라인 결제 주문이 맞습니까?"];
	}
}

#pragma mark -
#pragma mark AlertView

- (void)ShowOKCancleAlert:(NSString *)title msg:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if(buttonIndex)
	{
		OrderEndViewController *OrderEnd = [[OrderEndViewController alloc] initWithNibName:@"OrderEnd"  bundle:nil];
	
		[self.navigationController pushViewController:OrderEnd animated:YES];
		[OrderEnd release];
	}
}




- (void)OrderParamSetting:(int)_inType
{
	
	NSUInteger GroupIDIndex = 0;
	NSMutableArray	*Body = [[NSMutableArray alloc] initWithCapacity:0];
	
	
	Order *Temp = [[DataManager getInstance] UserOrder];
	
	[Body	 addObject:[NSString stringWithFormat:@"cust_delivery_seq=%@", Temp.UserAddr.addrSeq ]];
	
	[Body	 addObject:[NSString stringWithFormat:@"cust_id=%@",[[DataManager getInstance] accountId] ]];
	[Body	 addObject:[NSString stringWithFormat:@"phone=%@", 
						[ Temp.UserPhone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]];
	[Body	 addObject:[NSString stringWithFormat:@"cust_nm=%@", 
						[ Temp.UserName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]];
	
	[Body	 addObject:[NSString stringWithFormat:@"order_memo=%@", 
						[Temp.OrderMemo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
	
	[Body	 addObject:@"order_flag=3"];	//아이폰은  3번  
	
	[Body	 addObject:[NSString stringWithFormat:@"reser_flag=%@", Temp.OrderType ? @"Y" : @"N"  ]]; //예약 플래그
	
	[Body	 addObject:[NSString stringWithFormat:@"reser_time=%@", 
						Temp.OrderType ?	[Temp.OrderTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  : @"" ]];	// 6자리 시간
	
	[Body	 addObject:[NSString stringWithFormat:@"pay_money=%d", Temp.OrderMoney ]];
	[Body	 addObject:[NSString stringWithFormat:@"disc_money=%d", Temp.OrderSaleMoney ]];
	
	CartItem *objectInstance;
	NSMutableArray	*MenuID = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Dis_menu = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*GroupID = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Dis_flag = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Dis_code = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Count = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Pay_money = [[NSMutableArray alloc] initWithCapacity:0];
	NSMutableArray	*Dis_money = [[NSMutableArray alloc] initWithCapacity:0];	
	
	
	NSMutableArray *ShopItemArr = [[DataManager getInstance] getShopCart];
	
	for (objectInstance in ShopItemArr) {
		
		if (![objectInstance.menuId compare:@""] )
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"item_menu_id=%@", 
								[ objectInstance.menuId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]]; // 메뉴ID
			
			[Dis_menu addObject:[NSString stringWithFormat:@"item_menu_dis=%@", 
								[[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
			[GroupID addObject:[NSString stringWithFormat:@"item_group_id=%d", GroupIDIndex]];	// GroupID 는 하나의 세트 내용을 모두
			[Dis_flag addObject:[NSString stringWithFormat:@"item_disc_flag=''"]];	// 할인 플레그 
			[Dis_code addObject:[NSString stringWithFormat:@"item_disc_cd=''"]];	// 할인 코드 
			[Count addObject:[NSString stringWithFormat:@"item_qty=%d", objectInstance.count ]];	// 주문 개수 
			[Pay_money addObject:[NSString stringWithFormat:@"item_pay_money=%d", 
								  [[DataManager getInstance] getProduct:objectInstance.menuId].price ]]; // 매뉴 가격
			[Dis_money addObject:[NSString stringWithFormat:@"item_disc_money=''"]];	// 할인 가격
		}
		
		
		if (![objectInstance.dessertId compare:@""])
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"item_menu_id=%@", 
								[ objectInstance.dessertId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
			
			[Dis_menu addObject:[NSString stringWithFormat:@"item_menu_dis=%@", 
								 [[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
			[GroupID addObject:[NSString stringWithFormat:@"item_group_id=%d", GroupIDIndex]];	// GroupID 는 하나의 세트 내용을 모두
			[Dis_flag addObject:[NSString stringWithFormat:@"item_disc_flag=''"]];	// 할인 플레그 
			[Dis_code addObject:[NSString stringWithFormat:@"item_disc_cd=''"]];	// 할인 코드 
			[Count addObject:[NSString stringWithFormat:@"item_qty=%d", objectInstance.count ]];	// 주문 개수 
			[Pay_money addObject:[NSString stringWithFormat:@"item_pay_money=%d", 
								  [[DataManager getInstance] getProduct:objectInstance.menuId].price ]]; // 매뉴 가격
			[Dis_money addObject:[NSString stringWithFormat:@"item_disc_money=''"]];	// 할인 가격
		}
		if (![objectInstance.drinkId compare:@""])
		{
			[MenuID	 addObject:[NSString stringWithFormat:@"item_menu_id=%@", 
								[ objectInstance.drinkId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];
			
			[Dis_menu addObject:[NSString stringWithFormat:@"item_menu_dis=%@", 
								 [[[DataManager getInstance] getProduct:objectInstance.menuId].menuDIS stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]  ]]; // 할인코드		
			[GroupID addObject:[NSString stringWithFormat:@"item_group_id=%d", GroupIDIndex]];	// GroupID 는 하나의 세트 내용을 모두
			[Dis_flag addObject:[NSString stringWithFormat:@"item_disc_flag=''"]];	// 할인 플레그 
			[Dis_code addObject:[NSString stringWithFormat:@"item_disc_cd=''"]];	// 할인 코드 
			[Count addObject:[NSString stringWithFormat:@"item_qty=%d", objectInstance.count ]];	// 주문 개수 
			[Pay_money addObject:[NSString stringWithFormat:@"item_pay_money=%d", 
								  [[DataManager getInstance] getProduct:objectInstance.menuId].price ]]; // 매뉴 가격
			[Dis_money addObject:[NSString stringWithFormat:@"item_disc_money=''"]];	// 할인 가격
		}
		GroupIDIndex++;
	}
	[Body addObjectsFromArray:MenuID];		[MenuID release];
	[Body addObjectsFromArray:Dis_menu];	[Dis_menu release];
	[Body addObjectsFromArray:GroupID];		[GroupID release];
	[Body addObjectsFromArray:Dis_flag];	[Dis_flag	release];
	[Body addObjectsFromArray:Dis_code];	[Dis_code release];
	[Body addObjectsFromArray:Count];		[Count release];
	[Body addObjectsFromArray:Pay_money];	[Pay_money release];
	[Body addObjectsFromArray:Dis_money];	[Dis_money release];
	
	[Body addObject:[NSString stringWithFormat:@"pay_master_pay_money=%d",
					  [[DataManager getInstance] getProduct:objectInstance.menuId].price ]];  // 결제금액    
	[Body addObject:[NSString stringWithFormat:@"pay_master_disc_money=%d", 0 ]];  // 할인금액
	[Body addObject:[NSString stringWithFormat:@"pay_master_save_money=%d", 0 ]];  // 적립금액
	
	[Body addObject:[NSString stringWithFormat:@"pay_master_receipt_flag=%@", (OrderType == MONEY ? @"Y" : @"") ]];  // 영수증사용여부
	[Body addObject:[NSString stringWithFormat:@"pay_detail_pay_cd=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 결제종류
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 카드번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_ex=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 유효기간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_acc=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 할부
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_control_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인넘버
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_money=%d", 
					  [[DataManager getInstance] getProduct:objectInstance.menuId].price]];  // 승인금액 ( 추후에 변경되면 바꾸자 )
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_no=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인번호
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_date=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인일자
	[Body addObject:[NSString stringWithFormat:@"pay_detail_arv_time=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인시간
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_cd=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사코드
	[Body addObject:[NSString stringWithFormat:@"pay_detail_card_nm=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 발급사명
	[Body addObject:[NSString stringWithFormat:@"pay_detail_terminal_id=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 터미널 ID 
	[Body addObject:[NSString stringWithFormat:@"pay_detail_msg=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 승인메시지
	[Body addObject:[NSString stringWithFormat:@"pay_detail_point_able=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 잔여포인트
	[Body addObject:[NSString stringWithFormat:@"pay_detail_point_use=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 사용포인트
	[Body addObject:[NSString stringWithFormat:@"pay_detail_point_add=%@", (OrderType == ONLINE ? @"" : @"") ]];  // 적립포인트
	
	
	
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
		[self ShowOKAlert:@"Login Error" msg:@"로그인에 실패 했습니다."];	
	}
	else 
	{
	}
}

@end
