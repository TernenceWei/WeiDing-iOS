//
//  WL_SearchResultTableView.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/22.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  搜索结果列表

#import <UIKit/UIKit.h>

@interface WL_SearchResultTableView : UITableViewController

-(void)reloadDataWithArray:(NSMutableArray *)array;

@property(nonatomic,copy)NSString *searchText;

@property(nonatomic,copy)void (^popSearchTextBlock)(NSString *text);

@end
