//
//  MXRequest+WisdomFinancialInformationCloud.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "MXRequest+WisdomFinancialInformationCloud.h"

@implementation MXRequest (WisdomFinancialInformationCloud)

+ (void)sendTokenRequest:(NSString *)appid
               secretKey:(NSString *)secretKey
                callback:(Callback)callback {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObjectIfExists:appid forKey:@"appid"];
    [parameters setObjectIfExists:secretKey forKey:@"secret_key"];
    [self sendGetRequestWithMethod:@"token" parameters:parameters callback:callback];
}

+ (void)sendQuoteDynaRequest:(NSString *)obj
                       field:(NSString*)field
                      output:(NSString *)output
                       token:(NSString *)token
                    callback:(Callback)callback {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObjectIfExists:obj forKey:@"obj"];
    [parameters setObjectIfExists:field forKey:@"field"];
    [parameters setObjectIfExists:output forKey:@"output"];
    [parameters setObjectIfExists:token forKey:@"token"];
    [self sendGetRequestWithMethod:@"quote_dyna" parameters:parameters callback:callback];
}

+ (void)sendQuoteKlineRequest:(NSString *)obj
                       period:(NSString *)period
                        field:(NSString *)field
                       output:(NSString *)output
                   begin_time:(NSString *)begin_time
                      endtime:(NSString *)endtime
                        start:(NSString *)start
                        count:(NSString *)count
                        split:(NSString *)split
                     callback:(Callback)callback {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObjectIfExists:obj forKey:@"obj"];
    [parameters setObjectIfExists:period forKey:@"period"];
    [parameters setObjectIfExists:field forKey:@"field"];
    [parameters setObjectIfExists:output forKey:@"output"];
    [parameters setObjectIfExists:begin_time forKey:@"begin_time"];
    [parameters setObjectIfExists:endtime forKey:@"endtime"];
    [parameters setObjectIfExists:start forKey:@"start"];
    [parameters setObjectIfExists:count forKey:@"count"];
    [parameters setObjectIfExists:split forKey:@"split"];
    [self sendGetRequestWithMethod:@"quote_kline" parameters:parameters callback:callback];
}

+ (void)sendQuoteTickRequest:(NSString *)obj
                       field:(NSString *)field
                      output:(NSString *)output
                  begin_time:(NSString *)begin_time
                     endtime:(NSString *)endtime
                       start:(NSString *)start
                       count:(NSString *)count
                    callback:(Callback)callback {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObjectIfExists:obj forKey:@"obj"];
    [parameters setObjectIfExists:field forKey:@"field"];
    [parameters setObjectIfExists:output forKey:@"output"];
    [parameters setObjectIfExists:begin_time forKey:@"begin_time"];
    [parameters setObjectIfExists:endtime forKey:@"endtime"];
    [parameters setObjectIfExists:start forKey:@"start"];
    [parameters setObjectIfExists:count forKey:@"count"];
    [self sendGetRequestWithMethod:@"quote_tick" parameters:parameters callback:callback];
}


+ (void)sendQuoteMinRequest:(NSString *)obj
                      field:(NSString *)field
                     output:(NSString *)output
                 begin_time:(NSString *)begin_time
                    endtime:(NSString *)endtime
                      start:(NSString *)start
                      count:(NSString *)count
                     prefix:(NSString *)prefix
                      token:(NSString *)token
                   callback:(Callback)callback {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObjectIfExists:obj forKey:@"obj"];
    [parameters setObjectIfExists:field forKey:@"field"];
    [parameters setObjectIfExists:output forKey:@"output"];
    [parameters setObjectIfExists:begin_time forKey:@"begin_time"];
    [parameters setObjectIfExists:endtime forKey:@"endtime"];
    [parameters setObjectIfExists:start forKey:@"start"];
    [parameters setObjectIfExists:count forKey:@"count"];
    [parameters setObjectIfExists:prefix forKey:@"prefix"];
    [parameters setObjectIfExists:token forKey:@"token"];
    [self sendGetRequestWithMethod:@"quote_min" parameters:parameters callback:callback];
}


@end
