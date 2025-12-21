//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "APPConfigModel.h"
#import "AdminKeywordManageModel.h"
#import "CfgPayWayDTOModel.h"
#import "AdminPushConfigModel.h"
#import "CoinDisplaySettingsVOModel.h"
#import "CustomerServiceSettingModel.h"
#import "CfgSmsRegionModel.h"
#import "AdminLiveConfigModel.h"
#import "CfgLiveKeyModel.h"
#import "AppBackpackManageVOModel.h"
#import "OooLiveConfigVOModel.h"
#import "AdminLoginSwitchModel.h"
#import "AdminVersionManageModel.h"




 @implementation APPConfigModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"keywordManage" : [AdminKeywordManageModel class],@"payConfigList" : [CfgPayWayDTOModel class],@"adminPushConfig" : [AdminPushConfigModel class],@"coinDisplaySettingsVO" : [CoinDisplaySettingsVOModel class],@"customerServiceSetting" : [CustomerServiceSettingModel class],@"cfgSmsRegionVOList" : [CfgSmsRegionModel class],@"adminLiveConfig" : [AdminLiveConfigModel class],@"liveKey" : [CfgLiveKeyModel class],@"appBackpackManageVO" : [AppBackpackManageVOModel class],@"oooLiveConfigVO" : [OooLiveConfigVOModel class],@"loginSwitch" : [AdminLoginSwitchModel class],@"versionManage" : [AdminVersionManageModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"haveMonitoring"]=@(_haveMonitoring);

dict[@"liveManagerLimit"]=@(_liveManagerLimit);

dict[@"keywordManage"]=[_keywordManage modelToJSONObject];

dict[@"voiceManagerLimit"]=@(_voiceManagerLimit);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_payConfigList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
CfgPayWayDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"payConfigList"]=list;
}//end

dict[@"adminPushConfig"]=[_adminPushConfig modelToJSONObject];

dict[@"nobleShowNearby"]=@(_nobleShowNearby);

dict[@"coinDisplaySettingsVO"]=[_coinDisplaySettingsVO modelToJSONObject];

dict[@"currTime"]=@(_currTime);

dict[@"customerServiceSetting"]=[_customerServiceSetting modelToJSONObject];

dict[@"voiceMsgCheckedSend"]=@(_voiceMsgCheckedSend);

dict[@"imageQuality"]=@(_imageQuality);

dict[@"vcUnitIcon"]=_vcUnitIcon;

dict[@"incomeCashAuth"]=@(_incomeCashAuth);

dict[@"ticketIcon"]=_ticketIcon;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_cfgSmsRegionVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
CfgSmsRegionModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"cfgSmsRegionVOList"]=list;
}//end

dict[@"vcUnit"]=_vcUnit;

dict[@"adminLiveConfig"]=[_adminLiveConfig modelToJSONObject];

dict[@"liveKey"]=[_liveKey modelToJSONObject];

dict[@"visitorUserToken"]=_visitorUserToken;

dict[@"wxAppId"]=_wxAppId;

dict[@"lianAiAdsInterval"]=@(_lianAiAdsInterval);

dict[@"visitorUserID"]=@(_visitorUserID);

dict[@"appBackpackManageVO"]=[_appBackpackManageVO modelToJSONObject];

dict[@"oooLiveConfigVO"]=[_oooLiveConfigVO modelToJSONObject];

dict[@"monitoringInterval"]=@(_monitoringInterval);

dict[@"loginSwitch"]=[_loginSwitch modelToJSONObject];

dict[@"versionManage"]=[_versionManage modelToJSONObject];

