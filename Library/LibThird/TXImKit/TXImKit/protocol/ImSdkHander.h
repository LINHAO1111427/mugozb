//
//  ImSdkHander.h
//  TXImKit
//
//  Created by swh_y on 2022/5/26.
//

#ifndef ImSdkHander_h
#define ImSdkHander_h

@protocol ImSdkHander <NSObject>
 
/// 链接不成功，或者成功后断开连接
/// @param msg 提示消息
-(void)onDisConnect:(NSString*)msg;



/// 网络端口连接成功
/// @param msg 提示消息
-(void)onIOConnect:(NSString*)msg;

/// 链接成功，并且登陆成功
/// @param isNewConnect 新的连接成功
-(void)onConnect:(Boolean)isNewConnect;

/// token失效
/// @param msg 提示消息
-(void)onTokenInvalid:(NSString*)msg;


/// Key失效
/// @param msg 提示消息
-(void) onKeyExpire:(NSString*)msg;


/// 数据出现错误
/// @param msg 提示消息
-(void)onDataErr:(NSString*)msg;


/// 报告会话空闲状态 如果isResetSession=YES，idleMillisecond大于30*1000毫秒，说明手机网络不好，与IM服务器断开了链接
/// @param isConnect 是否连接状态
/// @param isResetSession 是否重置连接
/// @param idleMillisecond 断链时间
-(void)onSessionIdle:(Boolean)isConnect isResetSession:(Boolean)isResetSession idleMillisecond:(int64_t)idleMillisecond;
  
@optional

@end

#endif /* IMsocketHander_h */
