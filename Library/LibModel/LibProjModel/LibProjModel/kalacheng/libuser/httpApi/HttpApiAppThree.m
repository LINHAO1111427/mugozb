//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiAppThree.h"




@implementation HttpApiAppThree



/**
 轩嗵云token提供给app端,文件后缀前端拼接,由于a、上传到轩嗵云的文件必须按照后端统一的命名规则命名；b、后端会定期清理轩嗵云的文件。参数需要区分应用场景已list参数传入,拿到的filePath需要拼接文件路径,和token一并传入轩嗵云 参数案例'[{'scene':1},{'scene':1},{'scene':1}]'
 @param apiFileUploadParams apiFileUploadParams
 */
+(void) getUploadInfo:(NSMutableArray<modelApiFileUploadParamsModel*>* )apiFileUploadParams  callback:(CallBackAppThree_ApiFileUpload)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@?_uid_=%lli&_token_=%@&_OS_=%@&_OSV_=%@&_OSInfo_=%@",[HttpClient getBaseUrl],@"/api/three/getUploadInfo",[HttpClient getUid],[HttpClient getToken],[HttpClient urlEncode:[HttpClient getOSType]],[HttpClient urlEncode:[HttpClient getOSVersion]],[HttpClient urlEncode:[HttpClient getOSInfo]],nil];
NSMutableArray *dictPara = [modelApiFileUploadParamsModel modelToJSONArray:apiFileUploadParams];

[HttpClient jsonPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiFileUploadModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiFileUploadModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}


@end


