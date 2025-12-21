//
//  ImDataBase.h
//  IMSocket
//
//  Created by wy on 2020/7/14.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ImMessage.h"
#import "ImSendResult.h"
#import "ImExtraInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImDataBase : NSObject

+(ImDataBase*)getIns;


-(void)closeDB;
-(void)createDB:(int64_t) uid;

 
/// 删除某个人的信息
/// @param UGID 用户群组标识
- (void)delExtraInfo:(int64_t)UGID;


/// 更新存储个人信息
/// @param ditExtraInfo 信息内容
/// @param UGID 用户群组标识
- (void)setExtraInfo:(NSDictionary*)ditExtraInfo withUGID:(int64_t)UGID;


/// 获取个人信息
/// @param UGID 用户群组标识
-(ImExtraInfo*)getExtraInfo:(int64_t)UGID;

@end

NS_ASSUME_NONNULL_END


