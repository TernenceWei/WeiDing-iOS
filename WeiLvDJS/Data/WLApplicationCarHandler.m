//
//  WLApplicationCarHandler.m
//  WeiLvDJS
//
//  Created by whw on 17/3/6.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationCarHandler.h"

@implementation WLApplicationCarHandler

+ (void)saveBaseInfoWithDataArray:(NSArray *)dataArray andCompanyName:(NSString *)companyName InfoRemark:(NSString *)infoRemark
{
    NSString *path = [self getBaseIofoPath];
    WLApplicationCarInfocar_infoModel *carBaseInfoModel = [[WLApplicationCarInfocar_infoModel alloc]init];
    carBaseInfoModel.brand = [dataArray objectAtIndex:0];
    carBaseInfoModel.model = [dataArray objectAtIndex:1];
    carBaseInfoModel.seat_amount = [dataArray objectAtIndex:2];
    carBaseInfoModel.number = [dataArray objectAtIndex:3];
    carBaseInfoModel.first_enabled_at = [dataArray objectAtIndex:4];
    carBaseInfoModel.day_pricing = [dataArray objectAtIndex:5];
    carBaseInfoModel.kilometer_pricing = [dataArray objectAtIndex:6];
    carBaseInfoModel.body_name = companyName;
    carBaseInfoModel.memo = infoRemark;
    [NSKeyedArchiver archiveRootObject:carBaseInfoModel toFile:path]; //归档
}
+ (BOOL)savePicsWithPicsArray:(NSArray *)picArray
{
    NSMutableArray *picsMuArray = [NSMutableArray array];
    NSString *imageStr1 = [self getImageDataStringWith:[picArray objectAtIndex:0]];
    NSString *imageStr2 = [self getImageDataStringWith:[picArray objectAtIndex:1]];
    [picsMuArray addObject:imageStr1];
    [picsMuArray addObject:imageStr2];
    NSArray *carsArray = [picArray objectAtIndex:2];
    NSMutableArray *carsMuArray = [NSMutableArray arrayWithCapacity:carsArray.count];
    for (UIImage *image in carsArray) {
        NSString *imageStr = [self getImageDataStringWith:image];
       [carsMuArray addObject:imageStr];
    }
    [picsMuArray addObject:carsMuArray];
    NSString *imageStr3 = [self getImageDataStringWith:[picArray objectAtIndex:3]];
    [picsMuArray addObject:imageStr3];
    NSString *path = [self getPicsPath];
  return [picsMuArray writeToFile:path atomically:YES];
}
+ (WLApplicationCarInfocar_infoModel *)redBaseInfo  /**< 读取基本信息 */
{
  
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getBaseIofoPath]];
}
+ (NSArray *)redPics  /**< 读取图片信息 */
{
    NSString *path = [self getPicsPath];
    NSArray *picsArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *picsMuArray = [NSMutableArray arrayWithCapacity:picsArray.count];
    UIImage *image1 = [self getImageWithDataString:[picsArray objectAtIndex:0]];
    UIImage *image2 = [self getImageWithDataString:[picsArray objectAtIndex:1]];
    NSArray *carsArray = [[picsArray objectAtIndex:2] copy];
    NSMutableArray *carsMuarray = [NSMutableArray arrayWithCapacity:carsArray.count];
    for (NSString *imageStr in carsArray) {
        UIImage *carImage = [self getImageWithDataString:imageStr];
        [carsMuarray addObject:carImage];
    }
    UIImage *image3 = [self getImageWithDataString:[picsArray objectAtIndex:3]];
    [picsMuArray addObject:image1];
    [picsMuArray addObject:image2];
    [picsMuArray addObject:carsMuarray];
    [picsMuArray addObject:image3];
    return picsMuArray.copy;
}
/**< 转换成data字符串 */
+ (NSString *)getImageDataStringWith:(UIImage *)image
{
    NSData *picData = UIImageJPEGRepresentation(image, 0.6f);
    //将图片的data转化为字符串
    return [picData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
/**< 转换成图片 */
+ (UIImage *)getImageWithDataString:(NSString *)dataStr
{
    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:dataStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:decodedImageData];
}
+ (void)clearCache
{
    NSString *path1 = [self getBaseIofoPath];
    NSString *path2 = [self getPicsPath];
    [[NSFileManager defaultManager] removeItemAtPath:path1 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:path2 error:nil];
}
+ (NSString *)getBaseIofoPath
{
   return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carBaseInfo.plist"];
}
+ (NSString *)getPicsPath
{
 return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carPicsInfo.plist"];
}
@end
