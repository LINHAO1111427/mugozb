//
//  NSURLSession+PLCategory.m
//  MPVideoLive
//
//  Created by klc_sl on 2020/2/24.
//  Copyright © 2020 cat. All rights reserved.
//

#import "NSURLSession+PLCategory.h"
#import <objc/runtime.h>

void swizzing(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation NSURLSession (PLCategory)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSURLSession class];
        swizzing(class, @selector(sessionWithConfiguration:), @selector(qy_sessionWithConfiguration:));

        swizzing(class, @selector(sessionWithConfiguration:delegate:delegateQueue:),
                 @selector(qy_sessionWithConfiguration:delegate:delegateQueue:));
    });
}

+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                     delegate:(nullable id<NSURLSessionDelegate>)delegate
                                delegateQueue:(nullable NSOperationQueue *)queue
{
    (!configuration)?configuration = [[NSURLSessionConfiguration alloc] init]:nil;
    configuration.connectionProxyDictionary = @{};
    return [self qy_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}

+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    configuration?configuration.connectionProxyDictionary = @{}:nil;
    return [self qy_sessionWithConfiguration:configuration];
}

@end
