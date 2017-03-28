//
//  WL_Application_Content_Title_View.h
//  WeiLvDJS
//
//  Created by 张继伟 on 16/9/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseView.h"
@class CycleScrollView;
@interface WL_Application_Content_Title_View : UICollectionReusableView

@property(nonatomic, weak)UIImageView *noticeImageView;

@property(nonatomic, weak)UILabel *titleLable;
/**  图片数组 */
@property(nonatomic, strong) NSMutableArray *pictures;

//添加应用标题左侧红色指示器
@property(nonatomic, weak) UIView *indicatorView;

@property(nonatomic, strong)CycleScrollView *cycle;
/**< 轮播图下面的公告 */
@property (nonatomic, weak) UILabel *noticeLabel;
/**< 右侧选择城市的按钮 */
//@property (nonatomic, weak) UIButton *selectCityButton;

- (void)creatScrollViewToTitleView;



@end
