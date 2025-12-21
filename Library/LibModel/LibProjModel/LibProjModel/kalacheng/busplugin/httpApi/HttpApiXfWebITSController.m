//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiXfWebITSController.h"




@implementation HttpApiXfWebITSController



/**
 科大讯飞翻译
 @param fromLanguage 源语言（中文：cn 越南语：vi）
 @param text 需要翻译的文字
 @param toLanguage 目标语言（中文：cn 越南语：vi）
 */
+(void) languageConversion:(NSString *)fromLanguage text:(NSString *)text toLanguage:(NSString *)toLanguage  callback:(CallBackXfWebITSController_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/its/languageConversion",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"fromLanguage":fromLanguage
,@"text":text
,@"toLanguage":toLanguage};

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


