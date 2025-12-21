//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiHome.h"




@implementation HttpApiHome





/**
 首页列表数据
 @param address 地址
 @param channelId 频道ID(全部传-1)
 @param hotSortId 热门类型ID(没有传-1)
 @param isLive 是否正在直播 -1:全部 0:关播 1:开播
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param liveFunction 是否有直播购 -1:全部 0:没有 1:有
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomeDataList:(Home_getHomeDataList*)_mdl callback:(CallBackHome_AppHomeHallDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomeDataList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":_mdl.address
,@"channelId":@(_mdl.channelId)
,@"hotSortId":@(_mdl.hotSortId)
,@"isLive":@(_mdl.isLive)
,@"isRecommend":@(_mdl.isRecommend)
,@"liveFunction":@(_mdl.liveFunction)
,@"liveType":@(_mdl.liveType)
,@"pageIndex":@(_mdl.pageIndex)
,@"pageSize":@(_mdl.pageSize)
,@"sex":@(_mdl.sex)
,@"tabIds":_mdl.tabIds
,@"twoClassifyId":@(_mdl.twoClassifyId)};

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
                    AppHomeHallDTOModel *handle = [AppHomeHallDTOModel getFromDict:dic];
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
 首页列表数据
 @param address 地址
 @param channelId 频道ID(全部传-1)
 @param hotSortId 热门类型ID(没有传-1)
 @param isLive 是否正在直播 -1:全部 0:关播 1:开播
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param liveFunction 是否有直播购 -1:全部 0:没有 1:有
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomeDataList:(NSString *)address channelId:(int64_t)channelId hotSortId:(int64_t)hotSortId isLive:(int)isLive isRecommend:(int)isRecommend liveFunction:(int)liveFunction liveType:(int)liveType pageIndex:(int)pageIndex pageSize:(int)pageSize sex:(int)sex tabIds:(NSString *)tabIds twoClassifyId:(int64_t)twoClassifyId  callback:(CallBackHome_AppHomeHallDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomeDataList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"channelId":@(channelId)
,@"hotSortId":@(hotSortId)
,@"isLive":@(isLive)
,@"isRecommend":@(isRecommend)
,@"liveFunction":@(liveFunction)
,@"liveType":@(liveType)
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"sex":@(sex)
,@"tabIds":tabIds
,@"twoClassifyId":@(twoClassifyId)};

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
                    AppHomeHallDTOModel *handle = [AppHomeHallDTOModel getFromDict:dic];
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
 获取附近搜索条件
 */
+(void) getNearbySearchCondition:(CallBackHome_AppAreaArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getNearbySearchCondition",nil];
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
                    AppAreaModel *handle = [AppAreaModel getFromDict:dic];
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
 首页数据信息(单个)
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) getHomeDataInfo:(int)liveType roomId:(int64_t)roomId  callback:(CallBackHome_AppHomeHallDTO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomeDataInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppHomeHallDTOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppHomeHallDTOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 首页广场直播头部数据
 @param type 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getHomeSquareLiveHeader:(int)type  callback:(CallBackHome_HomeDto)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomeSquareLiveHeader",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        HomeDtoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [HomeDtoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取直播频道
 @param type 类型 1:直播 2:语音 3:1v1 4:电台 5:派对
 */
+(void) getLiveChannel:(int)type  callback:(CallBackHome_AppLiveChannelArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getLiveChannel",nil];
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
                    AppLiveChannelModel *handle = [AppLiveChannelModel getFromDict:dic];
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
 首页列表数据
 @param address 地址
 @param channelId 频道ID
 @param hotSortId 热门类型ID
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param lat 纬度
 @param lng 经度
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomO2ODataList:(Home_getHomO2ODataList*)_mdl callback:(CallBackHome_HomeO2ODataArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomO2ODataList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":_mdl.address
,@"channelId":@(_mdl.channelId)
,@"hotSortId":@(_mdl.hotSortId)
,@"isRecommend":@(_mdl.isRecommend)
,@"lat":@(_mdl.lat)
,@"lng":@(_mdl.lng)
,@"pageIndex":@(_mdl.pageIndex)
,@"pageSize":@(_mdl.pageSize)
,@"sex":@(_mdl.sex)
,@"tabIds":_mdl.tabIds
,@"twoClassifyId":@(_mdl.twoClassifyId)};

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
                    HomeO2ODataModel *handle = [HomeO2ODataModel getFromDict:dic];
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
 首页列表数据
 @param address 地址
 @param channelId 频道ID
 @param hotSortId 热门类型ID
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param lat 纬度
 @param lng 经度
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomO2ODataList:(NSString *)address channelId:(int64_t)channelId hotSortId:(int64_t)hotSortId isRecommend:(int)isRecommend lat:(double)lat lng:(double)lng pageIndex:(int)pageIndex pageSize:(int)pageSize sex:(int)sex tabIds:(NSString *)tabIds twoClassifyId:(int64_t)twoClassifyId  callback:(CallBackHome_HomeO2ODataArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getHomO2ODataList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"channelId":@(channelId)
,@"hotSortId":@(hotSortId)
,@"isRecommend":@(isRecommend)
,@"lat":@(lat)
,@"lng":@(lng)
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"sex":@(sex)
,@"tabIds":tabIds
,@"twoClassifyId":@(twoClassifyId)};

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
                    HomeO2ODataModel *handle = [HomeO2ODataModel getFromDict:dic];
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
 首页关注列表
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 (查全部时，传-1， 现在只支持视频、语音)
 @param page 当前页
 @param pageSize 每页的条数
 */
+(void) lobbyAttention:(int)liveType page:(int)page pageSize:(int)pageSize  callback:(CallBackHome_AppHomeHallDTOPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/lobbyAttention",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"liveType":@(liveType)
,@"page":@(page)
,@"pageSize":@(pageSize)};

 [HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
		PageInfo* pageInfo=[PageInfo new];
		[pageInfo setInfo:dicRet];
        NSMutableArray *retArr=[[NSMutableArray alloc] init];
        if(code==1)
        {
            id idArray = dicRet[@"retArr"];
            if([idArray isKindOfClass:[NSArray class]])
            {
                NSArray*  dataArray=idArray;
                for (NSDictionary *dic in dataArray) {
                    AppHomeHallDTOModel *handle = [AppHomeHallDTOModel getFromDict:dic];
                    [retArr addObject:handle];
                }
            }
        }
        callback(code,strMsg,pageInfo,retArr);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil,nil);
    }];

}



