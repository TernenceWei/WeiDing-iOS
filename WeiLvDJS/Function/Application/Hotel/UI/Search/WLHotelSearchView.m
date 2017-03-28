//
//  WLHotelSearchView.m
//  WeiLvDJS
//
//  Created by ternence on 16/11/14.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLHotelSearchView.h"
#import "WLDataManager.h"
#import "WLNetworkManager.h"
#import "WLWaitingListCell.h"
#import "WLBiddingListCell.h"

@interface WLHotelSearchView ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *searchHistoryView;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) NSArray *historyArray;
@property (nonatomic, copy) void(^onSearchBlock)();
@property (nonatomic, copy) void(^onItemClickBlock)();
@property (nonatomic, copy) void(^onCancelBlock)();
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *searchText;
//@property (nonatomic, assign) HotelListStatus nowStatus;

@end

@implementation WLHotelSearchView
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
                  searchBlock:(void (^)())searchBlock
               itemClickBlock:(void (^)())itemClickBlock
                  cancelBlock:(void (^)())cancelBlock
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
        self.onSearchBlock = searchBlock;
        self.onItemClickBlock = itemClickBlock;
        self.onCancelBlock = cancelBlock;
        self.historyArray = [WLDataManager getHotelSearchHistory];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self setupToolBar];
    
    if (self.historyArray.count) {
        [self setupSearchHistoryView];
    }else{
        [self setupEmptyViewWithNoHistory:YES];
    }
}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)setupToolBar
{
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    toolBar.backgroundColor = [WLTools stringToColor:@"#4877e7"];
    [self addSubview:toolBar];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(ScaleW(15), 22, ScreenWidth - ScaleW(75), 35)];
    self.searchBar.placeholder = @"搜索团号或订单号";
    self.searchBar.tintColor = [WLTools stringToColor:@"#ffffff"];
    self.searchBar.returnKeyType = UIReturnKeySearch;
    self.searchBar.delegate = self;
    [toolBar addSubview:self.searchBar];
    self.searchBar.layer.cornerRadius = 5;
    self.searchBar.layer.masksToBounds = YES;
    UIImage* searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:44.0f];
    [_searchBar setBackgroundImage:searchBarBg];
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(60), 22, ScaleW(45), 35)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = WLFontSize(16);
    [cancelBtn addTarget:self action:@selector(onClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [toolBar addSubview:cancelBtn];
    
    [self.searchBar becomeFirstResponder];
}

- (void)setupEmptyViewWithNoHistory:(BOOL)noHistory
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [WLTools stringToColor:@"#b5b5b5"];
    label.font = [UIFont WLFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, ScaleH(200), ScreenWidth, ScaleH(45));
    if (noHistory) {
        label.text = @"——  无搜索历史  ——";
    }else{
        label.text = @"——  无相关订单  ——";
    }
    
    [self addSubview:label];
    self.emptyView = label;
}

- (void)removeEmptyView
{
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
}
- (void)removeHistoryView
{
    [self.searchHistoryView removeFromSuperview];
    self.searchHistoryView = nil;
}

