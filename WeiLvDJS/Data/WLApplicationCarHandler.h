//
//  WLApplicationCarHandler.h
//  WeiLvDJS
//
//  Created by whw on 17/3/6.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLApplicationCarInfoModel.h"
@interface WLApplicationCarHandler : NSObject

+ (void)saveBaseInfoWithDataArray:(NSArray *)dataArray
                   andCompanyName:(NSString *)companyName
                       InfoRemark:(NSString *)infoRemark;/**< 缓存基本数据 */

+ (BOOL)savePicsWithPicsArray:(NSArray *)picArray;/**< 缓存图片数据 */
+ (WLApplicationCarInfocar_infoModel *)redBaseInfo;/**< 读取基本信息 */
+ (NSArray *)redPics;/**< 读取缓存的图片 */
+ (void)clearCache;/**< 清除缓存 */
@end
