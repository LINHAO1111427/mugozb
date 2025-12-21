//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiHttpVoice.h"




@implementation HttpApiHttpVoice



/**
 开关麦
 @param onOffState 麦克风状态(目标值) 0:关麦 1:开麦(音量)
 @param roomId 直播间ID
 */
+(void) offVolumn:(int)onOffState roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/offVolumn",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"onOffState":@(onOffState)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVoiceAssistanModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVoiceAssistanModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 http方式关播
 @param roomId 房间id
 */
+(void) closeVoiceLive:(int64_t)roomId  callback:(CallBackHttpVoice_ApiCloseLive)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/closeVoiceLive",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiCloseLiveModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiCloseLiveModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}





/**
 http方式创建房间code为3时请先认证
 @param addr 主播地址
 @param channelId 频道ID
 @param city 市
 @param lat 纬度
 @param lng 经度
 @param pull 直播云推/拉流地址
 @param roomType 房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 房间模式对应的值 密码房间：密码  收费房间：收费金额
 @param title 开播标题
 @param upStatus 自动上麦状态 1:开 0:关
 */
+(void) openVoiceLive:(HttpVoice_openVoiceLive*)_mdl callback:(CallBackHttpVoice_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/openVoiceLive",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"addr":_mdl.addr
,@"channelId":@(_mdl.channelId)
,@"city":_mdl.city
,@"lat":@(_mdl.lat)
,@"lng":@(_mdl.lng)
,@"pull":_mdl.pull
,@"roomType":@(_mdl.roomType)
,@"roomTypeVal":_mdl.roomTypeVal
,@"title":_mdl.title
,@"upStatus":@(_mdl.upStatus)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppJoinRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppJoinRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

/**
 http方式创建房间code为3时请先认证
 @param addr 主播地址
 @param channelId 频道ID
 @param city 市
 @param lat 纬度
 @param lng 经度
 @param pull 直播云推/拉流地址
 @param roomType 房间模式 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 房间模式对应的值 密码房间：密码  收费房间：收费金额
 @param title 开播标题
 @param upStatus 自动上麦状态 1:开 0:关
 */
+(void) openVoiceLive:(NSString *)addr channelId:(int64_t)channelId city:(NSString *)city lat:(double)lat lng:(double)lng pull:(NSString *)pull roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal title:(NSString *)title upStatus:(int)upStatus  callback:(CallBackHttpVoice_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/openVoiceLive",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"addr":addr
,@"channelId":@(channelId)
,@"city":city
,@"lat":@(lat)
,@"lng":@(lng)
,@"pull":pull
,@"roomType":@(roomType)
,@"roomTypeVal":roomTypeVal
,@"title":title
,@"upStatus":@(upStatus)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppJoinRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppJoinRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 null
 @param isAuto 自动上麦开关 1：打开 0：关闭
 @param roomId 房间号
 */
+(void) setAutoUpAssistant:(int)isAuto roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/setAutoUpAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"isAuto":@(isAuto)
,@"roomId":@(roomId)};

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



/**
 锁定或解锁麦位
 @param assistantNo 麦位序号
 @param retireState 封麦状态值 0封麦 1解封
 @param roomId 直播间ID
 */
+(void) lockAssistant:(int)assistantNo retireState:(int)retireState roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/lockAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"assistantNo":@(assistantNo)
,@"retireState":@(retireState)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVoiceAssistanModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVoiceAssistanModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 http方式离开房间
 @param roomId 房间id
 */
+(void) leaveVoiceRoomOpt:(int64_t)roomId  callback:(CallBackHttpVoice_ApiLeaveRoom)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/leaveVoiceRoomOpt",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiLeaveRoomModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiLeaveRoomModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取麦位上的用户信息列表
 @param roomId 直播间ID
 */
+(void) getAssistantUserInfoList:(int64_t)roomId  callback:(CallBackHttpVoice_AssistantUserInfoVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getAssistantUserInfoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AssistantUserInfoVOModel *handle = [AssistantUserInfoVOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 房主抱房间内观众（角色可以是主播也可以是用户）上麦
 @param inviteUid 被邀请上麦方ID
 @param roomId 直播间ID
 */
+(void) letUserUpAssitant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/letUserUpAssitant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"inviteUid":@(inviteUid)
,@"roomId":@(roomId)};

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



/**
 null
 @param roomId 房间号
 */
+(void) quitPK:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/quitPK",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

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



/**
 观众撤销申请上麦
 @param roomId 房间号
 */
+(void) cancelUpAssistant:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/cancelUpAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

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



/**
 null
 @param roomId 房间号
 */
+(void) getAutoUpAssistant:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getAutoUpAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

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



/**
 主播踢人
 @param roomId 直播间ID
 @param userId 被踢下麦的副播ID
 */
+(void) kickOutAssistan:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/kickOutAssistan",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"userId":@(userId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVoiceAssistanModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVoiceAssistanModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 邀请直播间内用户上麦成为副播
 @param inviteUid 被邀请方ID
 @param roomId 房间号
 */
+(void) inviteLiveUserUpAssistant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/inviteLiveUserUpAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"inviteUid":@(inviteUid)
,@"roomId":@(roomId)};

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



/**
 房主同意或拒绝申请用户上麦
 @param assistantNo 申请上的麦序（弹窗中时为-1）
 @param isAgree 是否同意申请方上麦 1是 0否
 @param roomId 多人语音直播间ID
 @param userId 申请方ID
 */
+(void) dealUpAssistantAsk:(int)assistantNo isAgree:(int)isAgree roomId:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/dealUpAssistantAsk",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"assistantNo":@(assistantNo)
,@"isAgree":@(isAgree)
,@"roomId":@(roomId)
,@"userId":@(userId)};

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



