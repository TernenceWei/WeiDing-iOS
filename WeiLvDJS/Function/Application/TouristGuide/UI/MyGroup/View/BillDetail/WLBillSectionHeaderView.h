//
//  WLBillSectionHeaderView.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLGuideListInfo.h"
#import "WLBillDetailInfo.h"

@interface WLBillSectionHeaderView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                 selectAction:(void(^)(WLGuideListInfo *guideInfo))selectionAction;

@property (nonatomic, strong) NSArray *roleArray;
@property (nonatomic, strong) WLBillDetailInfo *detailInfo;
@end
