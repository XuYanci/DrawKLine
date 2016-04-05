//
//  MXBaseUrl.h
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+OAURLEncodingAdditions.h"
#import "des.h"
 
/*! DES KEY */
#define DES_PRIVATE_KEY                  @"123456"


///////////////////////////// MACRO /////////////////////////////////

/*! url拼接*/
#define YUNDZH_URL_LINK(prefix , suffix)  [NSString stringWithFormat:@"%@%@",prefix,suffix]

///////////////////////////// SERVER URL /////////////////////////////////
/*! 服务器url前缀*/
#define YUNDZH_URL_PREFIX                 @"https://v2.yundzh.com"

///////////////////////////// TOKEN /////////////////////////////////
/*! 远程获取令牌 */
#define YUNDZH_URL_PATH_TOKEN            @"/token/access"

///////////////////////////// 行情服务 /////////////////////////////////
/*! 动态详情 */
#define YUNDZH_URL_PATH_DYNA             @"/quote/dyna"

/*! K线服务 */
#define YUNDZH_URL_PATH_KLINE            @"/quote/kline"

/*! 分笔详情 */
#define YUNDZH_URL_PATH_TICK             @"/quote/tick"

/*! 分时走势 */
#define YUNDZH_URL_PATH_MIN              @"/quote/min"

/* ! 大行情 */
/* ! 键盘宝 */
/* ! 排序 */
 

@interface MXBaseUrl : NSObject

/**
 根据method获取URL字符串
 @param method 方法名称
 @return URL字符串
 */
+ (NSString *)baseUrl:(NSString *)method;
/**
 根据method获取URL字符串
 @param method 方法名称
 @param params 参数,这里指的是Get请求键值对,这里只支持字符串
 @return URL字符串
 */
+ (NSString *)baseUrlWithParams:(NSString *)method params:(NSDictionary *)params;
@end
