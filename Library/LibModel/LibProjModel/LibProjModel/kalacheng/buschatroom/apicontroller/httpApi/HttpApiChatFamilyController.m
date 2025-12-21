//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiChatFamilyController.h"




@implementation HttpApiChatFamilyController



/**
 用户申请加入聊天家族
 @param applyReason 申请原因
 @param familyId 家族id
 */
+(void) applyJoinFamily:(NSString *)applyReason familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/applyJoinFamily",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"applyReason":applyReason
,@"familyId":@(familyId)};

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
 获取我的家族的信息
 */
+(void) getMyChatFamilyInfoVO:(CallBackChatFamilyController_AppHomeMyAllFamilyVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getMyChatFamilyInfoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppHomeMyAllFamilyVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppHomeMyAllFamilyVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 设置用户在家族中的角色
 @param familyId 家族id
 @param familyRole  家族角色 1：族长 2：副族长 3：长老 4：成员
 @param userId 用户id
 */
+(void) upUserFamilyRole:(int64_t)familyId familyRole:(int)familyRole userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/upUserFamilyRole",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"familyRole":@(familyRole)
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
 添加或删除家族禁言
 @param familyId 家族id
 @param optType 操作类型 1：禁言 2：解禁
 @param userId 用户id
 */
+(void) addOrDelMuteUser:(int64_t)familyId optType:(int)optType userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/addOrDelMuteUser",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"optType":@(optType)
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
 查询家族内部排名
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 @param queryType 查询类型 1：贡献榜 2：收益榜
 */
+(void) getAppFamilyUserRankVO:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackChatFamilyController_AppFamilyUserRankVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppFamilyUserRankVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
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
                    AppFamilyUserRankVOModel *handle = [AppFamilyUserRankVOModel getFromDict:dic];
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
 获取聊天广场总人数
 */
+(void) getChatPlazaTotalNumber:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getChatPlazaTotalNumber",nil];
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
 创建家族
 @param applyReason 申请原因
 @param familyCity 家族所在城市
 @param familyDescription 家族描述
 @param familyIcon 家族图标
 @param familyName 家族名称
 @param latitude 家族所在纬度
 @param longitude 家族所在经度
 */
+(void) addChatFamily:(NSString *)applyReason familyCity:(NSString *)familyCity familyDescription:(NSString *)familyDescription familyIcon:(NSString *)familyIcon familyName:(NSString *)familyName latitude:(double)latitude longitude:(double)longitude  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/addChatFamily",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"applyReason":applyReason
,@"familyCity":familyCity
,@"familyDescription":familyDescription
,@"familyIcon":familyIcon
,@"familyName":familyName
,@"latitude":@(latitude)
,@"longitude":@(longitude)};

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
 获取举报类型列表
 */
+(void) getChatFamilyAppealType:(CallBackChatFamilyController_AppChatFamilyAppealTypeVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getChatFamilyAppealType",nil];
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
                    AppChatFamilyAppealTypeVOModel *handle = [AppChatFamilyAppealTypeVOModel getFromDict:dic];
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
 申请解散聊天家族
 @param disbandReason 解散原因
 @param familyId 家族id
 */
+(void) applyDisbandFamily:(NSString *)disbandReason familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/applyDisbandFamily",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"disbandReason":disbandReason
,@"familyId":@(familyId)};

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
 获取我的家族的基本信息
 @param familyId 家族id（-1：查所有）
 @param userId 用户id
 */
+(void) getAppMyChatFamilyBasisInfoVO:(int64_t)familyId userId:(int64_t)userId  callback:(CallBackChatFamilyController_AppMyChatFamilyBasisInfoVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppMyChatFamilyBasisInfoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"userId":@(userId)};

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
                    AppMyChatFamilyBasisInfoVOModel *handle = [AppMyChatFamilyBasisInfoVOModel getFromDict:dic];
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
 获取聊天广场列表
 */
+(void) getAppHomeChatPlazaVO:(CallBackChatFamilyController_AppHomeChatPlazaVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppHomeChatPlazaVO",nil];
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
                    AppHomeChatPlazaVOModel *handle = [AppHomeChatPlazaVOModel getFromDict:dic];
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
 修改家族公告
 @param familyId 家族id
 @param familyProclamation 家族公告
 */
+(void) upChatFamilyProclamation:(int64_t)familyId familyProclamation:(NSString *)familyProclamation  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/upChatFamilyProclamation",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"familyProclamation":familyProclamation};

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
 修改聊天家族信息
 @param familyDescription 家族描述
 @param familyIcon 家族图标
 @param familyId 家族id
 @param familyName 家族名称
 */
+(void) upChatFamilyInfo:(NSString *)familyDescription familyIcon:(NSString *)familyIcon familyId:(int64_t)familyId familyName:(NSString *)familyName  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/upChatFamilyInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyDescription":familyDescription
,@"familyIcon":familyIcon
,@"familyId":@(familyId)
,@"familyName":familyName};

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
 用户添加聊天家族举报
 @param chatFamilyAppealDescription 家族举报描述
 @param chatFamilyAppealImages 家族举报图片
 @param chatFamilyAppealTypeId 家族举报类型id
 @param chatFamilyAppealTypeName 家族举报类型名称
 @param familyId 家族id
 */
