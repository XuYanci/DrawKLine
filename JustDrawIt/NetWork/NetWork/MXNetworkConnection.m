//
//  MXNetworkConnection.m
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXNetworkConnection.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "NSString+JSONCategories.h"
#import "MXBaseUrl.h"


@implementation MXNetworkConnection

+ (void)sendPostRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(1,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(0,nil);
    }];
}

+ (void)sendGetRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(1,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(0,nil);
        }
    }];
}

+ (void)sendPostRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
 
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    // Default DES-Encrypt value
    NSMutableDictionary *encryptParameters = [NSMutableDictionary dictionary];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *desEncryptObj =  [des encryptWithText:obj theKey:DES_PRIVATE_KEY];
        [encryptParameters setObject:desEncryptObj forKey:key];
    }];
  
    [manager POST:[MXBaseUrl baseUrl:method] parameters:encryptParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       dispatch_async(dispatch_get_main_queue(), ^{
           // Default DES-DeEncrypt , JSON
           NSData *responseData = (NSData *)responseObject;
           NSString *utf8String = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
           NSString *decodeDesString = [des decryptWithText:utf8String theKey:DES_PRIVATE_KEY];
           callback(1,[decodeDesString JSONValue]);
           //DDLogDebug(@"POST REQUEST CALLBACK, Method %@ , params %@ , reponse %@",method,parameters,[decodeDesString JSONValue]);
       });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(0,nil);
          dispatch_async(dispatch_get_main_queue(), ^{
              //DDLogDebug(@"POST REQUEST CALLBACK, Method %@ , params %@ , reponse %@",method,parameters,error.description);
          });
    }];
}

+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters callback:(Callback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
  
    // Default DES-Encrypt value
    NSMutableDictionary *encryptParameters = [NSMutableDictionary dictionary];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *desEncryptObj = [des encryptWithText:key theKey:DES_PRIVATE_KEY];
        [encryptParameters setObject:desEncryptObj forKey:key];
    }];
    
    
    [manager GET:[MXBaseUrl baseUrlWithParams:method params:parameters] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
              dispatch_async(dispatch_get_main_queue(), ^{
             // Default DES-DeEncrypt, JSON
            NSData *responseData = (NSData *)responseObject;
            NSString *utf8String = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            NSString *decodeDesString = [des decryptWithText:utf8String theKey:DES_PRIVATE_KEY];
            
            callback(1,[decodeDesString JSONValue]);
            //DDLogDebug(@"GET REQUEST CALLBACK, Method %@ , params %@ , reponse %@",method,parameters,[decodeDesString JSONValue]);
                  });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
             dispatch_async(dispatch_get_main_queue(), ^{
            callback(0,nil);
            //DDLogDebug(@"GET REQUEST CALLBACK, Method %@ , params %@ , reponse %@",method,parameters,error.description);
                     });
        }
    }];
}

@end
