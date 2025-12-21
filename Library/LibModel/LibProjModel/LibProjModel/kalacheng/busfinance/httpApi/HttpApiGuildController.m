//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiGuildController.h"




@implementation HttpApiGuildController



/**
 申请退出公会
 @param guildId guildId
 @param reason reason
 */
+(void) applyQuitGuild:(int64_t)guildId reason:(NSString *)reason  callback:(CallBackGuildController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/guild/applyQuitGuild",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"guildId":@(guildId)
,@"reason":reason};

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

//  /api/guild/toJoinGuild
//  /api/guild/toJoinGuild  此函数没有开放POST请求。
//  /api/guild/toAnchorEquity
//  /api/guild/toAnchorEquity  此函数没有开放POST请求。
//  /api/guild/toGuildDetail
//  /api/guild/toGuildDetail  此函数没有开放POST请求。
//  /api/guild/toGuildList
//  /api/guild/toGuildList  此函数没有开放POST请求。


/**
 申请加入公会
 @param enclosure enclosure
 @param endTime endTime
 @param expectIncome expectIncome
 @param feat feat
 @param guildId guildId
 @param startTime startTime
 */
+(void) applyJoinGuild:(NSString *)enclosure endTime:(NSString *)endTime expectIncome:(double)expectIncome feat:(NSString *)feat guildId:(int64_t)guildId startTime:(NSString *)startTime  callback:(CallBackGuildController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/guild/applyJoinGuild",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"enclosure":enclosure
,@"endTime":endTime
,@"expectIncome":@(expectIncome)
,@"feat":feat
,@"guildId":@(guildId)
,@"startTime":startTime};

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


