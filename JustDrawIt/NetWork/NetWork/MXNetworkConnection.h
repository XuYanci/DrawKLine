//
//  MXNetworkConnection.h
//  Maxer
//
//  Created by XuYanci on 15/4/28.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

typedef void (^Callback)(NSInteger error,id result);

@interface MXNetworkConnection : NSObject
+ (void)sendPostRequestWithMethod:(NSString *)method parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendGetRequestWithMethod:(NSString *)method  parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendPostRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback)callback;
+ (void)sendGetRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters callback:(Callback)callback;
@end
