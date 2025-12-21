//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiSeekPromiseController.h"




@implementation HttpApiSeekPromiseController



/**
 获取用户评分，评论，订单标签
 @param toUserId 被查询的用户id
 */
+(void) getAppShowUserPromiseOrderEvaluateVO:(int64_t)toUserId  callback:(CallBackSeekPromiseController_AppShowUserPromiseOrderEvaluateVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/getAppShowUserPromiseOrderEvaluateVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"toUserId":@(toUserId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppShowUserPromiseOrderEvaluateVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppShowUserPromiseOrderEvaluateVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 用户确认订单完成
 @param promiseOrderId 订单id
 */
+(void) seekUserConfirm:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/seekUserConfirm",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"promiseOrderId":@(promiseOrderId)};

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
 约定结束，主播确认安全离开
 @param promiseOrderId 订单id
 */
+(void) seekAnchorLeave:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/seekAnchorLeave",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"promiseOrderId":@(promiseOrderId)};

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
 获取用户进行中和待评价订单 数量
 */
+(void) getAppShowOrderNumber:(CallBackSeekPromiseController_AppShowOrderNumberVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/getAppShowOrderNumber",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppShowOrderNumberVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppShowOrderNumberVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 添加寻觅订单
 @param address 预约详细地址
 @param anchorId 主播id
 @param city 预约 市
 @param latitude 纬度
 @param longitude 经度
 @param promiseDuration 预约时长
 @param promiseStartTime 预约时间
 @param skillTypeId 技能类型id
 @param store 预约门店名称
 */
+(void) addPromiseOrder:(NSString *)address anchorId:(int64_t)anchorId city:(NSString *)city latitude:(double)latitude longitude:(double)longitude promiseDuration:(int)promiseDuration promiseStartTime:(NSString *)promiseStartTime skillTypeId:(int64_t)skillTypeId store:(NSString *)store  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/addPromiseOrder",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"address":address
,@"anchorId":@(anchorId)
,@"city":city
,@"latitude":@(latitude)
,@"longitude":@(longitude)
,@"promiseDuration":@(promiseDuration)
,@"promiseStartTime":promiseStartTime
,@"skillTypeId":@(skillTypeId)
,@"store":store};

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
 用户取消订单
 @param promiseOrderId 订单id
 @param refuseDescription 取消的描述
 @param refuseReason 取消的原因
 @param refuseTypeId 取消的类型id
 */
+(void) userCancelOrder:(int64_t)promiseOrderId refuseDescription:(NSString *)refuseDescription refuseReason:(NSString *)refuseReason refuseTypeId:(int64_t)refuseTypeId  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/userCancelOrder",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"promiseOrderId":@(promiseOrderId)
,@"refuseDescription":refuseDescription
,@"refuseReason":refuseReason
,@"refuseTypeId":@(refuseTypeId)};

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
 获取用户的订单列表
 @param pageIndex 当前页
 @param pageSize 每页页数
 @param queryType 查询类型 0：全部 1：进行中 2：待评价 3：已完结
 */
+(void) getAppShowPromiseOrderVO:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackSeekPromiseController_AppShowPromiseOrderVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/getAppShowPromiseOrderVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pageIndex":@(pageIndex)
,@"pageSize":@(pageSize)
,@"queryType":@(queryType)};

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
                    AppShowPromiseOrderVOModel *handle = [AppShowPromiseOrderVOModel getFromDict:dic];
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
 获取用户一个订单详情
 @param latitude 纬度
 @param longitude 经度
 @param promiseOrderId 订单id
 */
+(void) getAppPromiseOrderInfoVO:(double)latitude longitude:(double)longitude promiseOrderId:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_AppPromiseOrderInfoVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/getAppPromiseOrderInfoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"latitude":@(latitude)
,@"longitude":@(longitude)
,@"promiseOrderId":@(promiseOrderId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppPromiseOrderInfoVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppPromiseOrderInfoVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 主播回复
 @param anchorReply 主播回复状态 1：同意 -1：拒绝
 @param promiseOrderId 订单id
 @param refuseDescription 拒绝的描述 （同意传 空字符串）
 @param refuseReason 拒绝的原因（拒绝类型的名称）（同意传 空字符串）
 @param refuseTypeId 拒绝的类型id（同意传 0）
 */
+(void) anchorReply:(int)anchorReply promiseOrderId:(int64_t)promiseOrderId refuseDescription:(NSString *)refuseDescription refuseReason:(NSString *)refuseReason refuseTypeId:(int64_t)refuseTypeId  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/anchorReply",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"anchorReply":@(anchorReply)
,@"promiseOrderId":@(promiseOrderId)
,@"refuseDescription":refuseDescription
,@"refuseReason":refuseReason
,@"refuseTypeId":@(refuseTypeId)};

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
 用户订单评价（评分+评论+标签）
 @param orderComment 订单评论
 @param orderScore 订单评分
 @param promiseOrderId 订单id
 @param promiseOrderTagIds 寻觅订单标签id（多个用逗号隔开）
 @param toUserId 被评价的用户id
 */
+(void) addPromiseOrderEvaluate:(NSString *)orderComment orderScore:(double)orderScore promiseOrderId:(int64_t)promiseOrderId promiseOrderTagIds:(NSString *)promiseOrderTagIds toUserId:(int64_t)toUserId  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/addPromiseOrderEvaluate",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"orderComment":orderComment
,@"orderScore":@(orderScore)
,@"promiseOrderId":@(promiseOrderId)
,@"promiseOrderTagIds":promiseOrderTagIds
,@"toUserId":@(toUserId)};

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
 添加用户申诉
 @param promiseOrderId 申诉的订单id
 @param seekAppealDescription 申诉描述
 @param seekAppealImages 申诉图片(多张逗号隔开)
 @param seekAppealTypeId 申述类型id
 @param seekAppealTypeName 申述类型名称
 */
+(void) addUserAppeal:(int64_t)promiseOrderId seekAppealDescription:(NSString *)seekAppealDescription seekAppealImages:(NSString *)seekAppealImages seekAppealTypeId:(int64_t)seekAppealTypeId seekAppealTypeName:(NSString *)seekAppealTypeName  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/addUserAppeal",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"promiseOrderId":@(promiseOrderId)
,@"seekAppealDescription":seekAppealDescription
,@"seekAppealImages":seekAppealImages
,@"seekAppealTypeId":@(seekAppealTypeId)
,@"seekAppealTypeName":seekAppealTypeName};

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
 寻觅续单
 @param promiseOrderId 订单id
 @param renewalTime 续单时长（小时）
 */
+(void) orderRenewal:(int64_t)promiseOrderId renewalTime:(int)renewalTime  callback:(CallBackSeekPromiseController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/seek/orderRenewal",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"promiseOrderId":@(promiseOrderId)
,@"renewalTime":@(renewalTime)};

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


