//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiChatMsgController.h"




@implementation HttpApiChatMsgController



/**
 根据类型查询聊天通讯录的信息
 @param findType 查询类型 1:密友(相互关注的人) 2:备注(我备注过的人) 3:粉丝(关注我的人) 4:我关注的人 5:我的群组(加入的粉丝团+加入的家族)
 */
+(void) getAppBookShowInfoList:(int)findType  callback:(CallBackChatMsgController_AppBookShowInfoVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/getAppBookShowInfoList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"findType":@(findType)};

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
                    AppBookShowInfoVOModel *handle = [AppBookShowInfoVOModel getFromDict:dic];
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
 获取用户的名称，头像
 @param listUGID listUGID
 */
+(void) getImExtraInfo:(NSMutableArray<NSNumber *>* )listUGID  callback:(CallBackChatMsgController_ImExtraInfoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/chatMsg/getImExtraInfo",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSMutableArray *dictPara = listUGID;

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
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
                    ImExtraInfoModel *handle = [ImExtraInfoModel getFromDict:dic];
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
 删除消息置顶
 @param chatTopRecordId 置顶的id
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 */
+(void) delChatTopRecord:(int64_t)chatTopRecordId topPosition:(int)topPosition  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/delChatTopRecord",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"chatTopRecordId":@(chatTopRecordId)
,@"topPosition":@(topPosition)};

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
                    ChatTopRecordVOModel *handle = [ChatTopRecordVOModel getFromDict:dic];
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
 获取聊天中的置顶消息
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 */
+(void) getChatTopRecordList:(int)topPosition  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/getChatTopRecordList",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"topPosition":@(topPosition)};

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
                    ChatTopRecordVOModel *handle = [ChatTopRecordVOModel getFromDict:dic];
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
 获取通讯录中用户和群组的数量
 */
+(void) getAddressBookNumber:(CallBackChatMsgController_AppAddressBookNumberVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/getAddressBookNumber",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppAddressBookNumberVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppAddressBookNumberVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 发送聊天室置顶消息
 @param familyId 家族id
 @param topMsgContent 消息内容
 */
+(void) sendFamilyTopMsg:(int64_t)familyId topMsgContent:(NSString *)topMsgContent  callback:(CallBackChatMsgController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/sendFamilyTopMsg",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"familyId":@(familyId)
,@"topMsgContent":topMsgContent};

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
 获取用户的名称，头像
 @param userIdLists userIdLists
 */
+(void) getImExtraInfo1:(UserGroupIdDtoModel* )userIdLists  callback:(CallBackChatMsgController_ImExtraInfoArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/chatMsg/getImExtraInfo1",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSDictionary *dictPara = [userIdLists modelToJSONObject];

 [HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
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
                    ImExtraInfoModel *handle = [ImExtraInfoModel getFromDict:dic];
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
 添加通讯录置顶
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 @param topType  置顶的类型(当前聊天信息接收方是哪种类型) 1:用户 2:家族 3:粉丝团
 @param topUGID 计算后的ugid
 @param topUserOrGorupId 真实用户或群组id
 */
+(void) addChatTopRecord:(int)topPosition topType:(int)topType topUGID:(int64_t)topUGID topUserOrGorupId:(int64_t)topUserOrGorupId  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/chatMsg/addChatTopRecord",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"topPosition":@(topPosition)
,@"topType":@(topType)
,@"topUGID":@(topUGID)
,@"topUserOrGorupId":@(topUserOrGorupId)};

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
                    ChatTopRecordVOModel *handle = [ChatTopRecordVOModel getFromDict:dic];
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


