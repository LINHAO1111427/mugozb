//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiPublicLive.h"




@implementation HttpApiPublicLive



/**
 http方式修改房间模式
 @param roomId 房间id
 @param roomType 直播类型 0:一般直播 1:私密直播 2:收费直播 3:计时直播 4:贵族房间
 @param roomTypeVal 类型值
 */
+(void) updateLiveType:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/updateLiveType",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"roomType":@(roomType)
,@"roomTypeVal":roomTypeVal};

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
 获取房间模式
 @param liveType 直播类型  1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param showId 直播标识(直播间内传,其他位置传-1)
 */
+(void) getLiveRoomType:(int)liveType showId:(NSString *)showId  callback:(CallBackPublicLive_LiveRoomTypeDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveRoomType",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"showId":showId};

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
                    LiveRoomTypeDTOModel *handle = [LiveRoomTypeDTOModel getFromDict:dic];
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
 http方式修改房间标题
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 @param roomTitle 房间标题
 */
+(void) updateLiveTitle:(int)liveType roomId:(int64_t)roomId roomTitle:(NSString *)roomTitle  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/updateLiveTitle",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"roomId":@(roomId)
,@"roomTitle":roomTitle};

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
 获取直播间管理员列表
 @param anchorId 主播用户id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLiveManagerList:(int64_t)anchorId liveType:(int)liveType  callback:(CallBackPublicLive_ApiUsersLiveManagerArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveManagerList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"liveType":@(liveType)};

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
                    ApiUsersLiveManagerModel *handle = [ApiUsersLiveManagerModel getFromDict:dic];
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
 直播间踢人操作
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被禁言人id
 */
+(void) addKick:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/addKick",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 查看直播间公告
 @param anchorId 主播ID
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLiveNotice:(int64_t)anchorId liveType:(int)liveType  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveNotice",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"liveType":@(liveType)};

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
 视频语音,门票/计时发起扣费
 @param anchorId 主播id 
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间号
 @param roomType 房间模式(暂时弃用,使用主播的) 0:普通房间 1:私密房间 2:收费房间 3:计时房间 4:贵族房间
 @param roomTypeVal 类型值
 @param showId 直播标识 
 */
+(void) startDeduction:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId roomType:(int)roomType roomTypeVal:(NSString *)roomTypeVal showId:(NSString *)showId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/startDeduction",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"liveType":@(liveType)
,@"roomId":@(roomId)
,@"roomType":@(roomType)
,@"roomTypeVal":roomTypeVal
,@"showId":showId};

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
 取消管理员
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param touid 对方用户id
 */
+(void) cancelLivemanager:(int)liveType touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/cancelLivemanager",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 直播间踢人列表
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) getKickList:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiKickArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getKickList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
                    ApiKickModel *handle = [ApiKickModel getFromDict:dic];
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
 获取直播音效包
 */
+(void) getAppLiveEffectAll:(CallBackPublicLive_AppLiveEffectVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getAppLiveEffectAll",nil];
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
                    AppLiveEffectVOModel *handle = [AppLiveEffectVOModel getFromDict:dic];
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
 主播离开房间(不是关闭直播)
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) leaveRoomTemporarily:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/leaveRoomTemporarily",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 清空房间火力值
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) clearRoomVotes:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/clearRoomVotes",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 添加管理员
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param userId 用户id
 */
+(void) addLivemanager:(int)liveType userId:(int64_t)userId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/addLivemanager",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 直播间禁言列表
 @param liveType 直播间类型 1:视频直播间 2:语音直播间
 @param roomId 房间号
 */
+(void) shutupList:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiShutUpArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/shutupList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
                    ApiShutUpModel *handle = [ApiShutUpModel getFromDict:dic];
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
 获取首页图标广告列表
 @param adsType 首页广告类型 1：图片广告 2:文字广告
 */
