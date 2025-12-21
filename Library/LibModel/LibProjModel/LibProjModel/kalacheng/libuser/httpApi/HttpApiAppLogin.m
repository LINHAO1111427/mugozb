//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>
#import <LibProjBase/HttpClient.h>
#import "MJExtension.h"

#import <LibTools/NSDictionary+Json.h>
#import "HttpApiAppLogin.h"




@implementation HttpApiAppLogin



/**
 获取金币映票名称信息
 */
+(void) getCfgCurrency:(CallBackAppLogin_CfgCurrencySetting)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getCfgCurrency",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        CfgCurrencySettingModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [CfgCurrencySettingModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 手机号注册
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param code 验证码
 @param mobile 手机号码
 @param password 密码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) register:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode code:(NSString *)code mobile:(NSString *)mobile password:(NSString *)password phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_UserToken)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/register",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"appVersionCode":appVersionCode
,@"code":code
,@"mobile":mobile
,@"password":password
,@"phoneFirm":phoneFirm
,@"phoneModel":phoneModel
,@"phoneUuid":phoneUuid
,@"smsRegion":smsRegion};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        UserTokenModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [UserTokenModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 添加已经阅读平台使用协议
 */
+(void) addUseLicense:(CallBackAppLogin_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/addUseLicense",nil];
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
 app获取验证码
 @param isInternational 平台 1:国内 2:国外
 @param key key
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 @param tm 时间yyyy-MM-dd HH:mm:ss格式
 */
+(void) getSMSCode:(int)isInternational key:(NSString *)key smsType:(int)smsType tel:(NSString *)tel tm:(NSString *)tm  callback:(CallBackAppLogin_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getSMSCode",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"isInternational":@(isInternational)
,@"key":key
,@"smsType":@(smsType)
,@"tel":tel
,@"tm":tm};

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
 获取轮播图列表 启动图:(1,0) 直播:(2,1) 推荐:(3,12) 附近:(4,13) 一对一:[(5,n),全部(5,1)，推荐(5,23)] 短视频看点:(6,7) 视频分类:(6,8) 动态:(21,21) 语聊(15,1) 电台(16,16) 直播购(17,17)
 @param pid 一级分类
 @param type 二级分类: 0:启动图 1:直播 2:推荐 3:附近
 */
+(void) adslist:(int)pid type:(int)type  callback:(CallBackAppLogin_AppAdsArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/adslist",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"pid":@(pid)
,@"type":@(type)};

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
                    AppAdsModel *handle = [AppAdsModel getFromDict:dic];
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
 密码登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param mobile 手机号码
 @param password 密码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) login:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode mobile:(NSString *)mobile password:(NSString *)password phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_ApiUserInfoLogin)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/login",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"appVersionCode":appVersionCode
,@"mobile":mobile
,@"password":password
,@"phoneFirm":phoneFirm
,@"phoneModel":phoneModel
,@"phoneUuid":phoneUuid
,@"smsRegion":smsRegion};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserInfoLoginModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserInfoLoginModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

//  /api/login/upJiguang
//  /api/login/upJiguang  此函数没有开放POST请求。




/**
 第三方登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param nickname 昵称
 @param openid 第三方标识
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param pic 图片地址
 @param sex 性别 0:保密 1:男 2:女
 @param type 类型 1:QQ 2:微信 3：苹果登录 4：app唯一标识登录
 */
