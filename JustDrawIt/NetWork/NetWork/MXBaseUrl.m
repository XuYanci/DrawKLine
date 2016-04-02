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
             @"min"  :          YUNDZH_URL_LINK(YUNDZH_URL_PREFIX, YUNDZH_URL_PATH_MIN),
            };
}

+ (NSString *)baseUrl:(NSString *)method {
    NSString *url = [[self UrlMethodMapper]objectForKey:method];
    return url;
}

+ (NSString *)baseUrlWithParams:(NSString *)method params:(NSDictionary *)params {
    __block NSString *url = [[self UrlMethodMapper]objectForKey:method];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        url = [url stringByAppendingFormat:@"&%@=%@",(NSString *)key,[[des encryptWithText:(NSString *)obj theKey:DES_PRIVATE_KEY]URLEncodedString]];
    }];
   
    
    url = [url stringByAppendingFormat:@"&aid=%@",[[des encryptWithText:@"1" theKey:DES_PRIVATE_KEY]URLEncodedString ]];
    url = [url stringByAppendingFormat:@"&t=%@",[[des encryptWithText:[NSString stringWithFormat:@"%ld",(long)[[NSDate date]timeIntervalSince1970]] theKey:DES_PRIVATE_KEY]URLEncodedString]];
    return url;
}


@end
