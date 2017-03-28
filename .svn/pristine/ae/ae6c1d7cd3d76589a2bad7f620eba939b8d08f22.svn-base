//
//  WLNetworkAddressBookHandler.m
//  WeiLvDJS
//
//  Created by ternence on 2017/1/12.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLNetworkAddressBookHandler.h"
#import "WL_AddressBook_OrganizationStructure_Model.h"
#import "WL_AddressBook_Organization_Title_Model.h"
#import "WL_AddressBook_Organization_Department_Model.h"

@implementation WLNetworkAddressBookHandler
+ (void)requestOrganizationStructureWithCompanyID:(NSString *)companyID
                                     departmentID:(NSString *)departmentID
                                             type:(NSString *)type
                                        dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [LoginBaseUrl stringByAppendingString:contactsOrganizationStructureURL];
    
    NSString *userID = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaUserPassword = [MyRSA encryptString:password publicKey:RSAKey];
    
    NSDictionary *params = @{@"user_id" : userID,
                             @"user_password" : rsaUserPassword,
                             @"company_id" : companyID,
                             @"department_id" : departmentID,
                             @"type" : type};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                 url:urlString
                              params:params
                             success:^(id responseObject) {
                                 
                                 
                                 WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                 
                                 if (baseModel.result.integerValue == 1) {//成功
                                     WL_AddressBook_OrganizationStructure_Model *organizationStructureModel = [WL_AddressBook_OrganizationStructure_Model mj_objectWithKeyValues:baseModel.data];
                                     return dataBlock(WLResponseTypeSuccess, organizationStructureModel, baseModel.msg);
                                     
                                 }
                                 return dataBlock(WLResponseTypeSuccess, nil,baseModel.msg);
                                 
                             }
                             failure:^(NSError *error) {
                                 
                                 if (error.code == -1009) {
                                     return dataBlock(WLResponseTypeNoNetwork, nil,nil);
                                 }
                                 
                                 return dataBlock(WLResponseTypeServerError, nil,nil);
                                 
                                 
                             }];
    
}

+ (void)requestMyPositionWithCompanyID:(NSString *)companyID dataBlock:(CompletionDataBlock)dataBlock
{
    NSString *urlString = [LoginBaseUrl stringByAppendingString:contactsOrganizationStructureURL];
    
    NSString *userID = [WLUserTools getUserId];
    NSString *password = [WLUserTools getUserPassword];
    NSString *rsaUserPassword = [MyRSA encryptString:password publicKey:RSAKey];
    
    NSDictionary *params = @{@"user_id" : userID,
                             @"user_password" : rsaUserPassword,
                             @"company_id" : companyID};
    
    [WLNetworkTool requestWithMethod:@"POST"
                                 url:urlString
                              params:params
                             success:^(id responseObject) {
                                 
                                 
                                 WL_Network_Model *baseModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
                                 
                                 if (baseModel.result.integerValue == 1) {//成功
                                     
                                     NSArray *departArray = [baseModel.data objectForKey:@"department_list"];
                                     NSArray *array = [WL_AddressBook_Organization_Department_Model mj_objectArrayWithKeyValuesArray:departArray];
                                     return dataBlock(WLResponseTypeSuccess, array, baseModel.msg);
                                     
                                 }
                                 return dataBlock(WLResponseTypeSuccess, nil, baseModel.msg);
                                 
                             }
                             failure:^(NSError *error) {
                                 
                                 if (error.code == -1009) {
                                     return dataBlock(WLResponseTypeNoNetwork, nil,nil);
                                 }
                                 
                                 return dataBlock(WLResponseTypeServerError, nil,nil);
                                 
                                 
                             }];
}
@end
