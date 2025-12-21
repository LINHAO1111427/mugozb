//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgLiveKeyModel.h"




 @implementation CfgLiveKeyModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"beautySwitch"]=@(_beautySwitch);

dict[@"beautyKey"]=_beautyKey;

dict[@"videoClipsSecretKey"]=_videoClipsSecretKey;

dict[@"liveAppid"]=_liveAppid;

dict[@"videoClipsKey"]=_videoClipsKey;

dict[@"imAppid"]=_imAppid;

dict[@"numberAuthAppid"]=_numberAuthAppid;

dict[@"beautyKeyInfo"]=_beautyKeyInfo;

dict[@"beautyAppid"]=_beautyAppid;

dict[@"cdnCfgKey"]=_cdnCfgKey;

dict[@"numberAuthSecretKey"]=_numberAuthSecretKey;

dict[@"cdnSecretKey"]=_cdnSecretKey;

dict[@"imIp"]=_imIp;

dict[@"numberAuthInfo"]=_numberAuthInfo;

dict[@"id"]=@(_id_field);

dict[@"imKey"]=_imKey;

dict[@"numberAuthKey"]=_numberAuthKey;

dict[@"imSecretKey"]=_imSecretKey;

dict[@"cdnInfo"]=_cdnInfo;

dict[@"tencentAppManager"]=_tencentAppManager;

dict[@"liveSecretKey"]=_liveSecretKey;

dict[@"liveKey"]=_liveKey;

dict[@"tencentAppId"]=@(_tencentAppId);

dict[@"videoClipsInfo"]=_videoClipsInfo;

dict[@"cdnAppId"]=_cdnAppId;

dict[@"videoClipsAppId"]=_videoClipsAppId;

dict[@"numberAuthSwitch"]=@(_numberAuthSwitch);

dict[@"liveRecordKey"]=_liveRecordKey;

dict[@"liveKeyInfo"]=_liveKeyInfo;

dict[@"tencentKey"]=_tencentKey;

dict[@"imProt"]=@(_imProt);

dict[@"beautySecretKey"]=_beautySecretKey;

dict[@"imInfo"]=_imInfo;

