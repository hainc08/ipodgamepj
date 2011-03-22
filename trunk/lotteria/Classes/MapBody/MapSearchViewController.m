//
//  MapSearchViewController.m
//  lotteria
//
//  Created by embmaster on 11. 3. 2..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapSearchViewController.h"
#import "UITableViewCellTemplate.h"
#import "MapSearchDetailViewController.h"
#import "HttpRequest.h"
#import "XmlParser.h"

@implementation MapSearchViewController

@synthesize Dong;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	AddressArr = [[NSMutableArray alloc] initWithCapacity:0];

	self.navigationItem.title = @"매장찾기";
	
	
	if( [Dong	compare:@""] == NSOrderedSame )
	{
		// 전체 매장 찾기 
		[SearchLabel setText:@"전국매장"];
	}
	else {
		// 동 매장 찾기 
		[SearchLabel setText:Dong];
	}

	[self GetStoreInfo];
	[SearchTable reloadData];
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
	if(httpRequest)
		[httpRequest release];
	
	[AddressArr release];
    [super dealloc];
}

- (IBAction)MapButton
{
	[self back];
}

#pragma mark -
#pragma mark HttpRequestDelegate

- (void)GetStoreInfo
{	
	httpRequest = [[HTTPRequest alloc] init];
	// POST로 전송할 데이터 설정
	NSDictionary *bodyObject = [NSDictionary dictionaryWithObjectsAndKeys:
								(Dong ? Dong : @""),@"dong",
								nil];
	
	// 통신 완료 후 호출할 델리게이트 셀렉터 설정
	[httpRequest setDelegate:self selector:@selector(didReceiveFinished:)];
	
	// 페이지 호출
	[httpRequest requestUrl:@"/MbBranch.asmx/ws_getBranchDongXml" bodyObject:bodyObject bodyArray:nil];
	[[ViewManager getInstance] waitview:self.view isBlock:YES];
}

- (void)didReceiveFinished:(NSString *)result
{
	[[ViewManager getInstance] waitview:self.view isBlock:NO];	
	if(![result compare:@"error"])
	{
		[self ShowOKAlert:@"Data Fail" msg:@"서버에서 데이터 불러오는데 실패하였습니다."];	
	}
	else {
		XmlParser* xmlParser = [XmlParser alloc];
		[xmlParser parserString:result];
		Element* root = [xmlParser getRoot:@"NewDataSet"];
		
		for(Element* t_item = [root getFirstChild] ; nil != t_item   ; t_item = [root getNextChild] )
		{
			
			StoreInfo *storeaddr  = [[[StoreInfo alloc] init] retain];
			[storeaddr setStoreid:[[t_item getChild:@"BRANCH_ID"] getValue]];
			[storeaddr setStorename:[[t_item getChild:@"BRANCH_NM"] getValue]];
			[storeaddr setStorephone:[[t_item getChild:@"BRANCH_TEL1"] getValue]];
			
			[storeaddr setSi:[[t_item getChild:@"SI"] getValue]];
			[storeaddr setGu:[[t_item getChild:@"GU"] getValue]];
			[storeaddr setDong:[[t_item getChild:@"DONG"] getValue]];
			[storeaddr setBunji:[[t_item getChild:@"BUNJI"] getValue]];
			[storeaddr setBuilding:[[t_item getChild:@"BUILDING"] getValue]];
			[storeaddr setAddrdesc:[[t_item getChild:@"ADDR_DESC"] getValue]];
			
			NSString *xvalue = [[t_item getChild:@"GIS_X"] getValue];
			NSString *yvalue = [[t_item getChild:@"GIS_Y"] getValue];
			
			CLLocationCoordinate2D temp;
			temp.latitude	= [xvalue integerValue];
			temp.longitude	= [yvalue integerValue];
			[storeaddr setCoordinate:temp];
			
			NSString *delivery = [[t_item getChild:@"DELIVERY_FLAG"] getValue];
			NSString *open = [[t_item getChild:@"OPEN_FLAG"] getValue];
			
			if ( [delivery compare:@"Y"] == NSOrderedSame ) [storeaddr setStore_flag:DELIVERYSTORE];
			else if ( [open compare:@"Y"] == NSOrderedSame ) [storeaddr setStore_flag:TIMESTORE];
			else [storeaddr setStore_flag:NORMALSTORE];
			
			[AddressArr  addObject:storeaddr];
		}	
		[xmlParser release];

		[SearchTable reloadData];	
	}
	[httpRequest release];
	httpRequest = nil;
}


#pragma mark -
#pragma mark TableView


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"StoreAddressCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier 
													 owner:self options:nil];
		for (id oneObject in nib)
		{
			if ([oneObject isKindOfClass:[StoreAddressCell class]])
			{
				cell = oneObject;
				break;
			}
		}
		cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
		((UIImageView *)cell.selectedBackgroundView).image = [UIImage imageNamed:@"bg_select_bar.png"] ;
		
	}
	
	StoreAddressCell *tmp_cell = (StoreAddressCell *)cell;
	
	StoreInfo *Info = [AddressArr objectAtIndex:indexPath.row];
	
	[tmp_cell setInfo:[Info storename] :[Info getAddressStr]];
	
	return cell;
}


////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	 MapSearchDetailViewController *SearchControl = [[MapSearchDetailViewController alloc] initWithNibName:@"MapSearchDetailView" bundle:nil];
	SearchControl.Info = [AddressArr objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:SearchControl animated:YES];
	[SearchControl release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 53;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  [AddressArr count];
}

@end
