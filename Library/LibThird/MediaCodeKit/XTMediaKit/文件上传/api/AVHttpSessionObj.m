//
//  AVHttpSessionObj.m
//  XTMedisKit
//
//  Created by shirley on 2019/9/9.
//  Copyright © 2019 XTY. All rights reserved.
//

#import "AVHttpSessionObj.h"
#import "AVIphoneInfo.h"
#import "XTMediaManager.h"

@implementation AVHttpSessionObj

+ (void)uploadInfoWithScene:(int)scene successBlock:(nonnull void (^)(BOOL, NSString * _Nonnull, NSDictionary * _Nonnull))block{
    
    Class<XTMediaConfig> config = [XTMediaManager share].config;
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",[config baseUrl],@"/api/three/getUploadInfo"];
    [AVHttpSessionObj requestSession:requestUrl param:@{@"scene":@(scene)} userId:[config userId] userToken:[config userToken] complete:^(BOOL success, NSDictionary * _Nullable info) {
        block?block(success,info[@"token"],info):nil;
    }];
}


+ (void)requestSession:(NSString *)url param:(NSDictionary *)param userId:(int64_t)uid userToken:(NSString *)utoken complete:(void (^)(BOOL, NSDictionary * _Nullable))complete
{
    
    //    NSMutableDictionary *muParam = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [muParam addEntriesFromDictionary:param];
    //    [muParam setObject:@(uid) forKey:@"_uid_"];
    //    [muParam setObject:utoken forKey:@"_token_"];
    //    [muParam setObject:[AVHttpSessionObj getOS] forKey:@"_OS_"];
    //    [muParam setObject:[AVHttpSessionObj getOSV] forKey:@"_OSV_"];
    //    [muParam setObject:[AVHttpSessionObj getOSInfo] forKey:@"_OSInfo_"];
    //
    //    NSMutableArray *mutablePairs = [NSMutableArray array];
    //    for (NSString *keys in muParam.allKeys) {
    //        [mutablePairs addObject:[NSString stringWithFormat:@"%@=%@",keys,muParam[keys]]];
    //    }
    //    NSString *query = [mutablePairs componentsJoinedByString:@"&"];
    //
    //    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    //    request.HTTPMethod = @"POST";
    //    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; // 设置请求体(json类型)
    //    request.HTTPBody = [query dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSArray *dictPara = @[param];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictPara options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *strUrl=[NSString stringWithFormat:@"%@?_uid_=%lld&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",url,uid,utoken,[AVHttpSessionObj urlEncode:[AVHttpSessionObj getOS]],[AVHttpSessionObj urlEncode:[AVHttpSessionObj getOSV]],[AVHttpSessionObj urlEncode:[AVHttpSessionObj getOSInfo]],nil];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; // 设置请求体(json类型)
    request.HTTPBody = jsonData;
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        
        if (data && (error == nil)) {
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (responseObject!=nil &&  [responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *resultDic = (NSDictionary *)responseObject;
                
                if ([resultDic[@"code"] intValue] == 1 && [resultDic[@"retObj"] isKindOfClass:[NSDictionary class]]) {
                    if (complete) {
                        complete(YES,resultDic[@"retObj"]);
                    }
                }else{
                   // NSLog(@"过滤文字[XTMediaKit] 获取token %@"),resultDic[@"msg"]);
                    if (complete) {
                        complete(NO, nil);
                    }
                }
            }else{
               // NSLog(@"过滤文字[XTMediaKit] 获取token为NULL"));
                if (complete) {
                    complete(NO, nil);
                }
            }
        } else {
           // NSLog(@"过滤文字[XTMediaKit] 获取token失败 %@"),error.localizedFailureReason);
            if (complete) {
                complete(NO, nil);
            }
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}


+ (NSString *)convertToJsonData:(NSDictionary *)param{
    if (param.count == 0) {
        return @"";
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (NSString *)getOS{
    return [@"ios" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

+ (NSString *)getOSV{
    return [[AVIphoneInfo phoneType] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

+ (NSString *)getOSInfo{
    NSDictionary *info = @{@"ip":[AVIphoneInfo ipAddress]};
    NSString *param =  [self convertToJsonData:info];
    return [param stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
}

+ (NSString *)urlEncode:(NSString *)text{
    return [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
}

@end
