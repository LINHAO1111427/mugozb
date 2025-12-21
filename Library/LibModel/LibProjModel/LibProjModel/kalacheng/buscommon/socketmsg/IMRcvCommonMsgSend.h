//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "UserSimpleInfoModel.h"
#import "AdminSendTextVOModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
公共msg socket消息Send
 */
@interface IMRcvCommonMsgSend: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 通知用户领取连续登录奖励
 @param oneFlag null
 */
-(void) onUserLoginRewards:(int)oneFlag ;


/**
 用户贵族/svip 信息
 @param userSimpleInfo null
 */
-(void) onUserSimpleInfo:(UserSimpleInfoModel* )userSimpleInfo ;


/**
 总未读数
 @param count 总未读数
 */
-(void) onUserGetNoReadAll:(int64_t)count ;


/**
 管理后台向用户发送文本消息
 @param adminSendTextVO null
 */
-(void) onAdminSendText:(AdminSendTextVOModel* )adminSendTextVO ;

@end

NS_ASSUME_NONNULL_END
