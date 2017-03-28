//
//  WL_AddressBook_Content_Model.h
//  WeiLvDJS
//
//  Created by 张继伟 on 2016/11/8.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseModel.h"

@interface WL_AddressBook_Content_Model : WL_BaseModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,strong)UIImage *headerImage;
@property (nonatomic,copy) NSString *uperCharater;

@property (nonatomic,assign)BOOL isSelected;

@end