+(void) addFamilyAppeal:(NSString *)chatFamilyAppealDescription chatFamilyAppealImages:(NSString *)chatFamilyAppealImages chatFamilyAppealTypeId:(int64_t)chatFamilyAppealTypeId chatFamilyAppealTypeName:(NSString *)chatFamilyAppealTypeName familyId:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/addFamilyAppeal",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"chatFamilyAppealDescription":chatFamilyAppealDescription
,@"chatFamilyAppealImages":chatFamilyAppealImages
,@"chatFamilyAppealTypeId":@(chatFamilyAppealTypeId)
,@"chatFamilyAppealTypeName":chatFamilyAppealTypeName
,@"familyId":@(familyId)};

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
 是否可以创建家族
 */
+(void) isAllowedChatFamily:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/isAllowedChatFamily",nil];
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
 家族禁言列表
 @param familyId 家族id
 */
+(void) getAppChatFamilyMuteVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppChatFamilyMuteVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppChatFamilyMuteVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)};

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
                    AppChatFamilyMuteVOModel *handle = [AppChatFamilyMuteVOModel getFromDict:dic];
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
 用户离开聊天家族
 @param familyId 家族id
 */
+(void) userLeaveFamily:(int64_t)familyId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/userLeaveFamily",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)};

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
 查看我与对方在家族中的操作信息
 @param familyId 家族id
 @param toUserId 被查看人用户id
 */
+(void) getAppChatFamilyOptIntoVO:(int64_t)familyId toUserId:(int64_t)toUserId  callback:(CallBackChatFamilyController_AppChatFamilyOptIntoVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppChatFamilyOptIntoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"toUserId":@(toUserId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppChatFamilyOptIntoVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppChatFamilyOptIntoVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 家族踢人
 @param familyId 家族id
 @param userId 被踢用户id
 */
+(void) familyKick:(int64_t)familyId userId:(int64_t)userId  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/familyKick",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
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
 获取聊天家族成员列表
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getFamilyUserList:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackChatFamilyController_AppHomeFamilyUserVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getFamilyUserList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"pageIndex":@(pageIndex)
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
                    AppHomeFamilyUserVOModel *handle = [AppHomeFamilyUserVOModel getFromDict:dic];
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
 获取聊天室首页信息
 @param familyId 家族id
 */
+(void) getAppFamilyChatroomInfoVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppFamilyChatroomInfoVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppFamilyChatroomInfoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppFamilyChatroomInfoVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppFamilyChatroomInfoVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取某一个聊天家族的信息
 @param familyId 家族id
 */
+(void) getHomeChatFamilyInfoVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppHomeChatFamilyInfoVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getHomeChatFamilyInfoVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppHomeChatFamilyInfoVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppHomeChatFamilyInfoVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取家族公告
 @param familyId 家族id
 */
+(void) getAppChatFamilyProclamationVO:(int64_t)familyId  callback:(CallBackChatFamilyController_AppChatFamily)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getAppChatFamilyProclamationVO",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppChatFamilyModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppChatFamilyModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取聊天家族待审核列表
 @param familyId 家族id
 @param pageIndex 页数
 @param pageSize 每页条数
 */
+(void) getPendingCheckUserList:(int64_t)familyId pageIndex:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackChatFamilyController_AppHomeFamilyUserVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getPendingCheckUserList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"pageIndex":@(pageIndex)
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
                    AppHomeFamilyUserVOModel *handle = [AppHomeFamilyUserVOModel getFromDict:dic];
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
 族长审核 用户加入聊天家族
 @param familyId 家族id
 @param userId 被审核的用户id
 @param userStatus 审核状态 1：同意加入 -1：拒绝加入
 */
+(void) joinFamilyCheck:(int64_t)familyId userId:(int64_t)userId userStatus:(int64_t)userStatus  callback:(CallBackChatFamilyController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/joinFamilyCheck",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"userId":@(userId)
,@"userStatus":@(userStatus)};

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
 查询家族首页
 @param city 城市（类型为1时传）
 @param latitude 家族所在纬度
 @param longitude 家族所在经度
 @param pageIndex 页数
 @param pageSize 每页条数
 @param queryType 查询类型 1：同城 2：附近 3：日榜 4：周榜 5：月榜 6：总榜
 */
+(void) getHomeChatFamilyList:(NSString *)city latitude:(double)latitude longitude:(double)longitude pageIndex:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackChatFamilyController_AppHomeChatFamilyVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatFamily/getHomeChatFamilyList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"city":city
,@"latitude":@(latitude)
,@"longitude":@(longitude)
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
                    AppHomeChatFamilyVOModel *handle = [AppHomeChatFamilyVOModel getFromDict:dic];
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


