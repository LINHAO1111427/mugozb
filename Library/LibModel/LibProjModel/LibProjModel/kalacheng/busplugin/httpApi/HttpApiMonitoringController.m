//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiMonitoringController.h"




@implementation HttpApiMonitoringController



/**
 图片鉴黄
 @param imageUrls 图片地址(多张逗号隔开)
 @param monitoringType 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 10:头像
 @param roomId 房间号
 @param showId 直播标识
 */
+(void) imageMonitoring:(NSString *)imageUrls monitoringType:(int)monitoringType roomId:(int64_t)roomId showId:(NSString *)showId  callback:(CallBackMonitoringController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/monitoring/imageMonitoring",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"imageUrls":imageUrls
,@"monitoringType":@(monitoringType)
,@"roomId":@(roomId)
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


@end


