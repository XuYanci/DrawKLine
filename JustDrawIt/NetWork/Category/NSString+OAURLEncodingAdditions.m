//
//  NSString+OAURLEncodingAdditions.m
//  Maxer
//
//  Created by XuYanci on 15/4/30.
//  Copyright (c) 2015年 XuYanci. All rights reserved.
//

#import "NSString+OAURLEncodingAdditions.h"

@implementation NSString (OAURLEncodingAdditions)
- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString {
    NSString *result =  (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL,  kCFStringEncodingUTF8));
    return result;
}
@end
