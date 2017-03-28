//
//  WLChargeUpController.m
//  WeiLvDJS
//
//  Created by ternence on 16/9/30.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpController.h"
#import "WLRemarkCell.h"
#import "WLAttachmentCell.h"
#import "WLChargeUpHeader.h"
#import "WLChargeUpSectionHeader.h"
#import "WLChargeUpFooter.h"
#import "WLNetworkManager.h"
#import "WLConsumeCell.h"
#import "WLPaymentCell.h"
#import "WLRebateCell.h"
#import "WLChargeUpHotelObject.h"
#import "WLChargeUpShopObject.h"
#import "WLChargeUpCarObject.h"
#import "WLChargeUpMiddleObject.h"
#import "WLPhotoCheckView.h"

@interface WLChargeUpController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WLChargeUpHeader *header;
@property (nonatomic, strong) WLChargeUpFooter *footer;
@property (nonatomic, strong) WLChargeUpCarObject *carObject;
@property (nonatomic, strong) WLChargeUpHotelObject *hotelObject;
@property (nonatomic, strong) WLChargeUpShopObject *shopObject;
@property (nonatomic, strong) WLChargeUpRoleObject *selectRoleObject;
@property (nonatomic, assign) BOOL showItemList;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, assign) TouristItemType itemType;
@property (nonatomic, assign) TouristRoleType roleType;
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *resourceID;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) WLChargeUpMiddleObject *middleObjct;
@property (nonatomic, strong) WLPhotoCheckView *checkView ;
@property (nonatomic, strong) NSString *middleRemark;
@property (nonatomic, strong) WLAttachmentCell *cell;
@property (nonatomic, strong) NSString *additionalPrice;
@end

@implementation WLChargeUpController

- (NSMutableArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
}

- (void)setItemType:(TouristItemType)itemType roleType:(TouristRoleType)roleType resourceID:(NSString *)resourceID groupID:(NSString *)groupID date:(NSString *)date canEdit:(BOOL)canEdit
{
    self.itemType = itemType;
    self.roleType = roleType;
    self.groupID = groupID;
    self.resourceID = resourceID;
    self.date = date;
    self.canEdit = canEdit;
    [self setupUI];
    [self loadData];
    
}


-(void)setUpNavigationBar
{
    self.view.backgroundColor = HEXCOLOR(0xeff1fe);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont WLFontOfSize:15];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];

    NSString *titleText = @"保存";
    if (!self.canEdit) {
        titleText = @"";
    }
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:titleText style:UIBarButtonItemStyleDone target:self action:@selector(saveChargeUp)];
    self.navigationItem.rightBarButtonItem=item;
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HEXCOLOR(0xeff1fe);
    [self.view addSubview:self.tableView];
    
    if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional) {
        WLChargeUpHeader *header = [[WLChargeUpHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(130)) selectAction:^(WLChargeUpRoleObject *guideInfo) {
            
            self.selectRoleObject = guideInfo;
            NSString *userID = [WLUserTools getUserId];////[DEFAULTS objectForKey:@"user_id"];
            if ([guideInfo.userID isEqualToString:userID]) {
                self.canEdit = YES;
                self.roleType = TouristRoleTypeMine;
                
            }else{
                self.canEdit = NO;
                self.roleType = TouristRoleTypeOther;
            }
            self.showItemList = NO;
            [self.itemArray removeAllObjects];
            self.middleObjct = nil;
            self.additionalPrice = nil;
            [self.tableView reloadData];
            
        }];
        self.tableView.tableHeaderView = header;
        self.header = header;
    }
    CGFloat footerHeight = ScaleH(60);
    if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional) {
        footerHeight = ScaleH(110);
    }
    WLChargeUpFooter *footer = [[WLChargeUpFooter alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, footerHeight) itemType:self.itemType];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
    
    self.showItemList = NO;
 
}

