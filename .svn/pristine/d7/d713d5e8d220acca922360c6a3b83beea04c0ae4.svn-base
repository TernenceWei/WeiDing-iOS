//
//  WLNetworkDriverHandler.m
//  WeiLvDJS
//
//  Created by ternence on 2016/12/27.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkDriverHandler.h"
#import "WLDriverOrderListObject.h"
#import "WLDriverOrderObject.h"
#import "WLDriverBillListObject.h"
#import "WLDriverBillStatisticsObject.h"
#import "WL_Copmany_Model.h"
#import "WLApplicationCarInfoModel.h"
static WLNetworkDriverHandler * sharedInstance;

@implementation WLNetworkDriverHandler

+ (instancetype)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[WLNetworkDriverHandler alloc] init];
    }
    return sharedInstance;
}

- (NSString *)getUserID
{
    return @"2";
}

- (NSString *)getCompanyID
{
    return [WLKeychainTool readKeychainValue:@"CompanyID"];
}

- (NSString *)getAccessToken
{
    return [WLUserTools getAccessToken];
}

// 请求司机与车辆认证状态的接口
//- (void)requestDriverAndCarStatusWithResultBlock:(void (^)(BOOL, WLDriverStatus, WLCarStatus,NSNumber *drive_id, NSString *))resultBlock
//{
//    self requestDriverAndCarStatusWithCompanyID:nil AndResultBlock:<#^(BOOL, WLDriverStatus, WLCarStatus, NSNumber *drive_id, NSString *)resultBlock#>
////    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverHomeURL];
////    
//////    NSString *userID = [self getUserID];
////    NSString *companyID = [self getCompanyID];
////    
////    NSDictionary *params = @{
////                             @"company_id": companyID
////                            };
////    
////    [WLNetworkTool requestWithRequestType:WLRequestTypePost
////                                      url:urlString
////                                   params:params
////                                  success:^(id responseObject) {
////                                      
////                                      NSDictionary *dict = (NSDictionary *)responseObject;
////                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
////                                      NSString *message = [dict objectForKey:@"message"];
////                                      NSDictionary *data = [dict objectForKey:@"data"];
////                                      if (status == 200) {
//////                                           WlLog(@"responseObject %@",responseObject);
////                                          
////                                          WLDriverStatus driverStatus = [[data objectForKey:@"driver"] integerValue];
////                                          WLCarStatus carStatus = [[data objectForKey:@"car"] integerValue];
////                                          NSNumber *driveID = [data objectForKey:@"driver_id"];
////                                          NSString *citystr = [data objectForKey:@"city_str"];
////                                          return resultBlock(YES, driverStatus, carStatus,driveID, citystr);
////                                          
////                                      }
////                                      return resultBlock(NO, -1, -1,nil, nil);
////                                  }
////                                  failure:^(NSError *error) {
////                                      
////                                      return resultBlock(NO, -1, -1,nil, nil);
////                                      
////                                  }];
//
//}
- (void)requestDriverAndCarStatusWithCompanyID:(NSString *) companyID AndResultBlock:(void (^)(BOOL, WLDriverStatus, WLCarStatus,NSNumber *drive_id, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverHomeURL];
    
    //    NSString *userID = [self getUserID];
    NSString *company_ID;
    if (companyID == nil||companyID.length<=0) {
         company_ID = [self getCompanyID];
    }else{
        company_ID = companyID;
    }
    
    
    NSDictionary *params = @{
                             @"company_id": company_ID
                             };
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
//                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          //                                           WlLog(@"responseObject %@",responseObject);
                                          
                                          WLDriverStatus driverStatus = [[data objectForKey:@"driver"] integerValue];
                                          WLCarStatus carStatus = [[data objectForKey:@"car"] integerValue];
                                          NSNumber *driveID = [data objectForKey:@"driver_id"];
                                          NSString *citystr = [data objectForKey:@"city_str"];
                                          return resultBlock(YES, driverStatus, carStatus,driveID, citystr);
                                          
                                      }
                                      return resultBlock(NO, -1, -1,nil, nil);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return resultBlock(NO, -1, -1,nil, nil);
                                      
                                  }];
}
/***
 获取车辆信息
 **/
