//
//  ContactDataHelper.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "ContactDataHelper.h"
#import "WL_AddressBook_Content_Model.h"//model

@implementation ContactDataHelper

+ (instancetype)shareManager{
    
    static ContactDataHelper *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ContactDataHelper alloc]init];
    });
    return manager;
    
}
//  将数组重复的对象去除，只保留一个
- (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++)
    {
        @autoreleasepool
        {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO)
            {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}

/*将汉字转换为不带音调的拼音
 *string是要转换的字符串*/
- (NSString *)transformMandarinToLatin:(NSString *)string
{
    /*复制出一个可变的对象*/
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    
    /*多音字处理*/
    if ([[(NSString *)string substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    return preString;
}

#pragma mark ----过滤电话
- (NSString *)trimmingString:(NSString *)string{
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    
    
    NSRange range = [mutableString rangeOfString:@"("];
    while (range.location != NSNotFound) {
        
        [mutableString deleteCharactersInRange:range];
        
        range = [mutableString rangeOfString:@"("];
    }
    
    range = [mutableString rangeOfString:@" "];
    while (range.location != NSNotFound) {
        
        [mutableString deleteCharactersInRange:range];
        
        range = [mutableString rangeOfString:@" "];
    }
    
    range = [mutableString rangeOfString:@")"];
    while (range.location != NSNotFound) {
        
        [mutableString deleteCharactersInRange:range];
        
        range = [mutableString rangeOfString:@")"];
    }
    
    range = [mutableString rangeOfString:@"-"];
    while (range.location != NSNotFound) {
        
        [mutableString deleteCharactersInRange:range];
        
        range = [mutableString rangeOfString:@"-"];
    }
    
    range = [mutableString rangeOfString:@" "];
    while (range.location != NSNotFound) {
        
        [mutableString deleteCharactersInRange:range];
        
        range = [mutableString rangeOfString:@" "];
    }
    
    return mutableString;
    
    
    
    
}

@end