- (void)loadData
{
    [WLNetworkManager requestChargeUpInfoWithType:self.itemType resourceID:self.resourceID groupID:self.groupID date:self.date result:^(BOOL success, id responseObject) {
        
        if (self.itemType == TouristItemTypeCar) {
            
            self.carObject = (WLChargeUpCarObject *)responseObject;
            self.title = @"记账--用车";
            [self.footer setName:self.carObject.registerName time:self.carObject.registerTime];
            
        }else if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional){
            
            self.shopObject = (WLChargeUpShopObject *)responseObject;
            if (self.shopObject.roleArray.count) {
                self.header.roleArray = self.shopObject.roleArray;
                self.selectRoleObject = self.shopObject.roleArray[0];
                self.title = self.selectRoleObject.companyName;
                [self.footer setName:nil time:self.selectRoleObject.whichDate];
                self.roleType = TouristRoleTypeMine;
            }
            
            
        }else{
            
            self.hotelObject = (WLChargeUpHotelObject *)responseObject;
            self.title = self.hotelObject.companyName;
            [self.footer setName:self.hotelObject.registerName time:self.hotelObject.registerTime];
        }
        
        [self.tableView reloadData];
    }];

}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 4;
    switch (self.itemType) {
        case TouristItemTypeCar:
        case TouristItemTypeHotel:
        case TouristItemTypeMeal:
        case TouristItemTypeTicket:
            break;
        case TouristItemTypeShopping:
        case TouristItemTypeAdditional:
            if (self.roleType == TouristRoleTypeOther) {
                sections = 3;
            }
            break;
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = self.hotelObject;
    NSArray *paymentArray;
    NSArray *attachmentArray;
    NSString *remark = nil;
    if (self.itemType == TouristItemTypeCar) {
        object = self.carObject;
        paymentArray = @[CHECKNIL(self.carObject.payDate),CHECKNIL(self.carObject.price)];
        attachmentArray = self.carObject.picList;
        remark = self.carObject.remark;
    }else if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket){
        NSString *payment = @"挂账";
        if (self.hotelObject.settlementMode == PaymentModeCash) {
            payment = @"现金";
        }
        paymentArray = @[payment,CHECKNIL(self.hotelObject.price)];
        attachmentArray = self.hotelObject.picList;
        remark = self.hotelObject.remark;
    }else{
        object = self.selectRoleObject;
        remark = self.selectRoleObject.remark;
    }
    
    __weak __typeof(self)weakSelf = self;
    if (self.itemType == TouristItemTypeCar || self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
        if (indexPath.section == 0) {
            
            WLConsumeCell *cell = [WLConsumeCell cellWithTableView:tableView
                                                          ItemType:self.itemType
                                                            object:object
                                                          showList:self.showItemList
                                                           canEdit:self.canEdit
                                                      newItemArray:[self.itemArray copy]
                                                      middleObject:self.middleObjct
                                                   additionalPrice:nil];
            __weak WLConsumeCell *weakCell = cell;
            [cell setAddNewItemClickBlock:^(BOOL showList) {
                
                weakSelf.middleObjct = [weakCell getMiddleObject];
                weakSelf.showItemList = showList;
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                
            } chooseAItemBlock:^(WLChargeUpScheduleObject *object) {
                
                weakSelf.showItemList = NO;
                [weakSelf.itemArray addObject:object];
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            } endEditingBlock:^{
                
                weakSelf.middleObjct = [weakCell getMiddleObject];
                int count = 0;
                for (WLChargeUpScheduleObject *object in weakSelf.middleObjct.middleArray) {
                    count += (object.actualPrice.intValue * object.actualCount.intValue);
                }
                WLPaymentCell *paymentCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                [paymentCell setTotalPrice:[NSString stringWithFormat:@"%d",count]];
                
            } deleteScheduleBlock:^(NSUInteger index) {
                
                [weakSelf deleteSchedulelistWithIndex:index];
                
            }];
            return cell;
            
        }else if (indexPath.section == 1){
            
            int count = 0;
            for (WLChargeUpScheduleObject *object in weakSelf.hotelObject.scheduleList) {
                count += (object.actualPrice.intValue * object.actualCount.intValue);
            }
            WLPaymentCell *cell = [WLPaymentCell cellWithTableView:tableView itemType:self.itemType textArray:paymentArray];
            [cell setTotalPrice:[NSString stringWithFormat:@"%d",count]];
            return cell;
            
        }else if (indexPath.section == 2){
            
            WLAttachmentCell *cell = [WLAttachmentCell cellWithTableView:tableView openAlbumAction:^(UIImagePickerController *pickerVC) {
                if (pickerVC) {
                    [weakSelf presentViewController:pickerVC animated:YES completion:nil];
                }else{
                    [self.view endEditing:YES];
                }
                
            } photoCheckAction:^(UIImage *image, NSURL *imageUrl) {
  
                
                [weakSelf setupPhotoCheckViewWithImage:image url:imageUrl cell:cell];
                
            } canEdit:self.canEdit];
            cell.imgArray = [attachmentArray mutableCopy];
            self.cell = cell;
            return cell;
            
        }else if (indexPath.section == 3){
            
            WLRemarkCell *cell = [WLRemarkCell cellWithTableView:tableView
                                                          remark:remark
                                                             tag:indexPath.section
                                                         canEdit:self.canEdit
                                                   keyboardBlock:^(BOOL keyboardShow, CGFloat height, NSUInteger section) {
                if (keyboardShow) {
                    [weakSelf customerKeyboardWillShowWithSection:section height:height];
                }else{
                    if (height == 0) {
                        [weakSelf customerKeyboardWillHide];
                    }
                    for (UITableViewCell *cell in weakSelf.tableView.visibleCells) {
                        if ([cell isKindOfClass:[WLRemarkCell class]]) {
                            weakSelf.middleRemark = [(WLRemarkCell *)cell getUploadeRemark];
                        }
                    }
                    
                }
            } middleRemark:self.middleRemark];
            return cell;
            
        }
    }else if (self.itemType == TouristItemTypeShopping || self.itemType == TouristItemTypeAdditional){
        
        if (self.roleType == TouristRoleTypeMine) {
            if (indexPath.section == 0) {
                
                WLConsumeCell *cell = [WLConsumeCell cellWithTableView:tableView
                                                              ItemType:self.itemType
                                                                object:object
                                                              showList:self.showItemList
                                                               canEdit:self.canEdit
                                                          newItemArray:[self.itemArray copy]
                                                          middleObject:self.middleObjct
                                                       additionalPrice:self.additionalPrice];
                __weak WLConsumeCell *weakCell = cell;
                [cell setAddNewItemClickBlock:^(BOOL showList) {
                    
                    weakSelf.middleObjct = [weakCell getMiddleObject];
                    weakSelf.showItemList = showList;
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    
                    
                } chooseAItemBlock:^(WLChargeUpScheduleObject *object) {
                    
                    weakSelf.showItemList = NO;
                    [weakSelf.itemArray addObject:object];
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    
                    
                } endEditingBlock:^{
                    
                    NSString *totalPrice = @"0";
                    weakSelf.middleObjct = [weakCell getMiddleObject];
                    if (weakSelf.itemType == TouristItemTypeAdditional) {
                        int count = 0;
                        for (WLChargeUpScheduleObject *object in weakSelf.middleObjct.middleArray) {
                            count += (object.actualDanJia.intValue - object.actualPrice.intValue) * object.actualCount.intValue;
                        }
                        if (count < 0) {
                            count = 0;
                        }
                        totalPrice = [NSString stringWithFormat:@"%d", count];
                        weakSelf.additionalPrice = totalPrice;
                    }else{
                        totalPrice = [weakCell getTopViewTextArray][1];
                    }
                    
                    WLRebateCell *rebateCell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                    [rebateCell setTotalReturnPrice:totalPrice];
                    
                } deleteScheduleBlock:^(NSUInteger index) {
                    
                    [weakSelf deleteSchedulelistWithIndex:index];
                }];
                return cell;
                
            }else if (indexPath.section == 1){
                
                WLRebateCell *cell = [WLRebateCell cellWithTableView:tableView roleObject:self.selectRoleObject];
                if (self.itemType == TouristItemTypeAdditional) {
                    int count = 0;
                    for (WLChargeUpScheduleObject *object in self.selectRoleObject.scheduleList) {
                        count += (object.actualDanJia.intValue - object.actualPrice.intValue) * object.actualCount.intValue;
                    }
                    if (count < 0) {
                        count = 0;
                    }
                    [cell setTotalReturnPrice:[NSString stringWithFormat:@"%d",count]];
                }else{
                   [cell setTotalReturnPrice:self.selectRoleObject.actualPrice];
                }
                
                return cell;
                
            }else if (indexPath.section == 2){
                
                WLAttachmentCell *cell = [WLAttachmentCell cellWithTableView:tableView openAlbumAction:^(UIImagePickerController *pickerVC) {
                    
                    if (pickerVC) {
                        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
                    }else{
                        [self.view endEditing:YES];
                    }
                    
                } photoCheckAction:^(UIImage *image, NSURL *imageUrl) {
                    
                    [weakSelf setupPhotoCheckViewWithImage:image url:imageUrl cell:cell];
                } canEdit:self.canEdit];
                [cell setImgArray:[self.selectRoleObject.picList mutableCopy]];
                self.cell = cell;
                return cell;
                
            }else if (indexPath.section == 3){
                
                WLRemarkCell *cell = [WLRemarkCell cellWithTableView:tableView
                                                              remark:remark
                                                                 tag:indexPath.section
                                                             canEdit:self.canEdit
                                                       keyboardBlock:^(BOOL keyboardShow, CGFloat height, NSUInteger section) {
                    if (keyboardShow) {
                        [weakSelf customerKeyboardWillShowWithSection:section height:height];
                    }else{
                        [weakSelf customerKeyboardWillHide];
                        weakSelf.middleRemark = [cell getUploadeRemark];
                    }
                } middleRemark:self.middleRemark];

                return cell;
                
            }

        }else{
            if (indexPath.section == 0) {
                
                WLConsumeCell *cell = [WLConsumeCell cellWithTableView:tableView
                                                              ItemType:self.itemType
                                                                object:object
                                                              showList:self.showItemList
                                                               canEdit:self.canEdit
                                                          newItemArray:[self.itemArray copy]
                                                          middleObject:self.middleObjct
                                                       additionalPrice:self.additionalPrice];
                __weak WLConsumeCell *weakCell = cell;
                [cell setAddNewItemClickBlock:^(BOOL showList) {
                    
                    weakSelf.middleObjct = [weakCell getMiddleObject];
                    weakSelf.showItemList = showList;
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    
                } chooseAItemBlock:^(WLChargeUpScheduleObject *object) {
                    
                    weakSelf.showItemList = NO;
                    [weakSelf.itemArray addObject:object];
                    [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    
                } endEditingBlock:^{
                    
                    NSString *totalPrice = @"0";
                    weakSelf.middleObjct = [weakCell getMiddleObject];
                    if (weakSelf.itemType == TouristItemTypeAdditional) {
                        int count = 0;
                        for (WLChargeUpScheduleObject *object in weakSelf.middleObjct.middleArray) {
                            count += (object.actualDanJia.intValue - object.actualPrice.intValue) * object.actualCount.intValue;
                        }
                        if (count < 0) {
                            count = 0;
                        }
                        totalPrice = [NSString stringWithFormat:@"%d", count];
                        weakSelf.additionalPrice = totalPrice;
                    }else{
                        totalPrice = [weakCell getTopViewTextArray][1];
                    }
                    
                } deleteScheduleBlock:^(NSUInteger index) {
                    
                    [weakSelf deleteSchedulelistWithIndex:index];
                    
                }];
                return cell;
                
            }else if (indexPath.section == 1){
                
                WLAttachmentCell *cell = [WLAttachmentCell cellWithTableView:tableView openAlbumAction:^(UIImagePickerController *pickerVC) {
                    
                    if (pickerVC) {
                        [weakSelf presentViewController:pickerVC animated:YES completion:nil];
                    }else{
                        [self.view endEditing:YES];
                    }
                    
                } photoCheckAction:^(UIImage *image, NSURL *imageUrl) {
                    
                    [weakSelf setupPhotoCheckViewWithImage:image url:imageUrl cell:cell];
                } canEdit:self.canEdit];
                [cell setImgArray:[self.selectRoleObject.picList mutableCopy]];
                self.cell = cell;
                return cell;
                
            }else if (indexPath.section == 2){
                
                WLRemarkCell *cell = [WLRemarkCell cellWithTableView:tableView
                                                              remark:remark
                                                                 tag:indexPath.section
                                                             canEdit:self.canEdit
                                                       keyboardBlock:^(BOOL keyboardShow, CGFloat height, NSUInteger section) {
                    if (keyboardShow) {
                        [weakSelf customerKeyboardWillShowWithSection:section height:height];
                    }else{
                        [weakSelf customerKeyboardWillHide];
                        weakSelf.middleRemark = [cell getUploadeRemark];
                    }
                } middleRemark:self.middleRemark];
                return cell;
                
            }
        }
    }
    return nil;
}

