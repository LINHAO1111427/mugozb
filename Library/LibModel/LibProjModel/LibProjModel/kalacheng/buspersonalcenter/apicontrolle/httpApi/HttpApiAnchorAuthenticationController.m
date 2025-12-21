//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiAnchorAuthenticationController.h"




@implementation HttpApiAnchorAuthenticationController



/**
 申请认证
 @param vo vo
 */
+(void) applyAuth:(AnchorAuthVOModel* )vo  callback:(CallBackAnchorAuthenticationController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/anchorAuth/applyAuth",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSDictionary *dictPara = [vo modelToJSONObject];

[HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
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
 获取主播认证信息
 */
+(void) authInfo:(CallBackAnchorAuthenticationController_AnchorAuthVO)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/anchorAuth/authInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AnchorAuthVOModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AnchorAuthVOModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 认证信息修改
 @param vo vo
 */
+(void) authUpdate:(AnchorAuthVOModel* )vo  callback:(CallBackAnchorAuthenticationController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/anchorAuth/authUpdate",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSDictionary *dictPara = [vo modelToJSONObject];

[HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
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


