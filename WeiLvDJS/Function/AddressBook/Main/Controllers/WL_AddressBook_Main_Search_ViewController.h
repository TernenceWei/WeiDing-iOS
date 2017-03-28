//
//  WL_AddressBook_Main_Search_ViewController.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WL_AddressBook_Main_Search_ViewController : WL_BaseViewController

@property(nonatomic, copy) NSString *status;

/** 搜索记录数组 */
@property(nonatomic, strong) NSMutableArray *searchRecords;

@end