- (void)requestCarInfoWithCompanyID:(NSString *)companyID AndDataBlock:(CompletionDataBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverCarInfoURL];

    NSString *company_ID;
    if (companyID == nil||companyID.length<=0) {
        company_ID = [self getCompanyID];
    }else{
        company_ID = companyID;
    }
    
    NSDictionary *params = @{
                             @"company_id": company_ID
                             };
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost url:urlString
                                   params:params
                                  success:^(id responseObject) {
//                                      WlLog(@"responseObject %@",responseObject);
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          WLApplicationCarInfodataModel *object = [[WLApplicationCarInfodataModel alloc] init];
                                          [object setValuesForKeysWithDictionary:data];
                                          return block(WLResponseTypeSuccess, object, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      
                                      return block(WLResponseTypeNoNetwork, nil, message);
                                  }];
    
    
}
/**< 编辑车辆图片 */
- (void)editCarPicturesWithDict:(NSDictionary *)params resultBlock:(OperationBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:EditCarPictureURL];
    
    UIImage *image = [params objectForKey:@"image"];
    NSString *picName = [params objectForKey:@"imageName"];
    NSMutableDictionary *dicM = params.mutableCopy;
    [dicM removeObjectForKey:@"image"];
    [dicM removeObjectForKey:@"imageName"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;

    NSData *data = UIImageJPEGRepresentation(image, 0.8);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString parameters:dicM constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            if (data) {
                [formData appendPartWithFileData:data name:picName fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                NSString *message = [dict objectForKey:@"message"];
                if (status == 200) {
                    
                    return block(WLResponseTypeSuccess, YES, message);
                    
                }
                return block(WLResponseTypeSuccess, NO, message);
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            
            NSString *message = [WLNetworkTool getFailureMessageWithError:error];
            return block(WLResponseTypeNoNetwork, NO, message);
            
        }];
        
    });
}
/**< 增加车辆信息 */
- (void)addCarInfoWithDict:(NSDictionary *)params resultBlock:(OperationBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:AddCarURL];
    NSString *companyID = [self getCompanyID];
    
    NSMutableDictionary *baseDic = [[params objectForKey:@"baseDic"] mutableCopy];
    [baseDic setValue:companyID forKey:@"company_id"];
    NSDictionary *picDic = [params objectForKey:@"picDic"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString parameters:baseDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            NSData *carimg1Data = [picDic objectForKey:@"carimg1"];
            if (carimg1Data) {
                [formData appendPartWithFileData:carimg1Data name:@"carimg1" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *carimg2Data = [picDic objectForKey:@"carimg2"];
            if (carimg2Data) {
                [formData appendPartWithFileData:carimg2Data name:@"carimg2" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *img1Data = [picDic objectForKey:@"img1"];
            if (img1Data) {
                [formData appendPartWithFileData:img1Data name:@"img1" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *img2Data = [picDic objectForKey:@"img2"];
            if (img2Data) {
                [formData appendPartWithFileData:img2Data name:@"img2" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *img3Data = [picDic objectForKey:@"img3"];
            if (img3Data) {
                [formData appendPartWithFileData:img3Data name:@"img3" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *img4Data = [picDic objectForKey:@"img4"];
            if (img4Data) {
                [formData appendPartWithFileData:img4Data name:@"img4" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *img5Data = [picDic objectForKey:@"img5"];
            if (img5Data) {
                [formData appendPartWithFileData:img5Data name:@"img5" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            NSData *taxiData = [picDic objectForKey:@"taxi"];
            if (taxiData) {
                [formData appendPartWithFileData:taxiData name:@"taxi" fileName:[NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]] mimeType:@"image/jpeg"];
            }
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                NSString *message = [dict objectForKey:@"message"];
                if (status == 200) {
                    
                    return block(WLResponseTypeSuccess, YES, message);
                    
                }
                return block(WLResponseTypeSuccess, NO, message);
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            
            
                                                  NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                                  return block(WLResponseTypeNoNetwork, NO, message);
            
        }];
        
    });

}

- (void)editCarInfoWithDict:(NSDictionary *)params resultBlock:(OperationBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:EditCarInfoURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      if (status == 200) {
                                          
                                          return block(WLResponseTypeSuccess, YES, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, NO, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                     WlLog(@"   message%@",message);
                                      return block(WLResponseTypeNoNetwork, nil, message);
                                  }];
}

/***
 获取司机信息
 **/
- (void)requestDriverInfoWithResultBlock:(void (^)(BOOL, NSString *, NSDictionary *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverDriverInfoURL];
    NSString *userID = [self getUserID];
    NSString *companyID = [self getCompanyID];
    
    NSDictionary *params = @{@"user_id": userID,
                             @"company_id": companyID};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {

                                          return resultBlock(YES, message,data);
                                          
                                      }
                                      return resultBlock(YES, message,data);
                                  }
                                  failure:^(NSError *error) {
                                      NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                                      NSDictionary *errorDict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
                                      NSString *message = [errorDict objectForKey:@"message"];
                                      //NSUInteger status = [[errorDict objectForKey:@"status"] integerValue];
                                      return resultBlock(NO, message, nil);
                                  }];
}

/***
 编辑提交司机信息
 **/
- (void)requestEditDriverInfoWith:(WLDriverInfoModel *)edit ResultBlock:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/car/driver/edit"];
    NSString *companyID = [self getCompanyID];
    NSDictionary *params = @{@"name": edit.name,
                             @"driver_id": edit.this_id,
                             @"birthday": (edit.birthday == nil)?@"":edit.birthday,
                             @"gender": [NSString stringWithFormat:@"%ld",(long)edit.gender],
                             @"mobile": edit.mobile,
                             @"province_id": (edit.province_id == nil)?@"":edit.province_id,
                             @"city_id": (edit.city_id == nil)?@"":edit.city_id,
                             @"address": (edit.address == nil)?@"":edit.address,
                             @"id_card": (edit.id_card == nil)?@"":edit.id_card,
                             @"driving_license": (edit.driving_license == nil)?@"":edit.driving_license,
                             @"body_name": (edit.body_name == nil)?@"":edit.body_name,
                             @"memo": (edit.memo == nil)?@"":edit.memo,
                             @"company_id": companyID};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      if (status == 200) {
                                          
                                          return resultBlock(YES, message);
                                          
                                      }
                                      return resultBlock(YES, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO, message);
                                  }];
}

- (NSString *)getCurrentTime
{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyyMMddHHmmss";
    NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
    return str1;
}

/***
 新增司机信息
 **/
- (void)requestAddDriverInfoWith:(WLDriverInfoModel *)edit ResultBlock:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/car/driver/add"];
    
    NSString *userID = [self getUserID];
    NSString *companyID = [self getCompanyID];
    
    NSDictionary *params = @{@"name": edit.name,
                             @"birthday": (edit.birthday == nil)?@"":edit.birthday,
                             @"gender": @1,//[NSString stringWithFormat:@"%f",edit.gender],
                             @"mobile": edit.mobile,
                             @"province_id": (edit.province_id == nil)?@"":edit.province_id,
                             @"city_id": (edit.city_id == nil)?@"":edit.city_id,
                             @"address": (edit.address == nil)?@"":edit.address,
                             @"id_card": (edit.id_card == nil)?@"":edit.id_card,
                             @"driving_license": (edit.driving_license == nil)?@"":edit.driving_license,
                             @"body_name": (edit.body_name == nil)?@"":edit.body_name,
                             @"memo": (edit.memo == nil)?@"":edit.memo,
                             @"user_id": userID,
                             @"company_id": companyID};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            if (edit.IDFrontImg) {
                NSData *data1 = UIImageJPEGRepresentation(edit.IDFrontImg, 0.8);
                NSString *fileName1 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data1 name:@"identity1" fileName:fileName1 mimeType:@"image/jpeg"];
            }
            if (edit.IDBackImg) {
                NSData *data2 = UIImageJPEGRepresentation(edit.IDBackImg, 0.8);
                NSString *fileName2 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data2 name:@"identity2" fileName:fileName2 mimeType:@"image/jpeg"];
            }
            if (edit.cardIDFrontImg) {
                NSData *data3 = UIImageJPEGRepresentation(edit.cardIDFrontImg, 0.8);
                NSString *fileName3 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data3 name:@"driverimg1" fileName:fileName3 mimeType:@"image/jpeg"];
            }
            if (edit.cardIDBackImg) {
                NSData *data4 = UIImageJPEGRepresentation(edit.cardIDBackImg, 0.8);
                NSString *fileName4 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
                [formData appendPartWithFileData:data4 name:@"driverimg2" fileName:fileName4 mimeType:@"image/jpeg"];
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                NSString *message = [dict objectForKey:@"message"];
                if (status == 200) {
                    
                    return resultBlock(YES, message);
                    
                }
                return resultBlock(YES, @"提交失败");
            });
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSString *message = [WLNetworkTool getFailureMessageWithError:error];

            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(NO, message);
            });
            
            
        }];
        
    });
}

