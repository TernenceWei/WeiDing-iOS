//
//  WLChargeUpSectionHeader.m
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLChargeUpSectionHeader.h"

@interface WLChargeUpSectionHeader ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation WLChargeUpSectionHeader
- (instancetype)initWithType:(TouristItemType)type
                    roleType:(TouristRoleType)roleType
                     section:(NSInteger)section
{
    self = [super init];
    if (self) {

        self.backgroundColor = HEXCOLOR(0xeff1fe);
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = HEXCOLOR(0x868686);
        self.titleLabel.font = [UIFont WLFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.frame = CGRectMake(ScaleW(12), 0, ScreenWidth, 40);
        [self addSubview:self.titleLabel];
        NSString *text = @"消费信息";
        if (type == TouristItemTypeShopping || type == TouristItemTypeAdditional) {
            if (section == 0) {
                text = @"消费信息";
            }else if (section == 1){
                if (roleType == TouristRoleTypeMine) {
                    text = @"返现信息";
                }else{
                    text = @"附件";
                }
                
            }else if (section == 2){
                if (roleType == TouristRoleTypeMine) {
                    text = @"附件";
                }else{
                    text = @"备注信息";
                }
            }else if (section == 3){
                text = @"备注信息";
            }
        }else {
            if (section == 0) {
                text = @"消费信息";
            }else if (section == 1){
                text = @"支付信息";
            }else if (section == 2){
                text = @"附件";
            }else if (section == 3){
                text = @"备注信息";
            }
        }
        self.titleLabel.text = text;
        
    }
    return self;
}

@end
