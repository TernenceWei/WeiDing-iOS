//
//  WLTools.h
//  WeiLv
//
//  Created by James on 16/2/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface WLTools : NSObject<NSXMLParserDelegate>

#pragma mark - 加密实现MD5和SHA1
+(NSString *) md5:(NSString *)str;
+(NSString*) sha1:(NSString *)str;

#pragma mark - 实现http GET/POST 解析返回的json数据
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data;

#pragma mark - 颜色十六进制转换成UIColor
+(UIColor *) stringToColor:(NSString *)str;

#pragma mark - 把格式化的JSON格式的字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - 把字典转换成JSON格式
+ (NSString *)wlDictionaryToJson:(NSDictionary *)dic;

#pragma mark - 把数组转换成JSON格式
+ (NSString *)wlArrayToJson:(NSArray *)arr;

#pragma mark - 创建label
+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;

#pragma mark - 创建button
+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame;

#pragma mark - 创建imageView
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image;

#pragma mark--返回不带小数点的字符串
+ (NSString *)returnIntStrFrom:(NSString *)str;

#pragma mark--返回两位小数点的字符串
+ (NSString *)return02lfStrFrom:(NSString *)str;


#pragma mark--空字符串判断
+ (BOOL)judgeString:(NSString *)returnStr;

#pragma mark--过滤字符串中的空格
+(NSString *)FliterWhiteSpace:(NSString *)str;

#pragma mark--过滤字符串中的html标签
+ (NSString *)filterHTML:(NSString *)html;

#pragma mark--删除webView 的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView;

#pragma mark--验证MD5字符串
+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;

#pragma mark--获取当前时间戳
+(NSString *)getOrderTrSeq;

#pragma mark--获取当前时间毫秒级
+(NSString *)getOrderTimeMS;
#pragma mark - 计算当前时间到失效时间之间的间隔
+ (double)setupDifferentTime:(NSString *)failureTime;
#pragma mark--获取当前时间分钟级
+(NSString *)getOrderTime;

#pragma mark-- 获取iPhone客户端UUID
+(NSString*)getIPhoneUUID;

#pragma mark--获取iPhone客户端MAC地址
+(NSString *)getIPhoneMacAddress;

#pragma mark--过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string;

#pragma mark - 获取字符串的宽度
+(CGFloat)getStringWidth:(NSString *)str fontSize:(float)size;

#pragma mark - 获取字符串的高度
+(CGFloat)getStringHeight:(NSString *)str fontSize:(float)size;

#pragma mark - 手机号码格式化
+(NSString *)phoneNumberFormat:(NSString *)phone;

#pragma mark - 字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

#pragma mark - 实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity;

#pragma mark - 判断是否为整形
+ (BOOL)isPureInt:(NSString*)string;

#pragma mark - 判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string;

@end

