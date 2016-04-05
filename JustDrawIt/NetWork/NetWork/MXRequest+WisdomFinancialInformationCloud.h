//
//  MXRequest+WisdomFinancialInformationCloud.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRequest.h"

/**
 *  参考大智慧金融信息云平台API手册
 *  refer link : https://www.gitbook.com/book/elsejj/dzhyun/details
 */
@interface MXRequest (WisdomFinancialInformationCloud)


/**
 *  获取AccessToken
 *
 *  @param appid     appid description
 *  @param secretKey secretKey description
 *  @param callback  callback description
 */
+ (void)sendTokenRequest:(NSString *)appid
               secretKey:(NSString *)secretKey
                callback:(Callback)callback;

/**
 *  获取动态详情
 *
 *  @param obj      obj description
 *  @param field    field description
 *  @param output   output description
 *  @param callback callback description
 *  @param token    token description
 */
+ (void)sendQuoteDynaRequest:(NSString *)obj
                       field:(NSString*)field
                      output:(NSString *)output
                       token:(NSString *)token
                    callback:(Callback)callback;

/**
 *  获取K线信息
 *
 *  @param obj        obj description
 *  @param period     period description
 *  @param field      field description
 *  @param output     output description
 *  @param begin_time begin_time description
 *  @param endtime    endtime description
 *  @param start      start description
 *  @param count      count description
 *  @param split      split description
 *  @param callback   callback description
 */
+ (void)sendQuoteKlineRequest:(NSString *)obj
                       period:(NSString *)period
                        field:(NSString *)field
                       output:(NSString *)output
                   begin_time:(NSString *)begin_time
                      endtime:(NSString *)endtime
                        start:(NSString *)start
                        count:(NSString *)count
                        split:(NSString *)split
                     callback:(Callback)callback;

/**
 *  获取分笔详情
 *
 *  @param obj        obj description
 *  @param field      field description
 *  @param output     output description
 *  @param begin_time begin_time description
 *  @param endtime    endtime description
 *  @param start      start description
 *  @param count      count description
 *  @param callback   callback description
 */
+ (void)sendQuoteTickRequest:(NSString *)obj
                       field:(NSString *)field
                      output:(NSString *)output
                  begin_time:(NSString *)begin_time
                     endtime:(NSString *)endtime
                       start:(NSString *)start
                       count:(NSString *)count
                    callback:(Callback)callback;

/**
 *  获取分时走势服务
 *
 *  @param obj        obj description
 *  @param field      field description
 *  @param output     output description
 *  @param begin_time begin_time description
 *  @param endtime    endtime description
 *  @param start      start description
 *  @param count      count description
 *  @param prefix     prefix description
 *  @param callback   callback description
 */
+ (void)sendQuoteMinRequest:(NSString *)obj
                      field:(NSString *)field
                     output:(NSString *)output
                 begin_time:(NSString *)begin_time
                    endtime:(NSString *)endtime
                      start:(NSString *)start
                      count:(NSString *)count
                     prefix:(NSString *)prefix
                      token:(NSString *)token
                   callback:(Callback)callback;


@end
