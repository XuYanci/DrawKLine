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


+ (void)sendTokenRequest:(NSString *)appid
               secretKey:(NSString *)secretKey
                callback:(Callback)callback;

+ (void)sendQuoteDynaRequest:(NSString *)obj
                       field:(NSString*)field
                      output:(NSString *)output
                    callback:(Callback)callback;

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

+ (void)sendQuoteTickRequest:(NSString *)obj
                       field:(NSString *)field
                      output:(NSString *)output
                  begin_time:(NSString *)begin_time
                     endtime:(NSString *)endtime
                       start:(NSString *)start
                       count:(NSString *)count
                    callback:(Callback)callback;


+ (void)sendQuoteMinRequest:(NSString *)obj
                      field:(NSString *)field
                     output:(NSString *)output
                 begin_time:(NSString *)begin_time
                    endtime:(NSString *)endtime
                      start:(NSString *)start
                      count:(NSString *)count
                     prefix:(NSString *)prefix
                   callback:(Callback)callback;


@end
