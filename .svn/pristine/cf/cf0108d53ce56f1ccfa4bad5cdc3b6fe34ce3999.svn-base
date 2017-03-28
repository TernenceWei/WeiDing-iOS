//
//  WL_CheckVersion.m
//  WeiLv
//
//  Created by James on 16/7/16.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "WL_CheckVersion.h"
#import "AppDelegate.h"
@implementation WL_CheckVersion

+(void) checkVersion
{
    
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",WeiLvAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error )
        {
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if (![versionsInAppStore count])
                {
                    return;
                }
                else
                {
                    
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    
                    if ([AppVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending)
                    {
                        
                        [WL_CheckVersion showAlertWithAppStoreVersion:currentAppStoreVersion];
                        
                    }
                    else
                    {
                        //[CheckVersion checkPCVersion];
                    }
                    
                }
                
            });
        }
        
    }];
}




+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion
{
    
    
    if ([ForceUpdate isEqual:@"1"])
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:WeiLvAlertViewTitle
                                                            message:[NSString stringWithFormat:@"%@ 发现新版本. 请现在立即更新 %@ ",WeiLvAppName, currentAppStoreVersion]
                                                           delegate:self
                                                  cancelButtonTitle:WeiLvUpdateButtonTitle
                                                  otherButtonTitles:nil, nil];
        alertView.tag=100;
        
        [alertView show];
        
    }
    else
    {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:WeiLvAlertViewTitle
                                                            message:[NSString stringWithFormat:@"%@ 发现新版本. 请现在立即更新 %@ ", WeiLvAppName, currentAppStoreVersion]
                                                           delegate:self
                                                  cancelButtonTitle:WeiLvCancelButtonTitle
                                                  otherButtonTitles:WeiLvUpdateButtonTitle, nil];
        
        [alertView show];
        
    }
    
}


+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([ForceUpdate isEqual:@"1"])
    {
        //PC端版本 提示框 按钮
        if (alertView.tag==101)
        {
            
            
        }
        else
        {
            //APP端版本 提示框 按钮
            NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",WeiLvAppID];
            NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
            [[UIApplication sharedApplication] openURL:iTunesURL];
        }
        [WL_CheckVersion exitApplication];
    }
    else
    {
        
        switch ( buttonIndex )
        {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
                
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",WeiLvAppID];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
                
                
                [WL_CheckVersion exitApplication];
            }
                break;
            default:
                break;
        }
    }
}

+(void)exitApplication
{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}




@end
