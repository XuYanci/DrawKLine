//
//  MXRequest.h
//  Maxer
//
//  Created by XuYanci on 15/4/29.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXNetworkConnection.h"
#import "NSMutableDictionary+SetObject.h"

@interface MXRequest : NSObject
+ (void)sendPostRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters callback:(Callback)callback;
@end
