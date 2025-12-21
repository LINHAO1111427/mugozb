//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiDynamicController.h"




@implementation HttpApiDynamicController



/**
 动态点赞/取消
 @param dynamicId 动态id
 */
+(void) dynamicZan:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/dynamicZan",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)};

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
 动态话题列表
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) getTopicList:(int)page pageSize:(int)pageSize  callback:(CallBackDynamicController_AppVideoTopicArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getTopicList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
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
                    AppVideoTopicModel *handle = [AppVideoTopicModel getFromDict:dic];
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
 动态添加/取消收藏（返回 1：收藏成功 -1：取消收藏）
 @param dynamicId 动态id
 */
+(void) addOrdelDynamicCollect:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/addOrdelDynamicCollect",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)};

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
 删除动态
 @param dynamicId 动态id
 */
+(void) delDynamic:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/delDynamic",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)};

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
 删除评论/回复
 @param commentId 评论id
 */
+(void) delComment:(int64_t)commentId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/delComment",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"commentId":@(commentId)};

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
 获取动态举报类型
 */
+(void) getDynamicAppealTypeList:(CallBackDynamicController_DynamicAppealTypeVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getDynamicAppealTypeList",nil];
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
                    DynamicAppealTypeVOModel *handle = [DynamicAppealTypeVOModel getFromDict:dic];
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
 发布动态(新)code为3时请先认证
 @param address 详细地址
 @param channelId 频道id
 @param city 城市
 @param coin 默认0元即可， 填写金币金额
 @param content 动态内容
 @param height 视频高
 @param hidePublishingAddress 隐藏发布位置 0:未开启 1:开启
 @param href 视频地址(视频类型时才传入)
 @param images 动态图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param musicId 音乐id
 @param sourceFrom 资源来源 1:首页发布动态 2:其他地方发布出来的动态
 @param thumb 动态封面图
 @param title 动态标题
 @param topicId 动态话题ID
 @param type 类型 0:只有文字 1:视频动态 2:图片动态
 @param videoTime 视频时长
 @param width 视频宽
 */
+(void) publishDynamic:(DynamicController_publishDynamic*)_mdl callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/publishDynamic",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":_mdl.address
,@"channelId":@(_mdl.channelId)
,@"city":_mdl.city
,@"coin":@(_mdl.coin)
,@"content":_mdl.content
,@"height":@(_mdl.height)
,@"hidePublishingAddress":@(_mdl.hidePublishingAddress)
,@"href":_mdl.href
,@"images":_mdl.images
,@"isPrivate":@(_mdl.isPrivate)
,@"lat":@(_mdl.lat)
,@"lng":@(_mdl.lng)
,@"musicId":@(_mdl.musicId)
,@"sourceFrom":@(_mdl.sourceFrom)
,@"thumb":_mdl.thumb
,@"title":_mdl.title
,@"topicId":@(_mdl.topicId)
,@"type":@(_mdl.type)
,@"videoTime":_mdl.videoTime
,@"width":@(_mdl.width)};

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
 发布动态(新)code为3时请先认证
 @param address 详细地址
 @param channelId 频道id
 @param city 城市
 @param coin 默认0元即可， 填写金币金额
 @param content 动态内容
 @param height 视频高
 @param hidePublishingAddress 隐藏发布位置 0:未开启 1:开启
 @param href 视频地址(视频类型时才传入)
 @param images 动态图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param musicId 音乐id
 @param sourceFrom 资源来源 1:首页发布动态 2:其他地方发布出来的动态
 @param thumb 动态封面图
 @param title 动态标题
 @param topicId 动态话题ID
 @param type 类型 0:只有文字 1:视频动态 2:图片动态
 @param videoTime 视频时长
 @param width 视频宽
 */
+(void) publishDynamic:(NSString *)address channelId:(int64_t)channelId city:(NSString *)city coin:(double)coin content:(NSString *)content height:(int)height hidePublishingAddress:(int)hidePublishingAddress href:(NSString *)href images:(NSString *)images isPrivate:(int)isPrivate lat:(double)lat lng:(double)lng musicId:(int64_t)musicId sourceFrom:(int)sourceFrom thumb:(NSString *)thumb title:(NSString *)title topicId:(int64_t)topicId type:(int)type videoTime:(NSString *)videoTime width:(int)width  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/publishDynamic",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"channelId":@(channelId)
,@"city":city
,@"coin":@(coin)
,@"content":content
,@"height":@(height)
,@"hidePublishingAddress":@(hidePublishingAddress)
,@"href":href
,@"images":images
,@"isPrivate":@(isPrivate)
,@"lat":@(lat)
,@"lng":@(lng)
,@"musicId":@(musicId)
,@"sourceFrom":@(sourceFrom)
,@"thumb":thumb
,@"title":title
,@"topicId":@(topicId)
,@"type":@(type)
,@"videoTime":videoTime
,@"width":@(width)};

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
 发布评论/回复
 @param commentType 评论类型1评论2回复
 @param content 评论内容
 @param objId 视频/评论id
 */