- (void)setupSearchHistoryView
{
    CGFloat itemHeight = ScaleH(50);
    CGFloat height = ScaleH(44) + itemHeight * ((self.historyArray.count + 1) / 2);
    
    UIView *searchHistoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, height)];
    searchHistoryView.backgroundColor = [UIColor whiteColor];
    [self addSubview:searchHistoryView];
    self.searchHistoryView = searchHistoryView;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(44))];
    topView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [searchHistoryView addSubview:topView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(43), ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [topView addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [WLTools stringToColor:@"#b5b5b5"];
    label.font = [UIFont WLFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.frame = CGRectMake(ScaleW(15), 0, ScreenWidth, ScaleH(44));
    label.text = @"最近搜索";
    [topView addSubview:label];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(40), 0, ScaleW(40), ScaleH(44))];
    [clearButton setImage:[UIImage imageNamed:@"hotel_search_clear"] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(onClickClearBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:clearButton];
    
    for (int i = 0; i < self.historyArray.count; i++) {
        CGFloat width = ScreenWidth / 2;
        CGFloat height = ScaleH(35);
        CGFloat realWidth = [WLUITool sizeWithString:self.historyArray[i] font:WLFontSize(16)].width + 10;
        if (realWidth < ScreenWidth / 4) {
            realWidth = ScreenWidth / 4;
        }
        CGFloat bgX = (width - realWidth) / 2 + (i % 2) * width;
        CGFloat bgY = (i / 2) * itemHeight + ScaleH(52);
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(bgX, bgY , realWidth, height)];
//        lineImage.image = [self drawLineByImageView:lineImage];
        lineImage.userInteractionEnabled = YES;
        [searchHistoryView addSubview:lineImage];
        
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:self.historyArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[WLTools stringToColor:@"#879efa"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"hotel_searchHistory_item_bg"] forState:UIControlStateNormal];
        button.titleLabel.font = WLFontSize(16);
        [button addTarget:self action:@selector(onClickHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.frame = CGRectMake(0, 0, realWidth, height);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [lineImage addSubview:button];
    }
}

- (void)onClickHistoryBtn:(UIButton *)button
{
    NSString *text = [button titleForState:UIControlStateNormal];
    [self beginToSearchWithTextString:text];
    
}

- (void)beginToSearchWithTextString:(NSString *)textString
{
    [self.searchBar resignFirstResponder];
    if ([textString isEqualToString:@""] || textString == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"请先输入内容，再搜索"];
        return;
    }
    self.searchText = textString;
    [WLDataManager addNewHotelSearchItem:textString];
    [WLNetworkManager searchHotelListWithID:textString result:^(BOOL success, NSArray *listArray) {
        if (success) {
            [self removeEmptyView];
            [self removeHistoryView];
            if (listArray.count) {
                
                self.dataArray = [listArray mutableCopy];
                if (self.myTableView == nil) {
                    [self setupTableView];
                }
                
                [self.myTableView reloadData];
            }else{
                
                [self setupEmptyViewWithNoHistory:NO];
            }
            
        }
        
    }];

}

- (void)onClickClearBtn
{
    [WLDataManager clearHotelSearchHistory];
    [self.searchHistoryView removeFromSuperview];
    self.searchHistoryView = nil;
    [[WL_TipAlert_View sharedAlert] createTip:@"清除成功"];
}

- (void)setupTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor = HEXCOLOR(0xf7f7f8);
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"haha"];
    [self addSubview:self.myTableView];
}

- (void)onClickCancelBtn
{
    self.onCancelBlock();
    
}