- (void)requesteditImgDriverInfoWith:(NSString *)driverId fileid:(NSString *)fileid type:(NSString *)type changeImg:(UIImage *)image ResultBlock:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *url = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/car/driver/optphoto"];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"driver_id"] = driverId;
    params[@"type"] = @"2";
    params[@"file_id"] = fileid;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
            NSData *data1 = UIImageJPEGRepresentation(image, 0.8);
            NSString *fileName1 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
            //NSString *fileName1 = [NSString stringWithFormat:@"picture"];
            [formData appendPartWithFileData:data1 name:[NSString stringWithFormat:@"%@",type] fileName:fileName1 mimeType:@"image/jpeg"];
            
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            WlLog(@"%@",responseObject);
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            return resultBlock(YES,dict[@"message"]);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSString *message = [WLNetworkTool getFailureMessageWithError:error];
            return resultBlock(YES,message);
        }];
        
    });
}


//应用首页接口
- (void)requestCompanyListWithDataBlock:(CompletionDataBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:ApplicationHomeURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
//                                      WlLog(@"responseObject %@",responseObject);
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSArray *data = [dict objectForKey:@"data"];
                                      NSMutableArray *objectArr = [NSMutableArray array];
                                      if (status == 200) {
                                          if (!([dict objectForKey:@"data"] == [NSNull null])) {
                                              for (NSDictionary *dict in data) {
                                                  WL_Copmany_Model *object = [[WL_Copmany_Model alloc] initWithDict:dict];
                                                  [objectArr addObject:object];
                                              }
                                              return block(WLResponseTypeSuccess, objectArr.copy, message);
                                          }
                                        
                                          
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}
#pragma mark 订单列表
- (void)requestOrderListWithType:(NSString *)type nextUrl:(NSString *)nextUrl dataBlock:(CompletionDataBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverOrderListURL];
    
    NSDictionary *params = @{@"type": type};
    
    
    if (nextUrl) {
        urlString = nextUrl;
        params = nil;
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
//                                      WlLog(@"responseObject %@",responseObject);
                                    
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          WLDriverOrderListObject *object = [[WLDriverOrderListObject alloc] initWithDict:data];
                                          return block(WLResponseTypeSuccess, object, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}
- (void)updateDriveCityWith:(NSString *)company_id province:(NSString *)province_id city:(NSString *)city_id resultBlock:(StatusBlock)block
{
   NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverUpdateCityURL];
    
    NSDictionary *params = @{ @"company_id": company_id,
                              @"province_id":province_id,
                              @"city_id":city_id,
                              };
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      if (status == 200) {
                                          return block(WLResponseTypeSuccess,200,message);
                                      }
                                  } failure:^(NSError *error) {
                                      return block(WLResponseTypeServerError,-1,error.description);
                                  }];
}
#pragma mark - 设置接单参数
- (void)setAcceptOrderParasWithCarID:(NSString *)car_id
                        Is_reception:(BOOL)is_reception
                    Reception_lowest:(NSString *)reception_lowest
                         statusBlock:(StatusBlock)block
{

    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverSettingOrderURL];
    NSDictionary *params = @{
                             @"id": car_id,
                             @"is_reception":@(is_reception),
                             @"reception_lowest":reception_lowest
                             };
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          return block(WLResponseTypeSuccess,200,message);
                                      }else
                                      {
                                          return block(WLResponseTypeSuccess,400,message);
                                      }
                                  } failure:^(NSError *error) {
                                      return block(WLResponseTypeNoNetwork,500,error.description);
                                  }];
}
#pragma mark - 竞价验证
- (void)bidCheckOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID  statusBlock:(StatusBlock)block
{
    

    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverBidCheckOrderURL];
    NSDictionary *params = @{
                             @"sj_order_id": orderID,
                             };

    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          return block(WLResponseTypeSuccess,200,[[dict objectForKey:@"data"] objectForKey:@"count"]);
                                      }else
                                      {
                                          return block(WLResponseTypeSuccess,400,message);
                                      }
                                  } failure:^(NSError *error) {
                                      NSString *mess = [WLNetworkTool getFailureMessageWithError:error];
                                      return block(WLResponseTypeSuccess,400,mess);
//                                      if(status == 400)
//                                      {
//                                        return block(WLResponseTypeSuccess,400,[WLNetworkTool getFailureStatusWithError:error]);
//                                      }
//                                      return block(WLResponseTypeNoNetwork,500,error.description);
                                  }];
}
#pragma mark - 竞价
- (void)bidOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID andBid_price:(NSString *)bid_price  Cost_memo:(NSString *)cost_memo statusBlock:(StatusBlock)block
{
   
    
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverBidOrderURL];
    NSDictionary *params = @{ @"sj_order_id": orderID,
                              @"bid_price" :bid_price,
                              @"cost_memo" :cost_memo
                              };
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                            
                                      if (status == 200) {
                                          return block(WLResponseTypeSuccess,200,nil);
                                      }else
                                      {
                                         return block(WLResponseTypeSuccess,400,message);
                                      }
                                  } failure:^(NSError *error) {
                                      
                                      NSString *mess = [WLNetworkTool getFailureMessageWithError:error];
                                      return block(WLResponseTypeSuccess,400,mess);
                                      
                                  }];
}
/**< 抢单 */
- (void)bookOrderWithOrderID:(NSString *)orderID companyID:(NSString *)companyID statusBlock:(StatusBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverBookOrderURL];
    
    NSDictionary *params = @{ @"order_id": orderID,
                              @"company_id":companyID
                             };
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
//                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          return block(WLResponseTypeSuccess,[[data objectForKey:@"id"] integerValue],[data objectForKey:@"note"]);
                                      }
                                  } failure:^(NSError *error) {
                                      return block(WLResponseTypeNoNetwork,500,error.description);
                                  }];
}
#pragma mark - 订单详情
- (void)requestOrderDetailWithOrderID:(NSString *)orderID dataBlock:(CompletionDataBlock)block
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:[NSString stringWithFormat:@"%@/%@",DriverOrderDetailURL,orderID]];


    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