+(void) ChartLogin:(AppLogin_ChartLogin*)_mdl callback:(CallBackAppLogin_ApiUserInfoLogin)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/ChartLogin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":_mdl.appVersion
,@"appVersionCode":_mdl.appVersionCode
,@"nickname":_mdl.nickname
,@"openid":_mdl.openid
,@"phoneFirm":_mdl.phoneFirm
,@"phoneModel":_mdl.phoneModel
,@"phoneUuid":_mdl.phoneUuid
,@"pic":_mdl.pic
,@"sex":@(_mdl.sex)
,@"type":@(_mdl.type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserInfoLoginModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserInfoLoginModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

/**
 第三方登录
 @param appVersion app当前版本号
 @param appVersionCode 当前版本code
 @param nickname 昵称
 @param openid 第三方标识
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param pic 图片地址
 @param sex 性别 0:保密 1:男 2:女
 @param type 类型 1:QQ 2:微信 3：苹果登录 4：app唯一标识登录
 */
+(void) ChartLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode nickname:(NSString *)nickname openid:(NSString *)openid phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid pic:(NSString *)pic sex:(int)sex type:(int)type  callback:(CallBackAppLogin_ApiUserInfoLogin)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/ChartLogin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"appVersionCode":appVersionCode
,@"nickname":nickname
,@"openid":openid
,@"phoneFirm":phoneFirm
,@"phoneModel":phoneModel
,@"phoneUuid":phoneUuid
,@"pic":pic
,@"sex":@(sex)
,@"type":@(type)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserInfoLoginModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserInfoLoginModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取平台使用协议
 */
+(void) getUseLicense:(CallBackAppLogin_AppPosts)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getUseLicense",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        AppPostsModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [AppPostsModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取勋章图片地址
 */
+(void) getMedalList:(CallBackAppLogin_AppMedalArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getMedalList",nil];
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
                    AppMedalModel *handle = [AppMedalModel getFromDict:dic];
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
 版本控制
 @param type 类型 1:安卓 2:ios
 @param versionCode 版本号
 */
+(void) getAppUpdateInfo:(int)type versionCode:(int)versionCode  callback:(CallBackAppLogin_ApiVersion)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getAppUpdateInfo",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"type":@(type)
,@"versionCode":@(versionCode)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiVersionModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiVersionModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 app获取验证码(舍弃)
 @param isInternational 平台 1:国内 2:国外
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 */
+(void) getVerCode:(int)isInternational smsType:(int)smsType tel:(NSString *)tel  callback:(CallBackAppLogin_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getVerCode",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"isInternational":@(isInternational)
,@"smsType":@(smsType)
,@"tel":tel};

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
 忘记密码
 @param code 短信验证码
 @param freshPwd 新密码
 @param freshPwd2 再次输入新密码
 @param phone 手机号码
 */
+(void) forget_pwd:(NSString *)code freshPwd:(NSString *)freshPwd freshPwd2:(NSString *)freshPwd2 phone:(NSString *)phone  callback:(CallBackAppLogin_SingleString)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/forget_pwd",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"code":code
,@"freshPwd":freshPwd
,@"freshPwd2":freshPwd2
,@"phone":phone};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        SingleStringModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [SingleStringModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取支付通道
 */
+(void) getPayWay:(CallBackAppLogin_CfgPayWayDTOArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getPayWay",nil];
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
                    CfgPayWayDTOModel *handle = [CfgPayWayDTOModel getFromDict:dic];
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
 一键登录
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param carrier 运营商
 @param loginTokenVerify 加密的token
 @param loginType 登录厂商 2:轩嗵
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 */
+(void) oneClickLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode carrier:(NSString *)carrier loginTokenVerify:(NSString *)loginTokenVerify loginType:(int)loginType phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid  callback:(CallBackAppLogin_ApiUserInfoLogin)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/oneClickLogin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"appVersionCode":appVersionCode
,@"carrier":carrier
,@"loginTokenVerify":loginTokenVerify
,@"loginType":@(loginType)
,@"phoneFirm":phoneFirm
,@"phoneModel":phoneModel
,@"phoneUuid":phoneUuid};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserInfoLoginModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserInfoLoginModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}

//  /api/login/appSite
//  /api/login/appSite  此函数没有开放POST请求。


/**
 初始化APP公共设置
 */
+(void) getConfig:(CallBackAppLogin_APPConfig)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getConfig",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        APPConfigModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [APPConfigModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取礼物列表
 */
+(void) giftList:(CallBackAppLogin_NobLiveGiftArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/giftList",nil];
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
                    NobLiveGiftModel *handle = [NobLiveGiftModel getFromDict:dic];
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
 版本控制
 @param appVersion 版本号
 @param type 类型 1:安卓 2:ios
 @param versionCode 版本code
 */
+(void) getAppUpdateInfoNew:(NSString *)appVersion type:(int)type versionCode:(int)versionCode  callback:(CallBackAppLogin_ApiVersion)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getAppUpdateInfoNew",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"type":@(type)
,@"versionCode":@(versionCode)};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiVersionModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiVersionModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 包含用户等级，财富等级，主播等级，贵族等级
 */
+(void) getGradeList:(CallBackAppLogin_AppGradeArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getGradeList",nil];
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
                    AppGradeModel *handle = [AppGradeModel getFromDict:dic];
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
 app获取验证码(舍弃)
 @param isInternational 平台 1:国内 2:国外
 @param smsType 类型 1:注册 2:找回密码 3:验证码登录 4:用户注销 5:绑定手机号 6:青少年验证码 7:修改手机号 8:微信公众号登录
 @param tel 手机号码
 */
+(void) getMsgCode:(int)isInternational smsType:(int)smsType tel:(NSString *)tel  callback:(CallBackAppLogin_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getMsgCode",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"isInternational":@(isInternational)
,@"smsType":@(smsType)
,@"tel":tel};

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
 手机验证码登录
 @param appVersion 当前版本号
 @param appVersionCode 当前版本code
 @param code 验证码
 @param mobile 手机号码
 @param phoneFirm 手机厂商
 @param phoneModel 手机型号
 @param phoneUuid 手机唯一标识
 @param smsRegion 手机号区域
 */
+(void) phoneCodeLogin:(NSString *)appVersion appVersionCode:(NSString *)appVersionCode code:(NSString *)code mobile:(NSString *)mobile phoneFirm:(NSString *)phoneFirm phoneModel:(NSString *)phoneModel phoneUuid:(NSString *)phoneUuid smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_ApiUserInfoLogin)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/phoneCodeLogin",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"appVersion":appVersion
,@"appVersionCode":appVersionCode
,@"code":code
,@"mobile":mobile
,@"phoneFirm":phoneFirm
,@"phoneModel":phoneModel
,@"phoneUuid":phoneUuid
,@"smsRegion":smsRegion};