/**
 null
 @param inviteUid 邀请方用户id
 @param reply 回复邀请方房主，同意或拒绝上麦  1同意 0拒绝
 @param roomId 多人语音直播间ID
 */
+(void) replyAuthorInvt:(int64_t)inviteUid reply:(int)reply roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/replyAuthorInvt",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"inviteUid":@(inviteUid)
,@"reply":@(reply)
,@"roomId":@(roomId)};

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



/**
 null
 @param pktype PK类型 1:房间PK 2:单人Pk 3:激情团战
 @param roomID 多人语音直播间ID
 */
+(void) applyPK:(int)pktype roomID:(int64_t)roomID  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/applyPK",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pktype":@(pktype)
,@"roomID":@(roomID)};

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



/**
 下麦操作
 @param assistantNo 麦位序号
 @param roomId 直播间ID
 */
+(void) authDownAssistant:(int)assistantNo roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/authDownAssistant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"assistantNo":@(assistantNo)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVoiceAssistanModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVoiceAssistanModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取语音直播间背景图
 @param type 类型 0:多人语音 1:一对一语音
 */
+(void) voiceThumbList:(int)type  callback:(CallBackHttpVoice_AppVoiceThumbArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/voiceThumbList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AppVoiceThumbModel *handle = [AppVoiceThumbModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 http方式加入语音房间
 @param roomId 房间id
 @param roomType 房间类型 0:一般直播 1:私密直播 2:收费直播 3:计时直播 4:贵族房间
 @param roomTypeVal 如果是密码房间传入密码
 */
+(void) joinVoiceRoom:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackHttpVoice_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/joinVoiceRoom",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"roomType":@(roomType)
,@"roomTypeVal":roomTypeVal};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppJoinRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppJoinRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取直播间最新麦位
 @param roomId 房间id
 */
+(void) getNewAppJoinRoomVO:(int64_t)roomId  callback:(CallBackHttpVoice_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getNewAppJoinRoomVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppJoinRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppJoinRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 主持人回复上主持位请求
 @param agreeOrNot 是否同意 1：同意 -1：拒绝
 @param roomId 房间号
 @param userId 申请主持位的用户ID
 */
+(void) replyApplyToBePresenter:(int)agreeOrNot roomId:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/presenter/replyApplyToBePresenter",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"agreeOrNot":@(agreeOrNot)
,@"roomId":@(roomId)
,@"userId":@(userId)};

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



/**
 麦位用户禁麦(禁止说话)/麦位用户取消禁麦(允许说话)
 @param presenterUserId 不知道什么id不要使用
 @param roomId 房间号
 @param touid 被禁止说话人id
 */
+(void) addNoTalking:(int64_t)presenterUserId roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/addNoTalking",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"presenterUserId":@(presenterUserId)
,@"roomId":@(roomId)
,@"touid":@(touid)};

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



