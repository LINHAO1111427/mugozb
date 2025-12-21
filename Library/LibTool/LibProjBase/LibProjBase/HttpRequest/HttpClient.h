//
//  TCAFNManager.h
//  AFNAndYYModel
//
//  Created by klc_tqd on 2019/8/2.
//  Copyright © 2019 klc_tqd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^success)(id dataObject);
typedef void(^failed)(int code,NSString *error);

@interface HttpClient : NSObject


+ (instancetype) manager;
+ (int64_t) getUid;
+ (NSString*) getToken;
+ (NSString*) getBaseUrl;

+ (NSString *)getOSType;
+ (NSString *)getOSVersion;
+ (NSString *)getOSInfo;


+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)string;

/// url编码
+ (NSString *)urlEncode:(NSString *)text;


+ (void)cancelRequest;

+ (void)requestPostWithPath:(NSString *)path param:(id)param success:(void (^)(id dataBody))success failed:(void (^)(int code,NSString *error))failed;

+ (void)jsonPostWithPath:(NSString *)url param:(id)param success:(void (^)(id dataBody))success failed:(void (^)(int code,NSString *error))failed;

+ (void)requestGETWithPath:(NSString *)path Param:(NSDictionary *_Nullable)param success:(void (^)(id dataBody))success failed:(void (^)(NSString *error))failed;

+ (void)downloadWithPath:(NSString *)url savePath:(NSString *)savePath progress:(void(^)(NSProgress *downloadProgress))progress success:(void(^)(NSString *path))success failed:(void (^)(NSString *error))failed;


@end

NS_ASSUME_NONNULL_END
