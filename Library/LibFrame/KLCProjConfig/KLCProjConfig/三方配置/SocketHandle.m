//
//  SocketHandle.m
//  youMengLive
//
//  Created by klc_sl on 2020/6/20.
//  Copyright © 2020 . All rights reserved.
//

#import "SocketHandle.h"
#import <LibTools/LibTools.h>

@implementation SocketHandle


//链接不成功，或者成功后断开连接
-(void)onDisConnect:(NSString*)msg{
   // NSLog(@"过滤文字####【TXImKit】####  腾讯IM断开连接"));
}

//网络端口连接成功
-(void)onIOConnect:(NSString*)msg{
   // NSLog(@"过滤文字####【TXImKit】####  腾讯IM端口连接成功"));
}

//链接成功，并且登陆成功
-(void)onConnect:(Boolean)isNewConnect{
   // NSLog(@"过滤文字####【TXImKit】####  腾讯IM链接成功，并且登陆成功 new = %d "),isNewConnect);
}

//Token无效
-(void)onTokenInvalid:(NSString*)msg{
   // NSLog(@"过滤文字####【TXImKit】####  Token无效"));
}

//Key过期了。
-(void)onKeyExpire:(NSString*)msg{
   // NSLog(@"过滤文字####【TXImKit】####  Key过期了"));
}

//数据错误，一般Key不一致导致
-(void)onDataErr:(NSString*)msg{
   // NSLog(@"过滤文字####【TXImKit】####  数据错误"));
}

///当 isResetSession =YES的时候，需要关闭直播间。 程序每2秒会调用一下这个函数 onSessionIdle
- (void)onSessionIdle:(Boolean)isConnect isResetSession:(Boolean)isResetSession idleMillisecond:(int64_t)idleMillisecond{
    if (isResetSession) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationClearUserState object:nil];
    }
}


@end
