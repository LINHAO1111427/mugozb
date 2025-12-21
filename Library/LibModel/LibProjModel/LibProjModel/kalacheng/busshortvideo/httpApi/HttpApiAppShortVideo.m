//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiAppShortVideo.h"




@implementation HttpApiAppShortVideo



/**
 查看单个短视频
 @param commentId 评论id(通知列表的commentId)没有则传-1
 @param shortVideoId 短视频id
 @param type 来源 -1:查看详情 1:消息评论 2:消息点赞
 */
+(void) getShortVideoInfoList:(int)commentId shortVideoId:(int64_t)shortVideoId type:(int)type  callback:(CallBackAppShortVideo_ApiShortVideoDtoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoInfoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"commentId":@(commentId)
,@"shortVideoId":@(shortVideoId)
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
                    ApiShortVideoDtoModel *handle = [ApiShortVideoDtoModel getFromDict:dic];
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
 删除短视频
 @param shortVideoId 短视频id
 */
+(void) delShortVideo:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/delShortVideo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoId":@(shortVideoId)};

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
 短视频评论列表
 @param page 页数
 @param pageSize 每页的条数
 @param shortVideoId 短视频id
 */
+(void) getShortVideoCommentBasicInfo:(int)page pageSize:(int)pageSize shortVideoId:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_ApiShortVideoCommentsPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoCommentBasicInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"page":@(page)
,@"pageSize":@(pageSize)
,@"shortVideoId":@(shortVideoId)};

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
                    ApiShortVideoCommentsModel *handle = [ApiShortVideoCommentsModel getFromDict:dic];
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
 短视频点赞/取消
 @param shortVideoId 短视频id
 */
+(void) shortVideoZan:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/shortVideoZan",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoId":@(shortVideoId)};

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
 某个人/自己发的作品、点赞的作品、购买的作品
 @param pageSize 每页的条数
 @param toUid 对方用户ID（传-1查询自己的）
 */
+(void) getUserShortVideoList:(int)pageSize toUid:(int64_t)toUid  callback:(CallBackAppShortVideo_ApiMyShortVideo)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getUserShortVideoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pageSize":@(pageSize)
,@"toUid":@(toUid)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiMyShortVideoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiMyShortVideoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 添加短视频举报信息
 @param shortVideoAppealDescription 短视频举报描述
 @param shortVideoAppealImages 短视频举报图片
 @param shortVideoAppealTypeId 短视频举报分类id
 @param shortVideoAppealTypeName 短视频举报分类名称
 @param shortVideoId 被举报的短视频id
 */
+(void) addShortVideoAppeal:(NSString *)shortVideoAppealDescription shortVideoAppealImages:(NSString *)shortVideoAppealImages shortVideoAppealTypeId:(int64_t)shortVideoAppealTypeId shortVideoAppealTypeName:(NSString *)shortVideoAppealTypeName shortVideoId:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/addShortVideoAppeal",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoAppealDescription":shortVideoAppealDescription
,@"shortVideoAppealImages":shortVideoAppealImages
,@"shortVideoAppealTypeId":@(shortVideoAppealTypeId)
,@"shortVideoAppealTypeName":shortVideoAppealTypeName
,@"shortVideoId":@(shortVideoId)};

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
 发布短视频code为3时请先认证
 @param address 详细地址
 @param city 城市
 @param classifyId 分类ID
 @param coin 默认0元即可， 填写金币金额
 @param content 文字内容
 @param height 封面图高
 @param href 视频地址(短视频时才传入)
 @param images 图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param productId 商品id
 @param thumb 封面图(如果是视频就取第一帧,如果是图片取第一个图片)
 @param type 类型 1:视频 2:图片
 @param videoTime 视频时长（单位秒）
 @param width 封面图宽
 */
+(void) setShortVideo:(AppShortVideo_setShortVideo*)_mdl callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/setShortVideo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":_mdl.address
,@"city":_mdl.city
,@"classifyId":_mdl.classifyId
,@"coin":@(_mdl.coin)
,@"content":_mdl.content
,@"height":@(_mdl.height)
,@"href":_mdl.href
,@"images":_mdl.images
,@"isPrivate":@(_mdl.isPrivate)
,@"lat":@(_mdl.lat)
,@"lng":@(_mdl.lng)
,@"productId":@(_mdl.productId)
,@"thumb":_mdl.thumb
,@"type":@(_mdl.type)
,@"videoTime":@(_mdl.videoTime)
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
 发布短视频code为3时请先认证
 @param address 详细地址
 @param city 城市
 @param classifyId 分类ID
 @param coin 默认0元即可， 填写金币金额
 @param content 文字内容
 @param height 封面图高
 @param href 视频地址(短视频时才传入)
 @param images 图片（逗号拼接）
 @param isPrivate 是否私密 0：正常 1：私密
 @param lat 纬度
 @param lng 经度
 @param productId 商品id
 @param thumb 封面图(如果是视频就取第一帧,如果是图片取第一个图片)
 @param type 类型 1:视频 2:图片
 @param videoTime 视频时长（单位秒）
 @param width 封面图宽
 */
+(void) setShortVideo:(NSString *)address city:(NSString *)city classifyId:(NSString *)classifyId coin:(double)coin content:(NSString *)content height:(int)height href:(NSString *)href images:(NSString *)images isPrivate:(int)isPrivate lat:(double)lat lng:(double)lng productId:(int64_t)productId thumb:(NSString *)thumb type:(int)type videoTime:(int)videoTime width:(int)width  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/setShortVideo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"city":city
,@"classifyId":classifyId
,@"coin":@(coin)
,@"content":content
,@"height":@(height)
,@"href":href
,@"images":images
,@"isPrivate":@(isPrivate)
,@"lat":@(lat)
,@"lng":@(lng)
,@"productId":@(productId)
,@"thumb":thumb
,@"type":@(type)
,@"videoTime":@(videoTime)
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
 短视频评论/回复
 @param commentType 评论类型 1:评论 2:回复
 @param content 评论内容
 @param objId 视频/评论id
 */