dict[@"projectId"]=_projectId;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgLiveKeyModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgLiveKeyModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgLiveKeyModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgLiveKeyModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgLiveKeyModel* sumMdl=[CfgLiveKeyModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgLiveKeyModel*)getFromDict:(NSDictionary*)dict
{
CfgLiveKeyModel* model=[[CfgLiveKeyModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.beautySwitch=[dict[@"beautySwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"beautySwitch"] intValue];

model.beautyKey=[dict[@"beautyKey"] isKindOfClass:[NSNull class]]?@"":dict[@"beautyKey"];

model.videoClipsSecretKey=[dict[@"videoClipsSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"videoClipsSecretKey"];

model.liveAppid=[dict[@"liveAppid"] isKindOfClass:[NSNull class]]?@"":dict[@"liveAppid"];

model.videoClipsKey=[dict[@"videoClipsKey"] isKindOfClass:[NSNull class]]?@"":dict[@"videoClipsKey"];

model.imAppid=[dict[@"imAppid"] isKindOfClass:[NSNull class]]?@"":dict[@"imAppid"];

model.numberAuthAppid=[dict[@"numberAuthAppid"] isKindOfClass:[NSNull class]]?@"":dict[@"numberAuthAppid"];

model.beautyKeyInfo=[dict[@"beautyKeyInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"beautyKeyInfo"];

model.beautyAppid=[dict[@"beautyAppid"] isKindOfClass:[NSNull class]]?@"":dict[@"beautyAppid"];

model.cdnCfgKey=[dict[@"cdnCfgKey"] isKindOfClass:[NSNull class]]?@"":dict[@"cdnCfgKey"];

model.numberAuthSecretKey=[dict[@"numberAuthSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"numberAuthSecretKey"];

model.cdnSecretKey=[dict[@"cdnSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"cdnSecretKey"];

model.imIp=[dict[@"imIp"] isKindOfClass:[NSNull class]]?@"":dict[@"imIp"];

model.numberAuthInfo=[dict[@"numberAuthInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"numberAuthInfo"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.imKey=[dict[@"imKey"] isKindOfClass:[NSNull class]]?@"":dict[@"imKey"];

model.numberAuthKey=[dict[@"numberAuthKey"] isKindOfClass:[NSNull class]]?@"":dict[@"numberAuthKey"];

model.imSecretKey=[dict[@"imSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"imSecretKey"];

model.cdnInfo=[dict[@"cdnInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"cdnInfo"];

model.tencentAppManager=[dict[@"tencentAppManager"] isKindOfClass:[NSNull class]]?@"":dict[@"tencentAppManager"];

model.liveSecretKey=[dict[@"liveSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"liveSecretKey"];

model.liveKey=[dict[@"liveKey"] isKindOfClass:[NSNull class]]?@"":dict[@"liveKey"];

model.tencentAppId=[dict[@"tencentAppId"] isKindOfClass:[NSNull class]]?0:[dict[@"tencentAppId"] longLongValue];

model.videoClipsInfo=[dict[@"videoClipsInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"videoClipsInfo"];

model.cdnAppId=[dict[@"cdnAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"cdnAppId"];

model.videoClipsAppId=[dict[@"videoClipsAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"videoClipsAppId"];

model.numberAuthSwitch=[dict[@"numberAuthSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"numberAuthSwitch"] intValue];

model.liveRecordKey=[dict[@"liveRecordKey"] isKindOfClass:[NSNull class]]?@"":dict[@"liveRecordKey"];

model.liveKeyInfo=[dict[@"liveKeyInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"liveKeyInfo"];

model.tencentKey=[dict[@"tencentKey"] isKindOfClass:[NSNull class]]?@"":dict[@"tencentKey"];

model.imProt=[dict[@"imProt"] isKindOfClass:[NSNull class]]?0:[dict[@"imProt"] intValue];

model.beautySecretKey=[dict[@"beautySecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"beautySecretKey"];

model.imInfo=[dict[@"imInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"imInfo"];

model.projectId=[dict[@"projectId"] isKindOfClass:[NSNull class]]?@"":dict[@"projectId"];


 return model;
}

 +(void)cloneObj:(CfgLiveKeyModel*) source target:(CfgLiveKeyModel*)target
{

target.beautySwitch=source.beautySwitch;

target.beautyKey=source.beautyKey;

target.videoClipsSecretKey=source.videoClipsSecretKey;

target.liveAppid=source.liveAppid;

target.videoClipsKey=source.videoClipsKey;

target.imAppid=source.imAppid;

target.numberAuthAppid=source.numberAuthAppid;

target.beautyKeyInfo=source.beautyKeyInfo;

target.beautyAppid=source.beautyAppid;

target.cdnCfgKey=source.cdnCfgKey;

target.numberAuthSecretKey=source.numberAuthSecretKey;

target.cdnSecretKey=source.cdnSecretKey;

target.imIp=source.imIp;

target.numberAuthInfo=source.numberAuthInfo;

target.id_field=source.id_field;

target.imKey=source.imKey;

target.numberAuthKey=source.numberAuthKey;

target.imSecretKey=source.imSecretKey;

target.cdnInfo=source.cdnInfo;

target.tencentAppManager=source.tencentAppManager;

target.liveSecretKey=source.liveSecretKey;

target.liveKey=source.liveKey;

target.tencentAppId=source.tencentAppId;

target.videoClipsInfo=source.videoClipsInfo;

target.cdnAppId=source.cdnAppId;

target.videoClipsAppId=source.videoClipsAppId;

target.numberAuthSwitch=source.numberAuthSwitch;

target.liveRecordKey=source.liveRecordKey;

target.liveKeyInfo=source.liveKeyInfo;

target.tencentKey=source.tencentKey;

target.imProt=source.imProt;

target.beautySecretKey=source.beautySecretKey;

target.imInfo=source.imInfo;

target.projectId=source.projectId;

}

@end

