//
//  NSString+WS.h
//  WSExtension
//
//  Created by ternence on 16/11/21.
//  Copyright © 2016年 ternence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WS)
- (BOOL)isValidEmail;
- (NSString *)urlencode;
- (NSString *)httpUrlCheck;
- (BOOL)isBlankString;
- (BOOL)checkPasswordFormat;
- (BOOL)checkUsernameFormat;
@end