/**
 null
 @param roomId 多人语音直播间ID
 @param strickerId 表情包Id
 */
+(void) sendSticker:(int64_t)roomId strickerId:(int64_t)strickerId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/sendSticker",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"strickerId":@(strickerId)};

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



/**
 获取直播间数据
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) getApiJoinRoom:(int)liveType roomId:(int64_t)roomId  callback:(CallBackHttpVoice_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getApiJoinRoom",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppJoinRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppJoinRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 修改直播间背景图
 @param roomId 房间号
 @param voiceThumbId 背景图Id
 */
+(void) updateLiveBackground:(int64_t)roomId voiceThumbId:(int64_t)voiceThumbId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/updateLiveBackground",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"voiceThumbId":@(voiceThumbId)};

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



/**
 邀请直播间外主播上麦成为副播
 @param inviteUid 被邀请方ID
 @param roomId 房间号
 */
+(void) inviteUserUpAssitant:(int64_t)inviteUid roomId:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/inviteUserUpAssitant",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"inviteUid":@(inviteUid)
,@"roomId":@(roomId)};

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



/**
 下主持位
 @param roomId 房间号
 */
+(void) downPresenter:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/presenter/downPresenter",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

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



/**
 上主持位
 @param roomId 房间号
 */
+(void) applyToBePresenter:(int64_t)roomId  callback:(CallBackHttpVoice_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/presenter/applyToBePresenter",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

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



/**
 默认直接上麦，当房间主播设置开关需审核才能上麦时，点击上麦的用户进入申请列表等待,主播可在待审核列表同意指定的观众进入直播间0:观众申请上麦发送成功 1:观众上麦操作成功 2:主播ID不一致 3:麦位数据有误
 @param assistantNo 麦位序号  -1时为弹窗功能的申请上麦，不能指定上的麦序
 @param roomId 直播间ID
 */
+(void) authUpAssistan:(int)assistantNo roomId:(int64_t)roomId  callback:(CallBackHttpVoice_ApiUsersVoiceAssistan)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/authUpAssistan",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"assistantNo":@(assistantNo)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVoiceAssistanModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVoiceAssistanModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 查看申请上麦(主播尚未同意的)列表
 @param roomId 直播间ID
 */
+(void) getWaitingUsers:(int64_t)roomId  callback:(CallBackHttpVoice_ApiLineVoiceArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getWaitingUsers",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    ApiLineVoiceModel *handle = [ApiLineVoiceModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 null
 @param role 搜索的角色类型 0:普通用户 1:主播
 @param roomId 房间号
 */
+(void) enableInvtVoice:(int)role roomId:(int64_t)roomId  callback:(CallBackHttpVoice_AppUserDtoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/enableInvtVoice",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"role":@(role)
,@"roomId":@(roomId)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AppUserDtoModel *handle = [AppUserDtoModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 null
 */
+(void) getStrickerList:(CallBackHttpVoice_AppStrickerArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httpvoice/getStrickerList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AppStrickerModel *handle = [AppStrickerModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


