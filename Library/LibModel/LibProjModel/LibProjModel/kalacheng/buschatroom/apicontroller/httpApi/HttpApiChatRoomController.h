//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "SingleStringModel.h"

#import "CommonTipsDTOModel.h"

#import "OOOLiveTextChatDataModel.h"

typedef void (^CallBackChatRoomController_SingleString)(int code,NSString *strMsg,SingleStringModel* model);
typedef void (^CallBackChatRoomController_CommonTipsDTO)(int code,NSString *strMsg,CommonTipsDTOModel* model);
typedef void (^CallBackChatRoomController_OOOLiveTextChatData)(int code,NSString *strMsg,OOOLiveTextChatDataModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
聊天室控制
 */
@interface HttpApiChatRoomController: NSObject



/**
 1V1发消息,code1成功2余额不足3贵族才能发消息
 @param content 文件或者网址
 @param groupId groupId
 @param msgCid msgCid
 @param msgType 1：文本 2：单张图片 3：语音 4：语音视频通话 5：发送礼物 6：红包 7:求赏
 @param touid 对方用户id
 @param voiceTime voiceTime
 */
+(void) sendChatMsg:(NSString *)content groupId:(int64_t)groupId msgCid:(int64_t)msgCid msgType:(int)msgType touid:(int64_t)touid voiceTime:(int)voiceTime  callback:(CallBackChatRoomController_SingleString)callback;


/**
 消息-获取常用语标签, 私聊扣费提示语
 @param chatType 聊天室类型： 1：私聊 2：群聊
 @param toUserId 对方用户id
 */
+(void) getCommonWordsList:(int)chatType toUserId:(int64_t)toUserId  callback:(CallBackChatRoomController_CommonTipsDTO)callback;


/**
 1V1文字聊天数据展示
 @param userId 对方用户id
 */
+(void) oooSendMsgText:(int64_t)userId  callback:(CallBackChatRoomController_OOOLiveTextChatData)callback;

@end

NS_ASSUME_NONNULL_END
