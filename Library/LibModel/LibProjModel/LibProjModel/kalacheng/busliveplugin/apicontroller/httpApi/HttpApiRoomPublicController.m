//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiRoomPublicController.h"




@implementation HttpApiRoomPublicController



/**
 发送消息(视频语音一对一)
 @param anchorId 主播id,没有传0
 @param content 消息内容
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 @param type 消息类型 0:系统消息(超管) 1:是普通消息 2:弹幕消息
 */
+(void) sendMsgRoom:(int64_t)anchorId content:(NSString *)content liveType:(int)liveType roomId:(int64_t)roomId type:(int)type  callback:(CallBackRoomPublicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/sendMsgRoom",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"content":content
,@"liveType":@(liveType)
,@"roomId":@(roomId)
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HttpNoneModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HttpNoneModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


