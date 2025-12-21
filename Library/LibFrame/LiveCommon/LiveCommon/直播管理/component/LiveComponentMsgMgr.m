//
//  LiveComponentMsgMgr.m
//  TCDemo
//
//  Created by shirley on 2019/9/27.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveComponentMsgMgr.h"

static NSMutableDictionary *_klcCompMsgMgr = nil;

@implementation LiveComponentMsgMgr


+(void) addMsgListener:(id<LiveComponentMsgListener>)listener
{
    if (listener == nil) {
        return;
    }
    if(_klcCompMsgMgr==nil)
    {
        _klcCompMsgMgr=[[NSMutableDictionary alloc]init];
    }
    [_klcCompMsgMgr setObject:listener forKey:NSStringFromClass([listener class])];
}
+(void) removeMsgListener:(id<LiveComponentMsgListener>)listener
{
    if(_klcCompMsgMgr!=nil)
    {
        [_klcCompMsgMgr removeObjectForKey:NSStringFromClass([listener class])];
    }
}

+ (void)sendMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic
{
    if(_klcCompMsgMgr==nil)
    {
        return ;
    }
    [_klcCompMsgMgr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id<LiveComponentMsgListener>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(onMsg:msgDic:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [obj onMsg:msgType msgDic:msgDic];
            });
        }
    }];
}

+ (void)sendMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic later:(int)seconds{

    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf sendMsg:msgType msgDic:msgDic];
    });
    
}

+ (void)removeAllListener{
    [_klcCompMsgMgr removeAllObjects];
}


+ (NSDictionary *)allListener{
    
    return [NSDictionary dictionaryWithDictionary:_klcCompMsgMgr];
}

@end