+(void) addComment:(int)commentType content:(NSString *)content objId:(int64_t)objId  callback:(CallBackDynamicController_ApiUsersVideoComments)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/addComment",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"commentType":@(commentType)
,@"content":content
,@"objId":@(objId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUsersVideoCommentsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUsersVideoCommentsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取用户非文本的动态信息（现在只有封面）
 @param toUserId 被查看者用户ID
 */
+(void) getNoTextDynamicCircle:(int64_t)toUserId  callback:(CallBackDynamicController_MyInfoDynamicCircleArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getNoTextDynamicCircle",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"toUserId":@(toUserId)};

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
                    MyInfoDynamicCircleModel *handle = [MyInfoDynamicCircleModel getFromDict:dic];
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
 查询评论个数
 @param dynamicId 动态id
 */
+(void) getCommentCount:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getCommentCount",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)};

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
 获取动态列表
 @param hotId 话题id
 @param page 页数
 @param pageSize 每页的条数
 @param touid 要查看的用户的ID(只查询这个人的动态时需要传)
 @param type 类型 0:全部 1:推荐 2:关注 3：点赞 4：收藏
 */
+(void) getDynamicList:(int64_t)hotId page:(int)page pageSize:(int)pageSize touid:(int64_t)touid type:(int)type  callback:(CallBackDynamicController_ApiUserVideoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getDynamicList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"hotId":@(hotId)
,@"page":@(page)
,@"pageSize":@(pageSize)
,@"touid":@(touid)
,@"type":@(type)};

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
                    ApiUserVideoModel *handle = [ApiUserVideoModel getFromDict:dic];
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
 搜索动态
 @param pageIndex 页数
 @param pageSize 每页的条数
 @param searchText 搜索的文字
 */
+(void) getSearchDynamicList:(int)pageIndex pageSize:(int)pageSize searchText:(NSString *)searchText  callback:(CallBackDynamicController_ApiUserVideoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getSearchDynamicList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"searchText":searchText};

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
                    ApiUserVideoModel *handle = [ApiUserVideoModel getFromDict:dic];
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
 获取动态详情
 @param commentId 评论id(通知列表的commentId)没有则传-1
 @param dynamicId 视频ID
 @param type 来源 -1:查看详情 1:消息评论 2:消息点赞
 */
+(void) getDynamicInfo:(int)commentId dynamicId:(int64_t)dynamicId type:(int)type  callback:(CallBackDynamicController_ApiUserVideo)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getDynamicInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"commentId":@(commentId)
,@"dynamicId":@(dynamicId)
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserVideoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserVideoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 动态评论列表
 @param dynamicId 动态id
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) getCommentBasicInfo:(int64_t)dynamicId page:(int)page pageSize:(int)pageSize  callback:(CallBackDynamicController_ApiUsersVideoCommentsPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/getCommentBasicInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)
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
                    ApiUsersVideoCommentsModel *handle = [ApiUsersVideoCommentsModel getFromDict:dic];
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
 添加动态举报信息
 @param dynamicAppealDescription 动态举报描述
 @param dynamicAppealImages 动态举报图片
 @param dynamicAppealTypeId 动态举报分类id
 @param dynamicAppealTypeName 动态举报分类名称
 @param dynamicId 被举报的动态id
 */
+(void) addDynamicAppeal:(NSString *)dynamicAppealDescription dynamicAppealImages:(NSString *)dynamicAppealImages dynamicAppealTypeId:(int64_t)dynamicAppealTypeId dynamicAppealTypeName:(NSString *)dynamicAppealTypeName dynamicId:(int64_t)dynamicId  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/addDynamicAppeal",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicAppealDescription":dynamicAppealDescription
,@"dynamicAppealImages":dynamicAppealImages
,@"dynamicAppealTypeId":@(dynamicAppealTypeId)
,@"dynamicAppealTypeName":dynamicAppealTypeName
,@"dynamicId":@(dynamicId)};

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
 动态置顶和取消置顶
 @param dynamicId 动态id
 @param optType 操作类型 1:个人动态置顶 2:个人动态取消置顶
 */
+(void) addDynamicPersonalTop:(int64_t)dynamicId optType:(int)optType  callback:(CallBackDynamicController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/dynamic/addDynamicPersonalTop",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"dynamicId":@(dynamicId)
,@"optType":@(optType)};

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