//                                      WlLog(@"responseObject %@",responseObject);
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          WLDriverOrderObject *object = [WLDriverOrderObject mj_objectWithKeyValues:data];
                                          
                                          object.orderID = [data objectForKey:@"id"];
                                          object.companyName = [[data objectForKey:@"company"] objectForKey:@"name"];
                                          return block(WLResponseTypeSuccess, object, message);
                                          
                                      }
                                      return block(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return block(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

/**
 接单或拒单
 
 @param orderID 订单号
 @param orderOperation 接单传@“1”，拒单传@“2”
 @param block
 */
- (void)modifyOrderStatusWithOrderID:(NSString *)orderID orderOperation:(NSString *)orderOperation refuseReason:(NSString *)reason tripOperation:(NSString *)tripOperation money:(NSString *)money operationBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [[WLNetworkTool getBaseUrl] stringByAppendingString:DriverModifyOrderURL];
    urlString = [urlString stringByAppendingFormat:@"/%@",orderID];
    NSString *accessToken = [self getAccessToken];
    urlString = [urlString stringByAppendingFormat:@"?access-token=%@",accessToken];
    
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (orderOperation) {
        [params setObject:orderOperation forKey:@"reception_status"];
    }
    if (reason) {
        [params setObject:reason forKey:@"revoke_reason"];
    }
    if (tripOperation) {
        [params setObject:tripOperation forKey:@"trip_status"];
    }
    if (money) {
        [params setObject:money forKey:@"customer_pay_amount"];
    }
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePatch
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          WLDriverOrderObject *object = [WLDriverOrderObject mj_objectWithKeyValues:data];
                                          object.orderID = [data objectForKey:@"id"];
                                          return dataBlock(WLResponseTypeSuccess, object, message);
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
//                                      WlLog(@"error.description %@",error.description);
                                      
                                      return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

- (void)modifyOrderStatusWithOrderID:(NSString *)orderID orderOperation:(NSString *)orderOperation refuseReason:(NSString *)reason dataBlock:(CompletionDataBlock)block
{
    
    [self modifyOrderStatusWithOrderID:orderID orderOperation:orderOperation refuseReason:reason tripOperation:nil money:nil operationBlock:block];
}
/**
 出发或结束
 
 @param orderID 订单号
 @param tripOperation 出发传@“1”，结束传@“2”
 @param money 客户支付金额
 @param block
 */
- (void)modifyOrderStatusWithOrderID:(NSString *)orderID tripOperation:(NSString *)tripOperation money:(NSString *)money dataBlock:(CompletionDataBlock)block
{
    [self modifyOrderStatusWithOrderID:orderID orderOperation:nil refuseReason:nil tripOperation:tripOperation money:money operationBlock:block];
}
#pragma mark - 删除所有失效订单
- (void)deleteOutOfDateOrderListWithOperationBlock:(OperationBlock)operationBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverDeleteOrderURL];

    [WLNetworkTool requestWithRequestType:WLRequestTypeDelete
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
//                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          
                                          return operationBlock(WLResponseTypeSuccess, YES, message);
                                      }
                                      return operationBlock(WLResponseTypeSuccess, NO, message);
                                  }
                                  failure:^(NSError *error) {
                                      return operationBlock(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

- (void)requestDriverBillListWithType:(NSString *)type dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverBillListURL];
    
    NSDictionary *params = @{@"type": type};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          
                                          if (!([dict objectForKey:@"data"] == [NSNull null])) {
                                              NSArray *data = [dict objectForKey:@"data"];
                                              
                                              NSMutableArray *objectArray = [NSMutableArray array];
                                              for (NSDictionary *dict in data) {
                                                  WLDriverBillListObject *object = [[WLDriverBillListObject alloc] initWithDict:dict];
                                                  [objectArray addObject:object];
                                              }
                                              
                                              return dataBlock(WLResponseTypeSuccess, [objectArray copy], message);
                                          }
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

- (void)requestDriverBillStatisticsWithDataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:DriverBillStatisURL];
    
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {

                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          WLDriverBillStatisticsObject *object = [[WLDriverBillStatisticsObject alloc] initWithDict:data];
                                          return dataBlock(WLResponseTypeSuccess, object, message);
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                  }];
}

