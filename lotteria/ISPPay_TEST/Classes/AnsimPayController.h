//
//  AnsimPayController.h
//  ISPPay
//
//  Created by embmaster on 11. 2. 19..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnsimPayDelegate;


@interface AnsimPayController : UIViewController {
	
	UIWebView *PayView;
	
	NSString *s_mname;			// 상품명
	NSString *s_amount;			// 상품 값
	NSString *s_cardtype;		// 카드사   ( 91:NH , 51:삼성 ,   61:현대 ,   71:롯데,    41:신한 )

	
	NSString *s_businessnum;	// 사업자 번호 
	NSString *s_currency;		// 원화  "410" 	
	
	//호스팅 url은 PG사에 문의하시거나 데이콤을 이용하세요.
	//호스팅 응답받을 url  "https://mpi.dacom.net/XMPI/m_hostAgent12.jsp"
	NSString *s_receiveurl;
	
	//호스팅 시작url;
	//호스트 url "https://mpi.dacom.net/XMPI/m_hostAgent01.jsp"
	NSString *s_hosturl;		
		
	id<AnsimPayDelegate> delegate;

}

@property (nonatomic,retain)IBOutlet UIWebView *PayView;
@property (nonatomic,retain)IBOutlet NSString *s_mname;
@property (nonatomic,retain)IBOutlet NSString *s_businessnum;
@property (nonatomic,retain)IBOutlet NSString *s_cardtype;
@property (nonatomic,retain)IBOutlet NSString *s_currency;
@property (nonatomic,retain)IBOutlet NSString *s_amount;
@property (nonatomic,retain)IBOutlet NSString *s_receiveurl;
@property (nonatomic,retain)IBOutlet NSString *s_hosturl;
@property (nonatomic,assign) id<AnsimPayDelegate> delegate;

- (NSString *)base64Decode_UTF8:(NSString *)string ;
-(void)setAnsimValue:(NSString *) x_mname 
			  amount:(NSString *) x_amount
			cardtype:(NSString *) x_cardtype ;

-(IBAction) closeButton;
@end


@protocol AnsimPayDelegate <NSObject>;
@required 
-(void)returnAnsimValue:(NSString *)r_code
					msg:(NSString *)r_msg
					xid:(NSString *)r_xid
					eci:(NSString *)r_eci
				   cavv:(NSString *)r_cavv
				 cardno:(NSString *)r_cardno
			   joincode:(NSString *)r_joincode;
@end