- (void)setupPhotoCheckViewWithImage:(UIImage *)image url:(NSURL *)url cell:(WLAttachmentCell *)cell
{
    __weak __typeof(self)weakSelf = self;
    WLPhotoCheckView *checkView = [[WLPhotoCheckView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) image:image imageUrl:url tapAction:^{
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
        
    } modifyAction:^(BOOL isDelete){
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
        [weakSelf.cell modifyPictureJustDelete:isDelete];
    }];
    [self.navigationController.view addSubview:checkView];
    self.checkView = checkView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.itemType == TouristItemTypeHotel || self.itemType == TouristItemTypeMeal || self.itemType == TouristItemTypeTicket) {
            CGFloat heigth = ScaleH(45) * 2 + ScaleH(10) + ScaleH(50) * (self.hotelObject.scheduleList.count + self.itemArray.count + 1);
            if (self.showItemList) {
                heigth += ScaleH(50);
            }
            if (self.hotelObject.priceList.count) {
                heigth += ScaleH(50);
            }
            return heigth;
            
        }else if (self.itemType == TouristItemTypeCar){
            
            return ScaleH(60) * 2 + ScaleH(45);
            
        }else if (self.itemType == TouristItemTypeShopping){
            
            return ScaleH(45) * 3;
            
        }else{
            
            CGFloat heigth = ScaleH(45) * 3 + ScaleH(10) + ScaleH(50) * (self.selectRoleObject.scheduleList.count + self.itemArray.count + 2);
            if (self.showItemList) {
                heigth += ScaleH(50);
            }
            if (self.selectRoleObject.pricelist.count) {
                heigth += ScaleH(50);
            }
            return heigth;
        }
    }else if (indexPath.section == 1){
        if (self.itemType == TouristItemTypeAdditional || self.itemType == TouristItemTypeShopping) {
            if (self.roleType == TouristRoleTypeOther) {
                return ScaleH(100);
            }
            return ScaleH(45);
        }
        return ScaleH(90);
    }else if (indexPath.section == 2){
        return ScaleH(100);
    }else if (indexPath.section == 3){
        return ScaleH(100);
    }
    return ScreenHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLChargeUpSectionHeader *header = [[WLChargeUpSectionHeader alloc] initWithType:self.itemType roleType:self.roleType section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (void)saveChargeUp
{
    [self.view endEditing:YES];
    WLChargeUpObject *object = [[WLChargeUpObject alloc] init];
    if (self.itemType == TouristItemTypeCar) {
        object.resourceID = self.carObject.orderID;
        
        WLConsumeCell *cell = (WLConsumeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        object.actualPrice = [cell getTopViewTextArray][0];
        object.remark = self.middleRemark;
        
    }else if (self.itemType == TouristItemTypeShopping){

        object.resourceID = self.selectRoleObject.resourceID;
        object.checklistID = self.selectRoleObject.checklistID;
        object.groupID = self.selectRoleObject.groupID;
        object.whichDate = self.selectRoleObject.whichDate;

        
        WLConsumeCell *cell = (WLConsumeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        object.actualPerson = [cell getTopViewTextArray][0];
        object.actualPrice = [cell getTopViewTextArray][1];
        
        NSUInteger sectionCount = 2;
        if (self.roleType == TouristRoleTypeMine) {
            sectionCount = 3;
        }
        object.remark = self.middleRemark;
        
    }else if (self.itemType == TouristItemTypeAdditional){
        
        object.resourceID = self.selectRoleObject.resourceID;
        object.checklistID = self.selectRoleObject.checklistID;
        object.groupID = self.selectRoleObject.groupID;
        object.whichDate = self.selectRoleObject.whichDate;
 
        WLConsumeCell *cell = (WLConsumeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        object.actualPerson = [cell getTopViewTextArray][0];
        object.priceList = [cell getScheduleObjectArray];
        
        NSUInteger sectionCount = 2;
        if (self.roleType == TouristRoleTypeMine) {
            sectionCount = 3;
        }
        object.remark = self.middleRemark;
        
    }else{
        
        object.resourceID = self.hotelObject.resourceID;
        object.checklistID = self.hotelObject.checklistID;
        object.groupID = self.hotelObject.groupID;
        object.whichDate = self.hotelObject.whichDay;
        
        WLConsumeCell *cell = (WLConsumeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        object.actualPerson = [cell getTopViewTextArray][0];
        object.priceList = [cell getScheduleObjectArray];
        object.remark = self.middleRemark;
        
    }
    WLAttachmentCell *attachCell = (WLAttachmentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    object.uploadImgArray = [attachCell getUploadImageArray];
    
    __weak __typeof(self)weakSelf = self;
    [WLNetworkManager chargeUpWithType:self.itemType object:object result:^(BOOL success, BOOL result) {
        if (success && result) {//记账成功
            [[WL_TipAlert_View sharedAlert] createTip:@"记账成功"];
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"记账失败"];
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)customerKeyboardWillShowWithSection:(NSUInteger)section height:(CGFloat)height
{

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, height, 0);
    CGRect rect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    [self.tableView scrollRectToVisible:rect animated:YES];
}

- (void)customerKeyboardWillHide
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    
}

- (void)deleteSchedulelistWithIndex:(NSUInteger)index
{
    BOOL origin = NO;
    WLChargeUpScheduleObject *object;
    if (self.itemType == TouristItemTypeAdditional) {
        
        if (index < self.selectRoleObject.scheduleList.count) {
            object = self.selectRoleObject.scheduleList[index];
            origin = YES;
        }else if (index >= self.selectRoleObject.scheduleList.count && index < self.selectRoleObject.scheduleList.count + self.itemArray.count){
            [self.itemArray removeObjectAtIndex:(index - self.selectRoleObject.scheduleList.count)];
        }
    }else{
        if (index < self.hotelObject.scheduleList.count) {
            object = self.hotelObject.scheduleList[index];
            origin = YES;
        }else if (index >= self.hotelObject.scheduleList.count && index < self.hotelObject.scheduleList.count + self.itemArray.count){
            [self.itemArray removeObjectAtIndex:(index - self.hotelObject.scheduleList.count)];
        }
    }
    
    if (origin) {
        
        [WLNetworkManager deleteChargeupSchedulelistWithType:_itemType checklistID:object.checklistID result:^(BOOL success, BOOL result, NSString *message) {
            [[WL_TipAlert_View sharedAlert] createTip:message];
            if (success && result) {
                
                if (self.itemType == TouristItemTypeAdditional) {
                    
                    [self.selectRoleObject.scheduleList removeObjectAtIndex:index];
                    
                }else{
                    [self.hotelObject.scheduleList removeObjectAtIndex:index];
                    
                }
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }else{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }

}
@end
