//
//  WL_EditPrivateLetter_ViewController.h
//  WeiLvDJS
//
//  Created by jyc on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_BaseViewController.h"

@interface WL_EditPrivateLetter_ViewController : WL_BaseViewController

@property(nonatomic,assign)NSInteger type;

-(void)reloadCellectionViewWith:(NSMutableDictionary *)dictionary;

@end