+(void) shortVideoComment:(int)commentType content:(NSString *)content objId:(int64_t)objId  callback:(CallBackAppShortVideo_ApiShortVideoComments)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/shortVideoComment",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"commentType":@(commentType)
,@"content":content
,@"objId":@(objId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiShortVideoCommentsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiShortVideoCommentsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 短视频评论数量
 @param shortVideoId 短视频id
 */
+(void) getShortVideoCommentNum:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoCommentNum",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoId":@(shortVideoId)};

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
 获取短视频下一个分类
 @param currAspectId 当前分类id
 */
+(void) getNextHighlights:(int64_t)currAspectId  callback:(CallBackAppShortVideo_AppHotSort)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getNextHighlights",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"currAspectId":@(currAspectId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppHotSortModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppHotSortModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 购买短视频code 1:可以观看,2:观影次数不足,7101.余额不足
 @param shortVideoId 短视频id
 @param type 类型 -1:观看普通视频 0:观影次数购买 1:金币购买
 */
+(void) useReadShortVideoNumber:(int64_t)shortVideoId type:(int)type  callback:(CallBackAppShortVideo_ApiBaseEntity)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/useReadShortVideoNumber",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoId":@(shortVideoId)
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiBaseEntityModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiBaseEntityModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 短视频分类列表
 */
+(void) getShortVideoClassifyList:(CallBackAppShortVideo_AppHotSortArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoClassifyList",nil];
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
                    AppHotSortModel *handle = [AppHotSortModel getFromDict:dic];
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
 获取长视频分类
 */
+(void) getLongVideoClassify:(CallBackAppShortVideo_AppLongVideoClassifyVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getLongVideoClassify",nil];
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
                    AppLongVideoClassifyVOModel *handle = [AppLongVideoClassifyVOModel getFromDict:dic];
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
 长视频列表
 @param adsId 最后一个广告id(没有传-1)
 @param oneClassifyId 一级分类id
 @param page 页数
 @param pageSize 每页的条数
 @param twoClassifyId 二级级分类id
 */
+(void) getLongVideoList:(int64_t)adsId oneClassifyId:(int64_t)oneClassifyId page:(int)page pageSize:(int)pageSize twoClassifyId:(int64_t)twoClassifyId  callback:(CallBackAppShortVideo_ApiShortVideoDtoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getLongVideoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"adsId":@(adsId)
,@"oneClassifyId":@(oneClassifyId)
,@"page":@(page)
,@"pageSize":@(pageSize)
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
                    ApiShortVideoDtoModel *handle = [ApiShortVideoDtoModel getFromDict:dic];
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
 (分页)某个人/自己发的作品、点赞的作品、购买的作品
 @param page 页数
 @param pageSize 每页的条数
 @param toUid 对方用户ID（传-1查询自己的）
 @param type 类型 1:我的作品 2:我喜欢的 3:我购买的
 */
+(void) getUserShortVideoPage:(int)page pageSize:(int)pageSize toUid:(int64_t)toUid type:(int)type  callback:(CallBackAppShortVideo_ApiShortVideoDtoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getUserShortVideoPage",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"page":@(page)
,@"pageSize":@(pageSize)
,@"toUid":@(toUid)
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
                    ApiShortVideoDtoModel *handle = [ApiShortVideoDtoModel getFromDict:dic];
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
 删除短视频评论
 @param commentId 评论id
 */
+(void) delShortVideoComment:(int64_t)commentId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/delShortVideoComment",nil];
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
 增加短视频观看次数
 @param shortVideoId 短视频id
 */
+(void) addShortVideoWatchNum:(int64_t)shortVideoId  callback:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/addShortVideoWatchNum",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"shortVideoId":@(shortVideoId)};

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
 短视频首页列表、根据分类查询短视频
 @param adsId 最后一个广告id(没有传-1)
 @param classifyId 分类id(根据分类查询短视频默认传-1)
 @param page 页数
 @param pageSize 每页的条数
 @param sort 排序(-1:默认 1:最多观看 2:最多评论 3:最多点赞 4:最多付费 5:看点)
 @param type 列表类型 0:推荐 1:关注
 */
+(void) getShortVideoList:(int64_t)adsId classifyId:(int64_t)classifyId page:(int)page pageSize:(int)pageSize sort:(int)sort type:(int)type  callback:(CallBackAppShortVideo_ApiShortVideoDtoPageArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"adsId":@(adsId)
,@"classifyId":@(classifyId)
,@"page":@(page)
,@"pageSize":@(pageSize)
,@"sort":@(sort)
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
                    ApiShortVideoDtoModel *handle = [ApiShortVideoDtoModel getFromDict:dic];
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
 查看免费观影私密视频次数
 */
+(void) isReadShortVideoNumber:(CallBackAppShortVideo_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/isReadShortVideoNumber",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

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
 获取短视频举报类型
 */
+(void) getShortVideoAppealTypeList:(CallBackAppShortVideo_ShortVideoAppealTypeVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getShortVideoAppealTypeList",nil];
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
                    ShortVideoAppealTypeVOModel *handle = [ShortVideoAppealTypeVOModel getFromDict:dic];
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
 看点页面接口
 @param page 页数
 @param pageSize 每页的条数
 */
+(void) getHighlights:(int)page pageSize:(int)pageSize  callback:(CallBackAppShortVideo_ApiShortVideo)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/shortvideo/getHighlights",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"page":@(page)
,@"pageSize":@(pageSize)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiShortVideoModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiShortVideoModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


