//
//  LiveComponentMsgMgr.h
//  TCDemo
//
//  Created by shirley on 2019/9/27.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveComponentMsgListener.h"


NS_ASSUME_NONNULL_BEGIN

@interface LiveComponentMsgMgr : NSObject

+ (void) addMsgListener:(id<LiveComponentMsgListener>)listener;

+ (void) removeMsgListener:(id<LiveComponentMsgListener>)listener;

+ (void) sendMsg:(NSInteger)msgType msgDic:(NSDictionary* __nullable)msgDic;

+ (void) sendMsg:(NSInteger)msgType msgDic:(NSDictionary* __nullable)msgDic later:(int)seconds;

+ (void) removeAllListener;

+ (NSDictionary *)allListener;

@end

NS_ASSUME_NONNULL_END
