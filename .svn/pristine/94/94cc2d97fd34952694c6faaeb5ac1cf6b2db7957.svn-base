//
//  WLTools.m
//  WeiLv
//
//  Created by James on 16/2/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WLTools.h"
#import <sys/sockio.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation WLTools



#pragma mark - 加密实现MD5和SHA1
+(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
    
    CC_MD5( cStr, strlen(cStr), digest );
#pragma clang diagnostic pop
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}
/* sha1 encode */
+(NSString*) sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
    
    CC_SHA1(data.bytes, data.length, digest);
#pragma clang diagnostic pop
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - 实现http GET/POST 解析返回的json数据
+(NSData *) httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    //设置提交方式
    [request setHTTPMethod:method];
    //设置数据类型
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //设置编码
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //如果是POST
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
#pragma clang diagnostic pop
    
    return response;
}




#pragma mark - 颜色十六进制转换成UIColor
/**
 *   颜色十六进制转换成UIColor
 *
 *  @param str 十六进制颜色值
 *
 *  @return 返回UIColor
 */
+(UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""])
    {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}



#pragma mark - 把格式化的JSON格式的字符串转换成字典
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @param jsonString
 *
 *  @return jsonString JSON格式的字符串
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        WlLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 把字典转换成JSON格式

+ (NSString*)wlDictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark - 把数组转换成JSON格式
+ (NSString*)wlArrayToJson:(NSArray *)arr {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 创建label
+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    return label;
}

#pragma mark - 创建button
+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:nom_bg forState:UIControlStateNormal];
    [btn setBackgroundImage:hei_bg forState:UIControlStateHighlighted];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    return btn;
}
#pragma mark - 创建imageview
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}
#pragma mark--返回不带小数点的字符串
+ (NSString *)returnIntStrFrom:(NSString *)str
{
    
     NSString *resulutStr;
    if ([str rangeOfString:@"."].location!=NSNotFound) {
        NSInteger index =[str rangeOfString:@"."].location;
        WlLog(@"%ld",(long)index);
        resulutStr=[str substringToIndex:index];
        
    }else{
        return str;
    }
   return resulutStr;
}

#pragma mark--返回两位小数点的字符串
+ (NSString *)return02lfStrFrom:(NSString *)str
{
    
    NSString *resulutStr;
    if ([str rangeOfString:@"."].location!=NSNotFound) {
       
        NSInteger index =[str rangeOfString:@"."].location;
        
        NSString *s=[str substringFromIndex:index+1];
        if (s.length>=2){
        
            resulutStr=[str substringToIndex:index+3];
    
        }else{
            
            return str;
        
        }
    }else{
        return str;
    }
    return resulutStr;
}


/**
 *  判断字符串是否为空
 *
 *  @param returnStr 字符串
 *
 *  @return 结果值
 */
+ (BOOL)judgeString:(NSString *)returnStr {
    
    if (returnStr) {
        returnStr = [NSString stringWithFormat:@"%@", returnStr];
    }
    if ([returnStr isEqual:[NSNull null]] || returnStr.length == 0 || returnStr == nil || [returnStr isEqualToString:@""] || !returnStr || [returnStr isEqualToString: @"<null>"]||[returnStr isEqualToString: @"(null)"]||[returnStr isEqualToString: @"null"]) {
        return NO;
    }
    return YES;
}

#pragma mark--过滤字符串中的空格
+(NSString *)FliterWhiteSpace:(NSString *)str
{
   str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
   return str;
}

#pragma mark--过滤字符串中的html标签
+ (NSString *)filterHTML:(NSString *)html {

    NSScanner * scanner = [NSScanner scannerWithString:html];
    
    NSString * text = nil;
    
    while([scanner isAtEnd] == NO){
        
        [scanner scanUpToString:@"<" intoString:nil];
        
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

#pragma mark--删除webView 的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView
{
    for(id subview in webView.subviews)
    {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]])
            
        {
            ((UIScrollView *)subview).bounces = NO;
            
            [(UIScrollView *)subview setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)subview setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
        }
    
        webView.scrollView.bounces=NO;
    }
    
}

#pragma mark--验证MD5字符串
+ (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString
{
   return [signString isEqualToString:[self md5:string]];
}

#pragma mark--获取当前时间戳
+(NSString *)getOrderTrSeq
{
    NSDate *senddate=[NSDate date];
    NSString *locationString = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    return locationString;
}

#pragma mark--获取当前时间毫秒级
+(NSString *)getOrderTimeMS
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmssSS"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}
#pragma mark - 计算当前时间到失效时间之间的间隔
+ (double)setupDifferentTime:(NSString *)failureTime
{
    return [KDateManager setupDifferentTime:failureTime];
}
#pragma mark--获取当前时间分钟级
+(NSString *)getOrderTime
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *locationString = [dateformatter stringFromDate:senddate];
    return locationString;
}

#pragma mark-- 获取iPhone客户端UUID
+(NSString*)getIPhoneUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark--获取iPhone客户端MAC地址
+(NSString *)getIPhoneMacAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);

    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

#pragma mark--过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/：；（）¥「」＂、[]{}#%-*+=_\\|~<>$€^•'@#$%^&*()_+'\""];
    NSString *body=@"";
    for (int i=0; i<string.length; i++) {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange userNameRange = [s rangeOfCharacterFromSet:set];
        if (userNameRange.location != NSNotFound)
        {
            s = @"";
        }
        body = [body stringByAppendingString:s];
    }
    return body;
}

#pragma mark - 获取字符串的宽度
+(CGFloat)getStringWidth:(NSString *)str fontSize:(float)size
{
    NSDictionary *attributes = @{NSFontAttributeName: WLFontSize(size)};
    
    CGFloat titleWidth = [str boundingRectWithSize:CGSizeMake(ScreenWidth,size) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    return titleWidth;
}

#pragma mark - 获取字符串的高度
+(CGFloat)getStringHeight:(NSString *)str fontSize:(float)size
{
    NSDictionary *attributes = @{NSFontAttributeName: WLFontSize(size)};
    
    CGFloat titleHeight = [str boundingRectWithSize:CGSizeMake(ScreenWidth-60,size) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    return titleHeight;

}

#pragma mark - 手机号码格式化
+(NSString *)phoneNumberFormat:(NSString *)phone
{
    NSString *strPhone=phone;
    
    if (phone.length==11)
    {
        NSString *oneStr=[strPhone substringWithRange:NSMakeRange(0, 3)];
        NSString *twoStr=[strPhone substringWithRange:NSMakeRange(3, 4)];
        NSString *thirdStr=[strPhone substringWithRange:NSMakeRange(7, 4)];
        
        strPhone=[NSString stringWithFormat:@"%@-%@-%@",oneStr,twoStr,thirdStr];
        return strPhone;
    }
    return strPhone;
}

#pragma mark - 字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if (dict && entity)
    {
        
        for (NSString *keyName in [dict allKeys])
        {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector])
            {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [entity performSelector:destMethodSelector withObject:[dict objectForKey:keyName]];
                
#pragma clang diagnostic pop
            }
            
        }
        
    }
}

#pragma mark - 实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity
{
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        #pragma clang diagnostic pop
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    WlLog(@"%@", returnDic);
    
    return returnDic;
}


#pragma mark - 判断是否为整形
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 判断是否为浮点形
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
