//
//  WLDataCarBookingHandler.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/19.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLDataCarBookingHandler.h"

#define startHistoryPath @"CarBookingStartAddressHistory.plist"
#define endHistoryPath   @"CarBookingEndAddressHistory.plist"
#define carBookingImagePath @"carBookingImage.data"

static WLDataCarBookingHandler* sharedInstance;


@interface WLDataCarBookingHandler ()

@property (nonatomic, strong) NSMutableArray *savedImageArray;

@end

@implementation WLDataCarBookingHandler
- (NSMutableArray *)savedImageArray
{
    if (!_savedImageArray) {
        _savedImageArray = [NSMutableArray array];
    }
    return _savedImageArray;
}

+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[WLDataCarBookingHandler alloc] init];
    }
    return sharedInstance;
}

- (NSString*)getStartPointHistoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:startHistoryPath];
}

- (NSString*)getEndPointHistoryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:endHistoryPath];
}

- (NSArray *)getStartPointHistory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getStartPointHistoryPath];
    NSArray *array;
    if (![fm fileExistsAtPath:listPath]) {
        array = [NSArray array];
    }else{
        array = [NSArray arrayWithContentsOfFile:listPath];
    }
    return array;
}

- (void)addNewStartPointItem:(NSDictionary *)dict
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getStartPointHistoryPath];
    NSMutableArray *array;
    if ([fm fileExistsAtPath:listPath]) {
        array = [NSMutableArray arrayWithContentsOfFile:listPath];
    }else{
        [fm createDirectoryAtPath:[listPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        array = [NSMutableArray array];
    }
    NSString *name = [dict objectForKey:@"name"];
    BOOL result = NO;
    for (NSDictionary *item in array) {
        if ([name isEqualToString:[item objectForKey:@"name"]]) {
            result = YES;
        }
    }
    if (!result) {
        [array insertObject:dict atIndex:0];
    }
    if (array.count > 15) {
        [array removeLastObject];
    }
    [array writeToFile:listPath atomically:YES];
}

- (void)removeStartPointItem:(NSDictionary *)dict
{
    NSString *listPath = [self getStartPointHistoryPath];
    NSArray *startArray = [self getStartPointHistory];
    NSMutableArray *array = [startArray mutableCopy];
    
    for (NSDictionary *item in startArray) {
        if ([[item objectForKey:@"name"] isEqualToString:[dict objectForKey:@"name"]]) {
            [array removeObject:item];
        }
    }
    [array writeToFile:listPath atomically:YES];
}

- (NSArray *)getEndPointHistory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getEndPointHistoryPath];
    NSArray *array;
    if (![fm fileExistsAtPath:listPath]) {
        array = [NSArray array];
    }else{
        array = [NSArray arrayWithContentsOfFile:listPath];
    }
    return array;
}

- (void)addNewEndPointItem:(NSDictionary *)dict
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *listPath = [self getEndPointHistoryPath];
    NSMutableArray *array;
    if ([fm fileExistsAtPath:listPath]) {
        array = [NSMutableArray arrayWithContentsOfFile:listPath];
    }else{
        [fm createDirectoryAtPath:[listPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        array = [NSMutableArray array];
    }
    NSString *name = [dict objectForKey:@"name"];
    BOOL result = NO;
    for (NSDictionary *item in array) {
        if ([name isEqualToString:[item objectForKey:@"name"]]) {
            result = YES;
        }
    }
    if (!result) {
        [array insertObject:dict atIndex:0];
    }

    if (array.count > 15) {
        [array removeLastObject];
    }
    [array writeToFile:listPath atomically:YES];
}

- (void)removeEndPointItem:(NSDictionary *)dict
{
    NSString *listPath = [self getEndPointHistoryPath];
    NSArray *endArray = [self getEndPointHistory];
    NSMutableArray *array = [endArray mutableCopy];
    for (NSDictionary *item in endArray) {
        if ([[item objectForKey:@"name"] isEqualToString:[dict objectForKey:@"name"]]) {
            [array removeObject:item];
        }
    }
    [array writeToFile:listPath atomically:YES];
}


- (NSString*)getCarBookingImagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:carBookingImagePath];
}

- (void)saveCarBookingImageArray:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIImage *image in array) {
        NSData *data = UIImageJPEGRepresentation(image, 0.8);
        [tempArray addObject:data];
    }
    NSString *listPath = [self getCarBookingImagePath];
    BOOL result = [tempArray writeToFile:listPath atomically:YES];
    WlLog(@"保存状态%d",result);
}

- (void)removeCarBookingImageArray
{
    NSString *listPath = [self getCarBookingImagePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:listPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:listPath error:nil];
    }
    
}

- (NSArray *)getImageDataArray
{
    NSString *listPath = [self getCarBookingImagePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:listPath]) {
        return [NSArray arrayWithContentsOfFile:listPath];
    }else{
        return [NSArray array];
    }
}

- (void)saveCarBookingRemark:(NSString *)remark
{
    [[NSUserDefaults standardUserDefaults] setObject:remark forKey:@"CarBookingRemark"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getCarBookingRemark
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"CarBookingRemark"];
}

- (void)removeCarBookingRemark
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarBookingRemark"];
}
@end