//  获取个人资料
- (void)requestUserInfoWithDataBlock:(CompletionDataBlock)dataBlock
{
//    NSString *urlString = [MessageBaseURL stringByAppendingString:@"v1/personal/personal"];
//    
//    NSString *accessToken = [self getAccessToken];
//    
//    urlString = [urlString stringByAppendingFormat:@"?access-token=%@",accessToken];
    
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/personal"];

    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          return dataBlock(WLResponseTypeSuccess, data, message);
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return dataBlock(WLResponseTypeNoNetwork, nil, nil);
                                  }];
}

- (void)requestQRcodeWithDataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/qrcode"];
    [WLNetworkTool requestWithRequestType:WLRequestTypeGet
                                      url:urlString
                                   params:nil
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      NSDictionary *data = [dict objectForKey:@"data"];
                                      if (status == 200) {
                                          return dataBlock(WLResponseTypeSuccess, data, message);
                                          
                                      }
                                      return dataBlock(WLResponseTypeSuccess, nil, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return dataBlock(WLResponseTypeNoNetwork, nil, message);
                                  }];
}

- (void)requestChangePersonalInfoWith:(NSDictionary *)params iSEmail:(BOOL)isemail ResultBlock:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *urlString = [[NSString alloc] init];
    
    if (isemail) {
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/set-email"];
    }
    else
    {
        urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/set-personal"];
    }

    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];

                                      if (status == 200) {
                                          
                                          return resultBlock(YES, message);
                                          
                                      }
                                      return resultBlock(YES, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(NO, message);
                                  }];
}

