//
//  MXBaseUrl.m
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXBaseUrl.h"

@implementation MXBaseUrl

+ (NSDictionary *)UrlMethodMapper {
    return @{
             @"token"   : YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_TOKEN),
             @"quote_dyna" :    YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_DYNA),
             @"quote_kline" :   YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_KLINE),
             @"tick" :          YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_TICK),
             @"quote_min"  :          YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_MIN),
            };
}

+ (NSString *)baseUrl:(NSString *)method {
    NSString *url = [[self UrlMethodMapper]objectForKey:method];
    return url;
}

+ (NSString *)baseUrlWithParams:(NSString *)method params:(NSDictionary *)params {
    __block NSString *url = [[self UrlMethodMapper]objectForKey:method];
    
    __block BOOL isFirstParam = true;
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (isFirstParam) {
            url = [url stringByAppendingFormat:@"?%@=%@",(NSString *)key,obj];
            isFirstParam = false;
        }
        else
            url = [url stringByAppendingFormat:@"&%@=%@",(NSString *)key,obj];
    }];
   
    return url;
}


@end