[HttpClient requestPostWithPath:strUrl param:dictPara success:^(id dataBody) {
        NSDictionary* dicRet= (NSDictionary*)dataBody;
        int code= [dicRet getInt:@"code"];
        NSString*strMsg= [dicRet getStr:@"msg"];
        ApiUserInfoLoginModel *retModel;
        if(code==1)
        {
            id retObj= dicRet[@"retObj"];
            if([retObj isKindOfClass:[NSDictionary class]])
            {
                retModel=   [ApiUserInfoLoginModel getFromDict:retObj];
            }
        }
        callback(code,strMsg,retModel);
        return ;
    } failed:^(int code,NSString *error) {
        callback(code,error,nil);
    }];

}



/**
 获取分享域名
 */
+(void) getShareDomainNames:(CallBackAppLogin_CfgShareDomainNameArr)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/getShareDomainNames",nil];
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
                    CfgShareDomainNameModel *handle = [CfgShareDomainNameModel getFromDict:dic];
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
 绑定手机号码
 @param code 验证码
 @param mobile 绑定手机号码
 @param smsRegion 手机号区域
 */
+(void) bindMobile:(NSString *)code mobile:(NSString *)mobile smsRegion:(NSString *)smsRegion  callback:(CallBackAppLogin_HttpNone)callback
{
NSString *strUrl=[NSString stringWithFormat:@"%@%@",[HttpClient getBaseUrl],@"/api/login/bindMobile",nil];
NSDictionary *dictPara=@{@"_uid_":@([HttpClient getUid]) ,@"_token_":[HttpClient getToken],@"_OS_":[HttpClient getOSType],@"_OSV_":[HttpClient getOSVersion],@"_OSInfo_":[HttpClient getOSInfo]
,@"code":code
,@"mobile":mobile
,@"smsRegion":smsRegion};

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