+(void) getLiveHomeAdsList:(int)adsType  callback:(CallBackPublicLive_LiveHomeAdsVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveHomeAdsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"adsType":@(adsType)};

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
                    LiveHomeAdsVOModel *handle = [LiveHomeAdsVOModel getFromDict:dic];
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
 查询pk时长配置
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getLivePkConfiguration:(int)liveType  callback:(CallBackPublicLive_LivePkConfigurationVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLivePkConfiguration",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)};

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
                    LivePkConfigurationVOModel *handle = [LivePkConfigurationVOModel getFromDict:dic];
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
 http方式给房间上锁/解锁
 @param liveLockStatus 房间锁的状态 1:上锁了 0:未上锁
 @param liveType 直播类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 
 @param roomId 房间id
 */
+(void) liveRoomLock:(int)liveLockStatus liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/liveRoomLock",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveLockStatus":@(liveLockStatus)
,@"liveType":@(liveType)
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
 http查看贵宾席列表
 @param anchorId 主播id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) userVIPSeatsList:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_ApiUserBasicInfoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/userVIPSeatsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"liveType":@(liveType)
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
                    ApiUserBasicInfoModel *handle = [ApiUserBasicInfoModel getFromDict:dic];
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
 获取直播间广告集合
 @param roomId 房间号
 */
+(void) getLiveRoomAdsList:(int64_t)roomId  callback:(CallBackPublicLive_LiveRoomAdsListVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveRoomAdsList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        LiveRoomAdsListVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [LiveRoomAdsListVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 直播间禁言/取消禁言操作
 @param anchorId 主播id
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被禁言人id
 */
+(void) addShutup:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/addShutup",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"liveType":@(liveType)
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
 移除踢人列表用户
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 @param touid 被踢人id
 */
+(void) delKick:(int)liveType roomId:(int64_t)roomId touid:(int64_t)touid  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/delKick",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 观众席当前用户所在排行
 @param roomId 房间号
 @param userId 当前用户id
 */
+(void) getLiveUserRank:(int64_t)roomId userId:(int64_t)userId  callback:(CallBackPublicLive_RanksDto)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveUserRank",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":@(roomId)
,@"userId":@(userId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        RanksDtoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [RanksDtoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 修改直播间公告
 @param anchorId 主播ID
 @param content 公告内容
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号
 */
+(void) updateLiveNotice:(int64_t)anchorId content:(NSString *)content liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/updateLiveNotice",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"content":content
,@"liveType":@(liveType)
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
 http购买贵宾席
 @param anchorId 主播id
 @param coin 金币 
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间号 
 */
+(void) purchaseVIPSeats:(int64_t)anchorId coin:(double)coin liveType:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_AppVIPSeats)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/purchaseVIPSeats",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorId":@(anchorId)
,@"coin":@(coin)
,@"liveType":@(liveType)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppVIPSeatsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppVIPSeatsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 http方式获取加入房间数据
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) joinRoomData:(int)liveType roomId:(int64_t)roomId  callback:(CallBackPublicLive_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/joinRoomData",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
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
 获取直播间观众列表
 @param roomId 房间号
 */
+(void) getLiveUser:(int64_t)roomId  callback:(CallBackPublicLive_ApiUserBasicInfoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveUser",nil];
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
                    ApiUserBasicInfoModel *handle = [ApiUserBasicInfoModel getFromDict:dic];
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
 获取主播的直播记录
 @param beforeDay 天数(如最近3天传3,5天传5即可,-1查所有)
 @param page 当前页
 @param pageSize 每页的条数
 */
+(void) getLiveData:(int)beforeDay page:(int)page pageSize:(int)pageSize  callback:(CallBackPublicLive_AppUsersLiveDataVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getLiveData",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"beforeDay":@(beforeDay)
,@"page":@(page)
,@"pageSize":@(pageSize)};

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
                    AppUsersLiveDataVOModel *handle = [AppUsersLiveDataVOModel getFromDict:dic];
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


