//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiChatRoomController.h"




@implementation HttpApiChatRoomController



/**
 1V1发消息,code1成功2余额不足3贵族才能发消息
 @param content 文件或者网址
 @param groupId groupId
 @param msgCid msgCid
 @param msgType 1：文本 2：单张图片 3：语音 4：语音视频通话 5：发送礼物 6：红包 7:求赏
 @param touid 对方用户id
 @param voiceTime voiceTime
 */
+(void) sendChatMsg:(NSString *)content groupId:(int64_t)groupId msgCid:(int64_t)msgCid msgType:(int)msgType touid:(int64_t)touid voiceTime:(int)voiceTime  callback:(CallBackChatRoomController_SingleString)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatRoom/sendChatMsg",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"content":content
,@"groupId":@(groupId)
,@"msgCid":@(msgCid)
,@"msgType":@(msgType)
,@"touid":@(touid)
,@"voiceTime":@(voiceTime)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        SingleStringModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [SingleStringModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 消息-获取常用语标签, 私聊扣费提示语
 @param chatType 聊天室类型： 1：私聊 2：群聊
 @param toUserId 对方用户id
 */
+(void) getCommonWordsList:(int)chatType toUserId:(int64_t)toUserId  callback:(CallBackChatRoomController_CommonTipsDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatRoom/getCommonWordsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"chatType":@(chatType)
,@"toUserId":@(toUserId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        CommonTipsDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [CommonTipsDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 1V1文字聊天数据展示
 @param userId 对方用户id
 */
+(void) oooSendMsgText:(int64_t)userId  callback:(CallBackChatRoomController_OOOLiveTextChatData)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatRoom/oooSendMsgText",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"userId":@(userId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        OOOLiveTextChatDataModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [OOOLiveTextChatDataModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