#pragma mark tableView dataSource
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self beginToSearchWithTextString:searchBar.text];
    
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLHotelOrderInfo  * modell = self.dataArray[indexPath.row];
    
    if (modell.status == HotelListStatusWaitReceive) {
        
        WLWaitingListCell *cell = [WLWaitingListCell cellCreateTableView:tableView];
        //[cell setCellModel:modell];
        cell.modelInfo = modell;
        
        [cell wCClickAction:^(NSInteger wCNO) {
            NSLog(@"微信号==%ld",(long)wCNO);
        }];
        
        [cell iPhoneAction:^(NSInteger iPhoneNO) {
            NSLog(@"手机号==%ld",(long)iPhoneNO);
        }];
        
        [cell sureBtnClickAction:^(WLHotelOrderInfo *StrrCIDM) {
            NSLog(@"确认==");
            
            if (modell.isBidding) {
                //发报价
                [self quoteTheOrderWithChecklistID:StrrCIDM status:modell.status];
            }
            else
            {
                //确认订单
                [self modifyOrderStatusWithChecklistID:StrrCIDM.checkListID type:HotelActionTypeReceiveOrder status:modell.status];
            }
        }];
        
        [cell RefusedBtnClickAction:^(NSString *Strr) {
            NSLog(@"0不接单0==%@",Strr);
            //不接单
            [self modifyOrderStatusWithChecklistID:Strr type:HotelActionTypeRejectOrder status:modell.status];
        }];
        
        return cell;

        
    }else{
        WLBiddingListCell *cell = [WLBiddingListCell cellCreateTableView:tableView];
        
        
        [cell setCellModel:modell Nstatus:modell.status];
        
        [cell wCClickAction:^(NSInteger wCNO) {
            NSLog(@"微信号==%ld",(long)wCNO);
        }];
        
        [cell iPhoneAction:^(NSInteger iPhoneNO) {
            NSLog(@"手机号==%ld",(long)iPhoneNO);
        }];
        
        [cell qXBtnClickAction:^(NSString *xQID) {
            
            if (modell.status == HotelListStatusOutOfDate) {
                // 删除订单
                [self deleteAOrderWithChecklistID:xQID status:modell.status];
            }
            else if (modell.status == HotelListStatusBidding)
            {
                [self modifyOrderStatusWithChecklistID:xQID type:HotelActionTypeCancelQuote status:modell.status];
            }
            
        }];
        
        [cell closeVSopenClickAction:^(NSString *isopen) {
            
            modell.isOpen = isopen;
            [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLHotelOrderInfo  * model = self.dataArray[indexPath.row];
    if (model.status == HotelListStatusWaitReceive) {
        
        if (model.isBidding) {
            return ScaleH(580);
        }else
        {
            return ScaleH(380);
        }
    }else{
        
        if ([model.isOpen isEqualToString:@"1"]) {
            return ScaleH(230);
        }else if ([model.isOpen isEqualToString:@"0"])
        {
            return ScaleH(480);
        }
    }
    return 100;
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [WLTools stringToColor:@"#f7f7f8"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(12), 0, ScreenWidth, ScaleH(45))];
    label.textColor = [WLTools stringToColor:@"#b5b5b5"];
    label.font = [UIFont WLFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = [NSString stringWithFormat:@"%ld条 相关记录",self.dataArray.count];
    [header addSubview:label];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleH(44), ScreenWidth, 1)];
    lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [header addSubview:lineView];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(45);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [WLTools stringToColor:@"#d8d9dd"].CGColor);
    CGContextAddRect(line, CGRectMake(0, 0, imageView.size.width, imageView.size.height));
    CGContextStrokePath(line);
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)GetNetData:(HotelListStatus)nowStatus
{
    [WLNetworkManager searchHotelListWithID:self.searchText result:^(BOOL success, NSArray *listArray) {
        if (success) {
            self.dataArray = [listArray mutableCopy];
            [self.myTableView reloadData];
        }

    }];

}

// 删除订单（已失效）
- (void)deleteAOrderWithChecklistID:(NSString *)CheckID status:(HotelListStatus)status
{
    [WLNetworkManager deleteAOrderWithChecklistID:CheckID result:^(BOOL success, BOOL result) {
        NSLog(@"==");
        if (success && result) {
            [self GetNetData:status];
        }
    }];
}

//修改状态
- (void)modifyOrderStatusWithChecklistID:(NSString *)CheckID type:(HotelActionType)type status:(HotelListStatus)status
{
    [WLNetworkManager modifyOrderStatusWithChecklistID:CheckID actionType:type remark:@"123" result:^(BOOL success, BOOL result , NSString *message) {
        if (success && result) {
            [self GetNetData:status];
        }
    }];
}

//发报价
- (void)quoteTheOrderWithChecklistID:(WLHotelOrderInfo *)senderModel status:(HotelListStatus)status
{
    NSLog(@"==%@",senderModel);
    [WLNetworkManager quoteTheOrderWithChecklistID:senderModel.checkListID acceptSplit:senderModel.isSplitAccept price:senderModel.forcastPrice count:senderModel.forcastCount expiryDate:senderModel.expiryDate result:^(BOOL success, BOOL result, NSString *message) {
        NSLog(@"message==%@",message);
        if (success && result) {
            [self GetNetData:status];
        }
    }];
}
@end
