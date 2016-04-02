//
//  MXRequest.m
//  Maxer
//
//  Created by XuYanci on 15/4/29.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "MXRequest.h"
#import "MXNetworkConnection.h"

@implementation MXRequest
+ (void)sendPostRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback {
     [MXNetworkConnection sendPostRequestWithMethod:method parameters:parameters callback:callback];
}
+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters callback:(Callback)callback {
    [MXNetworkConnection sendGetRequestWithMethod:method parameters:parameters callback:callback];
}

@end
