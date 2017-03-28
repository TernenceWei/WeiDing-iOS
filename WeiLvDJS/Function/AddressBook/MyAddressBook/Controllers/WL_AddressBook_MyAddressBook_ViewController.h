//
//  WL_AddressBook_MyAddressBook_ViewController.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//
typedef NS_ENUM(NSInteger,ChooseType){
    
    ChooseTypeSingle, //单选
    ChooseTypeMulty, //多选
    ChooseTypeAddVisitor //添加通讯录
};
#import "WL_BaseViewController.h"
@class WL_AddressBook_Content_Model;
@interface WL_AddressBook_MyAddressBook_ViewController : WL_BaseViewController

//初始化方法
- (instancetype)initWithType:(ChooseType)chooseType;

//单选的回调block
@property (nonatomic,copy) void(^singleBlock)(WL_AddressBook_Content_Model *model);


//多选的回调block
@property (nonatomic,copy) void(^multyBlock)(NSArray *array);

@end
