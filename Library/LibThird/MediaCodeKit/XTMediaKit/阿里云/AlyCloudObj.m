//
//  AlyCloudObj.m
//  XTStorageKit
//
//  Created by swh_y on 2022/5/27.
//  Copyright © 2022 . All rights reserved.
//

#import "AlyCloudObj.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
 
static AlyCloudObj *_alyCloud = nil;

@interface AlyCloudObj()
@property (nonatomic, copy)void(^completeBlock)(BOOL success);

@property (nonatomic, copy)NSString *strAccessKey;
@property (nonatomic, copy)NSString *strSecretKey;
@property (nonatomic, copy)NSString *strToken;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *endDate;
 
@end

@implementation AlyCloudObj
+ (instancetype)share{
    if (!_alyCloud) {
        _alyCloud = [[AlyCloudObj alloc] init];
    }
    return _alyCloud;
}

 
#pragma mark - QCloudSignatureProvider -
  

///初始化基本数据
- (void)alyInitParam:(NSDictionary *)param tempComplate:(void(^)(BOOL handle,OSSClient *client))tempComplate{
    NSString *zone = param[@"zone"];
    NSString *accessKey = param[@"accessKeyId"];
    NSString *secretKey = param[@"secretKeyId"];
    NSString *token = param[@"token"];
    token = [token substringFromIndex:2];
    self.strToken = token;
    self.strAccessKey = accessKey;
    self.strSecretKey = secretKey;
    if (token.length > 0) {
        id<OSSCredentialProvider> credentialProvider = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:self.strAccessKey secretKeyId:self.strSecretKey securityToken:self.strToken];
        OSSClientConfiguration *cfg = [[OSSClientConfiguration alloc] init];
        cfg.maxRetryCount = 3;
        cfg.timeoutIntervalForRequest = 15;
        cfg.isHttpdnsEnable = NO;
        cfg.crc64Verifiable = YES;
        
         
        OSSClient *defaultClient = [[OSSClient alloc] initWithEndpoint:zone credentialProvider:credentialProvider clientConfiguration:cfg];
        tempComplate?tempComplate(YES,defaultClient):nil;
    }else{
        tempComplate?tempComplate(NO,nil):nil;
    }
     
}
 
#pragma mark - 上传

+ (void)alyunUploadImage:(NSData *)imageData filename:(NSString *)filename param:(NSDictionary *)param callBack:(nonnull void (^)(BOOL success, id result))callBack{
    [[AlyCloudObj share] alyInitParam:param tempComplate:^(BOOL handle,OSSClient *client) {
        if (handle) {
            __weak NSString *bucketName = param[@"obsName"];
            __weak NSString *httpDomas = param[@"zone"];
            OSSPutObjectRequest *normalUploadRequest = [OSSPutObjectRequest new];
            normalUploadRequest.bucketName = bucketName;
            normalUploadRequest.objectKey = filename;
            normalUploadRequest.uploadingData = imageData;
            normalUploadRequest.isAuthenticationRequired = YES;
            normalUploadRequest.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
               /*
                float progress = 1.f * totalByteSent / totalBytesExpectedToSend;
               // NSLog(@"过滤文字上传文件进度: %f"), progress);
                */
                 
            };
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                OSSTask * task = [client putObject:normalUploadRequest];
                [task waitUntilFinished];
                [task continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (task.error) {
                            callBack(NO,task.error);
                        } else {
                            NSString *fileUrl = [NSString stringWithFormat:@"%@/%@",httpDomas,filename];
                            callBack(YES,fileUrl);
                        }
                    });
                    return nil;
                }];
                 
            });
        }else{
            callBack?callBack(NO, @""):nil;
        }
    }];

}
 
+ (void)alyunUploadFile:(NSString *)file filename:(NSString *)filename param:(NSDictionary *)param callBack:(nonnull void (^)(BOOL success, id result))callBack upProgress:(nonnull void (^)(CGFloat progress))progerssHander{
    [[AlyCloudObj share] alyInitParam:param tempComplate:^(BOOL handle,OSSClient *client) {
        if (handle) {
            NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            __weak NSString *bucketName = param[@"obsName"];
            __weak NSString *httpDomas = param[@"zone"];
            OSSResumableUploadRequest * resumableUpload = [OSSResumableUploadRequest new];
            resumableUpload.bucketName = bucketName;
            resumableUpload.objectKey = filename;
            resumableUpload.uploadingFileURL = [NSURL URLWithString:file];
            resumableUpload.contentType = @"application/octet-stream";  // 设置content-type
            resumableUpload.partSize = 102400;                          // 设置分片大小
            resumableUpload.recordDirectoryPath = cachesDir;            // 设置分片信息的本地存储路径
            
            // 设置metadata
            resumableUpload.completeMetaHeader = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
            
            // 设置上传进度回调
            resumableUpload.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                float progress = 1.f * totalByteSent / totalBytesExpectedToSend;
                progerssHander(progress);
            };
            OSSTask * resumeTask = [client resumableUpload:resumableUpload];
            [resumeTask waitUntilFinished];                             // 阻塞当前线程直到上传任务完成
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resumeTask.result) {
                    NSString *fileUrl = [NSString stringWithFormat:@"%@/%@",httpDomas,filename];
                    callBack(YES,fileUrl);
                } else {
                    callBack?callBack(NO, resumeTask.error):nil;
                }
            });
        }else{
            callBack?callBack(NO, @""):nil;
        }
    }];
}
@end
