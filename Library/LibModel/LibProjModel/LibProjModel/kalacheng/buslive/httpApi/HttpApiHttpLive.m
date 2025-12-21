//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiHttpLive.h"




@implementation HttpApiHttpLive



/**
 http方式离开房间
 @param roomId 房间id
 */
+(void) leaveRoomOpt:(int64_t)roomId  callback:(CallBackHttpLive_ApiLeaveRoom)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/leaveRoomOpt",nil];
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
 主播在直播间点击PK选择可连麦的主播前端需要取的字段头像,性别,名称,等级,id
 @param keyWord 搜索主播id/名称
 */
+(void) getUsableAnchor:(NSString *)keyWord  callback:(CallBackHttpLive_ApiUsableAnchorRespArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/pk/getUsableAnchor",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"keyWord":keyWord};

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
                    ApiUsableAnchorRespModel *handle = [ApiUsableAnchorRespModel getFromDict:dic];
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
 http方式关播
 @param roomId 房间id
 */
+(void) closeLive:(int64_t)roomId  callback:(CallBackHttpLive_ApiCloseLive)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/closeLive",nil];
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
 http方式加入房间
 @param roomId 房间id
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 */
+(void) joinRoom:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackHttpLive_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/joinRoom",nil];
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
 http方式创建房间code为3时请先认证
 @param address 开播地址
 @param channelId 频道id
 @param city 市
 @param lat 经度
 @param liveFunction 是否有直播购 0:没有直播购 1:有直播购
 @param lng 纬度
 @param province 省
 @param pull 播流地址
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 @param shopRoomLabel 直播购房间标签
 @param title 开播标题
 */
+(void) openLive:(HttpLive_openLive*)_mdl callback:(CallBackHttpLive_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/openLive",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":_mdl.address
,@"channelId":@(_mdl.channelId)
,@"city":_mdl.city
,@"lat":@(_mdl.lat)
,@"liveFunction":@(_mdl.liveFunction)
,@"lng":@(_mdl.lng)
,@"province":_mdl.province
,@"pull":_mdl.pull
,@"roomType":@(_mdl.roomType)
,@"roomTypeVal":_mdl.roomTypeVal
,@"shopRoomLabel":_mdl.shopRoomLabel
,@"title":_mdl.title};

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
 @param address 开播地址
 @param channelId 频道id
 @param city 市
 @param lat 经度
 @param liveFunction 是否有直播购 0:没有直播购 1:有直播购
 @param lng 纬度
 @param province 省
 @param pull 播流地址
 @param roomType 房间类型 0:是一般直播 1:是私密直播 2:是收费直播 3:是计时直播 4:贵族房间
 @param roomTypeVal 房间类型对应的值
 @param shopRoomLabel 直播购房间标签
 @param title 开播标题
 */
+(void) openLive:(NSString *)address channelId:(int)channelId city:(NSString *)city lat:(double)lat liveFunction:(int)liveFunction lng:(double)lng province:(NSString *)province pull:(NSString *)pull roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal shopRoomLabel:(NSString *)shopRoomLabel title:(NSString *)title  callback:(CallBackHttpLive_AppJoinRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/openLive",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"channelId":@(channelId)
,@"city":city
,@"lat":@(lat)
,@"liveFunction":@(liveFunction)
,@"lng":@(lng)
,@"province":province
,@"pull":pull
,@"roomType":@(roomType)
,@"roomTypeVal":roomTypeVal
,@"shopRoomLabel":shopRoomLabel
,@"title":title};

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
 设置直播横幅
 @param roomId 房间号
 @param shopLiveBanner 横幅地址
 */
+(void) setShopLiveBanner:(int64_t)roomId shopLiveBanner:(NSString *)shopLiveBanner  callback:(CallBackHttpLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/setShopLiveBanner",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"shopLiveBanner":shopLiveBanner};

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
 app合流
 @param appOptType app操作类型 1：合流成功 2：合流失败 3：合流回调成功 4：合流回调失败 5：退出合流
 @param otherDescription 其他描述
 @param otherRoomId 对方房间号
 @param otherUserId 对方用户id
 @param roomId 操作方房间号
 */
+(void) appLiveLog:(int)appOptType otherDescription:(NSString *)otherDescription otherRoomId:(int64_t)otherRoomId otherUserId:(int64_t)otherUserId roomId:(int64_t)roomId  callback:(CallBackHttpLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/appLiveLog",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appOptType":@(appOptType)
,@"otherDescription":otherDescription
,@"otherRoomId":@(otherRoomId)
,@"otherUserId":@(otherUserId)
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


@end


