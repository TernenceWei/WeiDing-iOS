//
//  WL_Application_Driver_Bill_Statistics_lineChartView.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/10/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"

@interface WL_Application_Driver_Bill_Statistics_lineChartView : WL_BaseView
@property(nonatomic, strong)NSMutableArray *years;
@property(nonatomic, strong)NSMutableArray *amounts;
@property(nonatomic, strong)NSMutableArray *months;
@property(nonatomic, strong)NSMutableArray *pointViews;
@end