- (void)requestFeedBackWith:(NSString *)contentStr ResultBlock:(void (^)(BOOL, NSInteger, NSString *))resultBlock
{
    NSString *urlString = [[NSString alloc] init];
    

    urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/opinion-feedback/add"];

    NSDictionary *params = @{@"device_type": @"4",
                             @"content":contentStr};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      WlLog(@"意见结果==%@",responseObject);
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          
                                          return resultBlock(WLResponseTypeSuccess,status, message);
                                          
                                      }
                                      return resultBlock(WLResponseTypeSuccess,status, message);
                                  }
                                  failure:^(NSError *error) {
                                      NSString *message = [WLNetworkTool getFailureMessageWithError:error];
                                      return resultBlock(WLResponseTypeNoNetwork,0, message);
                                  }];
}

/***个人资料上传头像步骤1**/
- (void)sengheadImgWithData:(UIImage *)Img block:(void (^)(BOOL, NSString *, NSString *))resultBlock
{
    //NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/avatar-upload?fileparam=picture"];
    
    NSString *url = [[WLNetworkTool getBaseUrl] stringByAppendingFormat:@"v1/personal/avatar-upload?fileparam=picture"];
    NSString *accessToken = [WLUserTools getAccessToken];
    url = [url stringByAppendingFormat:@"&access-token=%@",accessToken];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 60;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
            
        NSData *data1 = UIImageJPEGRepresentation(Img, 0.8);
        NSString *fileName1 = [NSString stringWithFormat:@"%@.jpg",[self getCurrentTime]];
        //NSString *fileName1 = [NSString stringWithFormat:@"picture"];
        [formData appendPartWithFileData:data1 name:@"picture" fileName:fileName1 mimeType:@"image/jpeg"];

            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            //WlLog(@"%@",responseObject);
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSString * baseurl = dict[@"data"][@"files"][0][@"base_url"];
            NSString * path = dict[@"data"][@"files"][0][@"path"];
            
            return resultBlock(YES,baseurl,path);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            NSString *message = [WLNetworkTool getFailureMessageWithError:error];
            WlLog(@"%@",message);
            return resultBlock(YES,nil,nil);
        }];
        
    });
}

/***个人资料上传头像步骤2**/
- (void)sengheadImgAgainWithData:(NSString *)baseurl path:(NSString *)patt block:(void (^)(BOOL, NSString *))resultBlock
{
    NSString *urlString = [WLNetworkTool getAuthenticationUrlStringWithActionString:@"/personal/set-avatar-url"];
    
    NSDictionary *params = @{@"base_url": baseurl,
                             @"path": patt};
    
    [WLNetworkTool requestWithRequestType:WLRequestTypePost
                                      url:urlString
                                   params:params
                                  success:^(id responseObject) {
                                      NSDictionary *dict = (NSDictionary *)responseObject;
                                      NSUInteger status = [[dict objectForKey:@"status"] integerValue];
                                      NSString *message = [dict objectForKey:@"message"];
                                      
                                      if (status == 200) {
                                          
                                          return resultBlock(YES, message);
                                          
                                      }
                                      return resultBlock(YES, message);
                                  }
                                  failure:^(NSError *error) {
                                      
                                      return resultBlock(NO, nil);
                                  }];
}


@end