/**
 获取首页一对一搜索条件
 */
+(void) getO2OSearchCondition:(CallBackHome_SearchConditionDto)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getO2OSearchCondition",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        SearchConditionDtoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [SearchConditionDtoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}





/**
 获取正在直播的列表（某个位置的数据）
 @param channelId 频道ID(全部传-1)
 @param city 城市筛选 没有指定城市就传空字符串
 @param findType 查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:附近 9:公会
 @param guildId 公会id
 @param hotSortId 热门类型ID(没有传-1)
 @param isAttention 关注 0:不关注 1:关注
 @param isRecommend 是否推荐(如果只是查推荐数据,这里就传 1) -1:全部 0:不推荐 1:已推荐
 @param pageIndex 当前页
 @param pageSize 每页的条数
 @param roomId 当前所在房间
 */
+(void) getLiveListAtPosition:(Home_getLiveListAtPosition*)_mdl callback:(CallBackHome_SlideLiveRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getLiveListAtPosition",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"channelId":@(_mdl.channelId)
,@"city":_mdl.city
,@"findType":@(_mdl.findType)
,@"guildId":@(_mdl.guildId)
,@"hotSortId":@(_mdl.hotSortId)
,@"isAttention":@(_mdl.isAttention)
,@"isRecommend":@(_mdl.isRecommend)
,@"pageIndex":@(_mdl.pageIndex)
,@"pageSize":@(_mdl.pageSize)
,@"roomId":@(_mdl.roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        SlideLiveRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [SlideLiveRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

/**
 获取正在直播的列表（某个位置的数据）
 @param channelId 频道ID(全部传-1)
 @param city 城市筛选 没有指定城市就传空字符串
 @param findType 查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:附近 9:公会
 @param guildId 公会id
 @param hotSortId 热门类型ID(没有传-1)
 @param isAttention 关注 0:不关注 1:关注
 @param isRecommend 是否推荐(如果只是查推荐数据,这里就传 1) -1:全部 0:不推荐 1:已推荐
 @param pageIndex 当前页
 @param pageSize 每页的条数
 @param roomId 当前所在房间
 */
+(void) getLiveListAtPosition:(int64_t)channelId city:(NSString *)city findType:(int)findType guildId:(int64_t)guildId hotSortId:(int64_t)hotSortId isAttention:(int)isAttention isRecommend:(int)isRecommend pageIndex:(int)pageIndex pageSize:(int)pageSize roomId:(int64_t)roomId  callback:(CallBackHome_SlideLiveRoomVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/home/getLiveListAtPosition",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"channelId":@(channelId)
,@"city":city
,@"findType":@(findType)
,@"guildId":@(guildId)
,@"hotSortId":@(hotSortId)
,@"isAttention":@(isAttention)
,@"isRecommend":@(isRecommend)
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"roomId":@(roomId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        SlideLiveRoomVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [SlideLiveRoomVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


