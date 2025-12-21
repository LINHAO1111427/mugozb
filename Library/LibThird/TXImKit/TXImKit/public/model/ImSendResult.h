//
//  ImSendResult.h
//  IMSocket
//
//  Created by wy on 2020/7/14.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
 

NS_ASSUME_NONNULL_BEGIN
@import ImSDK_Plus;
@interface ImSendResult : NSObject

@property (nonatomic, assign)  int code;// 发送结果 0消息解析失败 1成功 2消息过长 3消息为空 5不能给自己发信息
@property (nonatomic, strong) NSString* err;//错误描述
@property (nonatomic, strong) V2TIMMessage* msg;//信息体
 
@end

NS_ASSUME_NONNULL_END
