//
//  NetImageCache.m
//  LibProjView
//
//  Created by admin on 2020/5/8.
//  Copyright © 2020 . All rights reserved.
//

#import "NetDataCache.h"
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjBase/ProjectCache.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibTools/LibTools.h>

static NetDataCache *_imgCache = nil;

@interface NetDataCache ()

@property (nonatomic, copy)NSBlockOperation *queue;

@end


@implementation NetDataCache

+ (instancetype)manager{
    if (!_imgCache) {
        _imgCache = [[NetDataCache alloc] init];
    }
    return _imgCache;
}


+ (void)downloadAll{
}


+ (void)downloadGiftImage{
    [[NetDataCache manager] loadGiftList];
}

+ (void)downloadLevelIcon{
    
}

+ (void)downLoadMedalIcon{
    
}



- (NSBlockOperation *)queue{
    if (!_queue) {
        _queue = [NSBlockOperation blockOperationWithBlock:^{
           // NSLog(@"过滤文字～～～～～～开始缓存数据～～～～～～"));
        }];
        [_queue setCompletionBlock:^{
           // NSLog(@"过滤文字～～～～～～完成缓存数据～～～～～～"));
        }];
    }
    return _queue;
}





- (void)loadGiftList{
    if (![self.queue isFinished]) {
        kWeakSelf(self);
        [HttpApiNobLiveGift getGiftList:-1 callback:^(int code, NSString *strMsg, NSArray<ApiNobLiveGiftModel *> *arr) {
            if (code == 1) {
                [arr enumerateObjectsUsingBlock:^(ApiNobLiveGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj.giftList enumerateObjectsUsingBlock:^(NobLiveGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [weakself.queue addExecutionBlock:^{
                            if (obj.swf.length > 0) {
                                [ProjectCache cacheFileWithFilePath:obj.swf finishHandle:^(NSData * _Nullable data, BOOL success) {
                                }];
                            }
                        }];
                    }];
                }];
                [weakself.queue start];
            }
        }];
    }
}

@end
