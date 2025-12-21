//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiConfigController.h"




@implementation HttpApiConfigController



/**
 获取互动直播Token，code=333表示欠费
 @param channelName channelName
 @param uid uid
 */
+(void) getRtcToken:(NSString *)channelName uid:(int64_t)uid  callback:(CallBackConfigController_LiveRtcToken)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/live/getRtcToken",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"channelName":channelName
,@"uid":@(uid)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        LiveRtcTokenModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [LiveRtcTokenModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


+(void) sendpushUrl:(NSString *)pushUrl uid:(int64_t)uid roomId:(NSString *)roomId callback:(CallBackpushaction)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/httplive/startPush",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"roomId":roomId
,@"uid":@(uid)
,@"pushUrl":pushUrl,
};

    
[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
       NSDictionary* dicRet= (NSDictionary*)dataBody;
       int code= [dicRet getInt:@"code"];
       NSString*strMsg= [dicRet getStr:@"msg"];
        NSDictionary *retObj = nil;
       if(code==1)
       {
           retObj= dicRet[@"retObj"];
          
       }
       callback(code,strMsg,retObj);
       return ;
   } failed:^(int code,NSString *error) {
       callback(code,error,nil);
   }];

}

@end


