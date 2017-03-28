//
//  RegexTools.m
//  WeiLv
//
//  Created by lyx on 16/5/23.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "RegexTools.h"

@implementation RegexTools

#pragma mark - 邮箱格式验证
/**
 *  判断邮箱
 *
 *  @param email 需要判断的邮箱
 *
 *  @return 返回BOOL
 */
+ (BOOL)judgeEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 身份证号验证
/**
 *  判断身份证号
 *
 *  @param value 需要判断的身份证号
 *
 *  @return 返回BOOL
 */
+ (BOOL)validateIDCardNumber:(NSString *)value
{
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (!value) {
        return NO;
    }else {
        
        NSString *cardNumberRegex =@"^(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])$";
        
        NSPredicate *cardNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cardNumberRegex];
        
        return [cardNumberTest evaluateWithObject:value];
     }
    return NO;
}

#pragma mark  判断是否是手机号
/**
 *  判断手机号,只判断首位为1的11为数字
 *
 *  @param mobileNum 需要判断的手机号
 *
 *  @return 返回BOOL
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    return isMatch;
}

#pragma mark  判断是否是符合规定的支付密码
/**
 *  判断手机号,只判断首位为符合规定的密码
 *
 *  @param mobileNum 需要判断的密码
 *
 *  @return 返回BOOL
 */
+(BOOL)isPassWordNumber:(NSString *)passWordNumber
{
    
    NSString *phoneRegex = @"^[0-9a-zA-Z]{6}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL isMatch = [pred evaluateWithObject:passWordNumber];
    
    return isMatch;
}


#pragma mark  判断是否是年月日格式
/**
 *  判断年月日格式
 *
 *  @param dateStr 需要判断的年月日
 *
 *  @return 返回BOOL
 */


+(BOOL)isDateYYMMDD:(NSString *)dateStr
{
    
    NSString *dateRegex = @"^([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8])))$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",dateRegex];
    
    BOOL isMatch = [pred evaluateWithObject:dateStr];
    
    return isMatch;
}
#pragma mark  判断是否是汉字
/**
 *  判断是否为中文汉字
 *
 *  @param chineseStr 需要判断的中文汉字
 *
 *  @return 返回BOOL
 */
+(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}



#pragma mark  判断是否是QQ

+(BOOL)isQQ:(NSString *)QQStr
{

    NSString *chineseRegex = @"^[1-9][0-9]{4,}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    
    BOOL isMatch = [pred evaluateWithObject:QQStr];
    
    return isMatch;
}
#pragma mark  判断是否是座机,11或者12位

+(BOOL)isTelephoneNumber:(NSString *)telephoneNumber
{
    NSString *chineseRegex = @"^0\\d{2,3}[-]\\d{7,8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    
    BOOL isMatch = [pred evaluateWithObject:telephoneNumber];
    
    NSString *chineseR = @"^0\\d{2,3}\\d{7,8}$";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseR];
    
    BOOL isMat = [pre evaluateWithObject:telephoneNumber];

    
    return isMatch||isMat;
}


#pragma mark  判断是是否是真实姓名

+(BOOL)isRealName:(NSString *)realName
{
    NSString *chineseRegex = @"^[\\u4E00-\\u9FFF || a-z || A-Z || 0-9]+$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    
    BOOL isMatch = [pred evaluateWithObject:realName];
    
    return isMatch;
}

#pragma mark  判断是是否是军官证

+(BOOL)isMilitaryOfficer:(NSString *)militaryOfficer
{
    NSString *regex = @"^[南|北|沈|兰|成|济|广|海|空|参|政|后|装]字第(\\d{8})号$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:militaryOfficer];
    
    return isMatch;
}

#pragma mark  判断是是否是护照

+(BOOL)isPassport:(NSString *)passport
{
    NSString *regex = @"^[A-Z]\\d{7,8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:passport];
    
    return isMatch;
}


#pragma mark  判断是是否是港澳证件

+(BOOL)isHongKong_CardReg:(NSString *)hongKong_CardReg
{
    NSString *regex = @"^[a-zA-Z]{1}[0-9]{4,20}$";
   
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:hongKong_CardReg];
    
    return isMatch;
}

#pragma mark  判断是是否是台湾证件

+(BOOL)isTaiWan:(NSString *)taiWan
{
    NSString *regex = @"^[a-zA-Z0-9]{5,21}$";
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    BOOL isMatch = [pred evaluateWithObject:taiWan];
    
    return isMatch;
}

#pragma mark 判断是否全是数字
+(BOOL)isAllNumber:(NSString *)allNumberStr
{
    NSString *pattern = @"^[0-9]*$";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:allNumberStr options:0 range:NSMakeRange(0, allNumberStr.length)];
    return results.count > 0;
}
@end