dict[@"ticketName"]=_ticketName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<APPConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
APPConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<APPConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<APPConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
APPConfigModel* sumMdl=[APPConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(APPConfigModel*)getFromDict:(NSDictionary*)dict
{
APPConfigModel* model=[[APPConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.haveMonitoring=[dict[@"haveMonitoring"] isKindOfClass:[NSNull class]]?0:[dict[@"haveMonitoring"] intValue];

model.liveManagerLimit=[dict[@"liveManagerLimit"] isKindOfClass:[NSNull class]]?0:[dict[@"liveManagerLimit"] intValue];


//getFromDict对象转换  
model.keywordManage=[AdminKeywordManageModel getFromDict:dict[@"keywordManage"]];

model.voiceManagerLimit=[dict[@"voiceManagerLimit"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceManagerLimit"] intValue];

model.payConfigList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"payConfigList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgPayWayDTOModel* sumMdl=[CfgPayWayDTOModel getFromDict:subDic];
[model.payConfigList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.adminPushConfig=[AdminPushConfigModel getFromDict:dict[@"adminPushConfig"]];

model.nobleShowNearby=[dict[@"nobleShowNearby"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleShowNearby"] intValue];


//getFromDict对象转换  
model.coinDisplaySettingsVO=[CoinDisplaySettingsVOModel getFromDict:dict[@"coinDisplaySettingsVO"]];

model.currTime=[dict[@"currTime"] isKindOfClass:[NSNull class]]?0:[dict[@"currTime"] longLongValue];


//getFromDict对象转换  
model.customerServiceSetting=[CustomerServiceSettingModel getFromDict:dict[@"customerServiceSetting"]];

model.voiceMsgCheckedSend=[dict[@"voiceMsgCheckedSend"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceMsgCheckedSend"] intValue];

model.imageQuality=[dict[@"imageQuality"] isKindOfClass:[NSNull class]]?0:[dict[@"imageQuality"] intValue];

model.vcUnitIcon=[dict[@"vcUnitIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"vcUnitIcon"];

model.incomeCashAuth=[dict[@"incomeCashAuth"] isKindOfClass:[NSNull class]]?0:[dict[@"incomeCashAuth"] intValue];

model.ticketIcon=[dict[@"ticketIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"ticketIcon"];

model.cfgSmsRegionVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"cfgSmsRegionVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgSmsRegionModel* sumMdl=[CfgSmsRegionModel getFromDict:subDic];
[model.cfgSmsRegionVOList addObject:sumMdl];

}
}

}

model.vcUnit=[dict[@"vcUnit"] isKindOfClass:[NSNull class]]?@"":dict[@"vcUnit"];


//getFromDict对象转换  
model.adminLiveConfig=[AdminLiveConfigModel getFromDict:dict[@"adminLiveConfig"]];


//getFromDict对象转换  
model.liveKey=[CfgLiveKeyModel getFromDict:dict[@"liveKey"]];

model.visitorUserToken=[dict[@"visitorUserToken"] isKindOfClass:[NSNull class]]?@"":dict[@"visitorUserToken"];

model.wxAppId=[dict[@"wxAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"wxAppId"];

model.lianAiAdsInterval=[dict[@"lianAiAdsInterval"] isKindOfClass:[NSNull class]]?0:[dict[@"lianAiAdsInterval"] intValue];

model.visitorUserID=[dict[@"visitorUserID"] isKindOfClass:[NSNull class]]?0:[dict[@"visitorUserID"] longLongValue];


//getFromDict对象转换  
model.appBackpackManageVO=[AppBackpackManageVOModel getFromDict:dict[@"appBackpackManageVO"]];


//getFromDict对象转换  
model.oooLiveConfigVO=[OooLiveConfigVOModel getFromDict:dict[@"oooLiveConfigVO"]];

model.monitoringInterval=[dict[@"monitoringInterval"] isKindOfClass:[NSNull class]]?0:[dict[@"monitoringInterval"] intValue];


//getFromDict对象转换  
model.loginSwitch=[AdminLoginSwitchModel getFromDict:dict[@"loginSwitch"]];


//getFromDict对象转换  
model.versionManage=[AdminVersionManageModel getFromDict:dict[@"versionManage"]];

model.ticketName=[dict[@"ticketName"] isKindOfClass:[NSNull class]]?@"":dict[@"ticketName"];


 return model;
}

 +(void)cloneObj:(APPConfigModel*) source target:(APPConfigModel*)target
{

target.haveMonitoring=source.haveMonitoring;

target.liveManagerLimit=source.liveManagerLimit;
        if(source.keywordManage==nil)
        {
//            target.keywordManage=nil;
        }else
        {
            [AdminKeywordManageModel cloneObj:source.keywordManage target:target.keywordManage];
        }

target.voiceManagerLimit=source.voiceManagerLimit;

        if(source.payConfigList==nil)
        {
//            target.payConfigList=nil;
        }else
        {
            target.payConfigList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.payConfigList.count;i++)
            {
		  [target.payConfigList addObject:[[CfgPayWayDTOModel alloc]init]];
            [CfgPayWayDTOModel cloneObj:source.payConfigList[i] target:target.payConfigList[i]];
            }
        }

        if(source.adminPushConfig==nil)
        {
//            target.adminPushConfig=nil;
        }else
        {
            [AdminPushConfigModel cloneObj:source.adminPushConfig target:target.adminPushConfig];
        }

target.nobleShowNearby=source.nobleShowNearby;
        if(source.coinDisplaySettingsVO==nil)
        {
//            target.coinDisplaySettingsVO=nil;
        }else
        {
            [CoinDisplaySettingsVOModel cloneObj:source.coinDisplaySettingsVO target:target.coinDisplaySettingsVO];
        }

target.currTime=source.currTime;
        if(source.customerServiceSetting==nil)
        {
//            target.customerServiceSetting=nil;
        }else
        {
            [CustomerServiceSettingModel cloneObj:source.customerServiceSetting target:target.customerServiceSetting];
        }

target.voiceMsgCheckedSend=source.voiceMsgCheckedSend;

target.imageQuality=source.imageQuality;

target.vcUnitIcon=source.vcUnitIcon;

target.incomeCashAuth=source.incomeCashAuth;

target.ticketIcon=source.ticketIcon;

        if(source.cfgSmsRegionVOList==nil)
        {
//            target.cfgSmsRegionVOList=nil;
        }else
        {
            target.cfgSmsRegionVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.cfgSmsRegionVOList.count;i++)
            {
		  [target.cfgSmsRegionVOList addObject:[[CfgSmsRegionModel alloc]init]];
            [CfgSmsRegionModel cloneObj:source.cfgSmsRegionVOList[i] target:target.cfgSmsRegionVOList[i]];
            }
        }


target.vcUnit=source.vcUnit;
        if(source.adminLiveConfig==nil)
        {
//            target.adminLiveConfig=nil;
        }else
        {
            [AdminLiveConfigModel cloneObj:source.adminLiveConfig target:target.adminLiveConfig];
        }
        if(source.liveKey==nil)
        {
//            target.liveKey=nil;
        }else
        {
            [CfgLiveKeyModel cloneObj:source.liveKey target:target.liveKey];
        }

target.visitorUserToken=source.visitorUserToken;

target.wxAppId=source.wxAppId;

target.lianAiAdsInterval=source.lianAiAdsInterval;

target.visitorUserID=source.visitorUserID;
        if(source.appBackpackManageVO==nil)
        {
//            target.appBackpackManageVO=nil;
        }else
        {
            [AppBackpackManageVOModel cloneObj:source.appBackpackManageVO target:target.appBackpackManageVO];
        }
        if(source.oooLiveConfigVO==nil)
        {
//            target.oooLiveConfigVO=nil;
        }else
        {
            [OooLiveConfigVOModel cloneObj:source.oooLiveConfigVO target:target.oooLiveConfigVO];
        }

target.monitoringInterval=source.monitoringInterval;
        if(source.loginSwitch==nil)
        {
//            target.loginSwitch=nil;
        }else
        {
            [AdminLoginSwitchModel cloneObj:source.loginSwitch target:target.loginSwitch];
        }
        if(source.versionManage==nil)
        {
//            target.versionManage=nil;
        }else
        {
            [AdminVersionManageModel cloneObj:source.versionManage target:target.versionManage];
        }

target.ticketName=source.ticketName;

}

@end

