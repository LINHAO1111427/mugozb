//
//  TCAFNManager.m
//  AFNAndYYModel
//
//  Created by klc_tqd on 2019/8/2.
//  Copyright © 2019 klc_tqd. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import <LibTools/LibTools.h>
#import "ProjConfig.h"
#import <LibTools/NSDate+Time.h>

static CGFloat const TIMEOUT = 30.f;

@implementation HttpClient

static AFHTTPSessionManager *_manager;

+ (void)initialize
{
    if (self == [HttpClient class]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = TIMEOUT;
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
}


+ (NSString *)getOSType{
    return @"ios";
}
+ (NSString *)getOSVersion{
    return [IPhoneInfo systemVersion];
}
+ (NSString *)getOSInfo{
    NSDictionary *info = @{@"ip":[IPhoneInfo ipAddress]};
    NSString *param =  [info convertToJsonData];
    return param;
}

+ (NSString *)urlEncode:(NSString *)text{
    return [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
}


+(int64_t) getUid
{
    return [ProjConfig userId];
}

+(NSString*) getToken
{
    return [ProjConfig userToken];
}

+(NSString*) getBaseUrl
{
    return [ProjConfig baseUrl];
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSString *dateString = [date timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateString.length?dateString:@"";
}

+ (NSDate *)dateFromString:(NSString *)string{
    if (![string isKindOfClass:[NSNull class]] && string.length > 0) {
        return [NSDate dateFormString:string dataFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return nil;
}

+ (instancetype)manager {
    static HttpClient *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (void)cancelRequest{
    [_manager.operationQueue cancelAllOperations];
    if ([_manager.tasks count] > 0) {
       // NSLog(@"过滤文字返回时取消网络请求"));
        [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
        //NSLog(@"过滤文字tasks = %@"),manager.tasks);
    }
}

#pragma - mark  AFN 第三方 function
//post 请求基类
+ (void)requestPostWithPath:(NSString *)path param:(id)param success:(void (^)(id dataBody))success failed:(void (^)(int code,NSString *error))failed {
    _manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [HttpClient postUrl:path param:param success:^(id  _Nonnull resultDic) {
        success(resultDic);
    } failed:^(int code, NSString * _Nonnull error) {
        failed(code, error);
    }];
}

+ (void)jsonPostWithPath:(NSString *)url param:(id)param success:(void (^)(id _Nonnull))success failed:(void (^)(int code, NSString * _Nonnull))failed{
    _manager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [HttpClient postUrl:url param:param success:^(id  _Nonnull resultDic) {
        success(resultDic);
    } failed:^(int code, NSString * _Nonnull error) {
        failed(code, error);
    }];
}


+ (void)postUrl:(NSString *)urlStr param:(id)param success:(void (^)(id _Nonnull resultDic))success failed:(void (^)(int code, NSString * _Nonnull error))failed{
   
    kWeakSelf(urlStr);
    [_manager POST:urlStr parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject!=nil &&  [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDic = (NSDictionary *)responseObject;
            int reqCode = [resultDic[@"code"] intValue];
            if (reqCode == 44003) ///token失效
            {
               // NSLog(@"过滤文字====token失效的接口===%@"),weakurlStr);
                failed(reqCode, @"");
                [HttpClient tokenInvalid];
            }
            else if (reqCode == 7001) ///账号禁用
            {
                failed(reqCode, @"");
                [HttpClient accountDisable:resultDic[@"msg"]];
            }
            else{
                success(resultDic);
            }
        }else{
            failed(44002,kLocalizationMsg(@"json解析失败！"));
           // NSLog(@"过滤文字====json解析失败的接口===%@"),weakurlStr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        failed(44001,[NSString stringWithFormat:@"%@",error]);
        if (error.code == -999) {
           // NSLog(@"过滤文字取消请求接口"));
        }else{
            failed(44001,kLocalizationMsg(@"网络请求错误"));
           // NSLog(@"过滤文字====网络请求错误的接口===%@"),weakurlStr);
        }
    }];
}


+ (void)tokenInvalid{
    [SVProgressHUD dismiss];
    [ProjConfig tokenInvalid];
    
}

+ (void)accountDisable:(NSString *)str{
    [SVProgressHUD dismiss];
    [ProjConfig accountDisabled:str];
}


//get 请求基类
+ (void)requestGETWithPath:(NSString *)path Param:(NSDictionary *)param success:(void (^)(id _Nonnull))success failed:(void (^)(NSString * _Nonnull))failed {
    
//   // NSLog(@"过滤文字\n\n************开始请求*************\n\nurl = %@\n param = %@\n\n*************************\n\n"), path, param);
    
    [_manager GET:path parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL isError = NO;
        NSError *jsonError;
        NSDictionary *resultDict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            resultDict = (NSDictionary *)responseObject;
        }else{
            resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        }
        if (!isError) {
            //           // NSLog(@"过滤文字\n\n************请求成功*************\n\nurl = %@\n\nparam = %@\n\nresponse=%@\n\n****************************\n\n"), path, param, resultDict);
            success(resultDict);
        }
        if (jsonError) {
//           // NSLog(@"过滤文字\n\n**********错误信息**********\n\njsonError=%@\n\n"), jsonError);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//       // NSLog(@"过滤文字\n\n************请求失败*************\n\nurl = %@\n\nparam = %@\n\nerror=%@\n\n****************\n\n"), path, param, error);
        success(error);
    }];
}

+ (void)downloadWithPath:(NSString *)url savePath:(NSString *)savePath progress:(void (^)(NSProgress *))progress success:(void (^)(NSString * _Nonnull))success failed:(void (^)(NSString * _Nonnull))failed{
    
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] progress:^(NSProgress * _Nonnull downloadProgress) {
        progress?progress(downloadProgress):nil;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString *armFilePath = [filePath path];// 将NSURL转成NSString
        if (!error) {
            if (success) {
                success(armFilePath);
            }
        }else{
            if (failed) {
                failed(kLocalizationMsg(@"下载失败"));
            }
        }
    }];
    [downloadTask resume];
    
}


@end
