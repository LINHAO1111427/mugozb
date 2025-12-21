//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminPushConfigModel.h"




 @implementation AdminPushConfigModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"txSecretKey"]=_txSecretKey;

dict[@"voipAuthKeyPath"]=_voipAuthKeyPath;

dict[@"vivoSecretKey"]=_vivoSecretKey;

dict[@"oppoSecretKey"]=_oppoSecretKey;

dict[@"hwAppSecret"]=_hwAppSecret;

dict[@"miPassageId"]=_miPassageId;

dict[@"vivoAppId"]=_vivoAppId;

dict[@"apnsTeamId"]=_apnsTeamId;

dict[@"apnsKeyId"]=_apnsKeyId;

dict[@"hwAppId"]=_hwAppId;

dict[@"jpushSandbox"]=@(_jpushSandbox);

dict[@"miSecretKey"]=_miSecretKey;

dict[@"voipKeyId"]=_voipKeyId;

dict[@"apnsAuthKeyPath"]=_apnsAuthKeyPath;

dict[@"oppoAppKey"]=_oppoAppKey;

dict[@"androidPackageNames"]=_androidPackageNames;

dict[@"iosPackageNames"]=_iosPackageNames;

dict[@"txAppId"]=_txAppId;

dict[@"jpushKey"]=_jpushKey;

dict[@"vivoAppKey"]=_vivoAppKey;

dict[@"id"]=@(_id_field);

dict[@"jpushSecret"]=_jpushSecret;

dict[@"oppoPassageId"]=_oppoPassageId;

dict[@"jpushRSA"]=_jpushRSA;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminPushConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminPushConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminPushConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminPushConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminPushConfigModel* sumMdl=[AdminPushConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminPushConfigModel*)getFromDict:(NSDictionary*)dict
{
AdminPushConfigModel* model=[[AdminPushConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.txSecretKey=[dict[@"txSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"txSecretKey"];

model.voipAuthKeyPath=[dict[@"voipAuthKeyPath"] isKindOfClass:[NSNull class]]?@"":dict[@"voipAuthKeyPath"];

model.vivoSecretKey=[dict[@"vivoSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"vivoSecretKey"];

model.oppoSecretKey=[dict[@"oppoSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"oppoSecretKey"];

model.hwAppSecret=[dict[@"hwAppSecret"] isKindOfClass:[NSNull class]]?@"":dict[@"hwAppSecret"];

model.miPassageId=[dict[@"miPassageId"] isKindOfClass:[NSNull class]]?@"":dict[@"miPassageId"];

model.vivoAppId=[dict[@"vivoAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"vivoAppId"];

model.apnsTeamId=[dict[@"apnsTeamId"] isKindOfClass:[NSNull class]]?@"":dict[@"apnsTeamId"];

model.apnsKeyId=[dict[@"apnsKeyId"] isKindOfClass:[NSNull class]]?@"":dict[@"apnsKeyId"];

model.hwAppId=[dict[@"hwAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"hwAppId"];

model.jpushSandbox=[dict[@"jpushSandbox"] isKindOfClass:[NSNull class]]?0:[dict[@"jpushSandbox"] intValue];

model.miSecretKey=[dict[@"miSecretKey"] isKindOfClass:[NSNull class]]?@"":dict[@"miSecretKey"];

model.voipKeyId=[dict[@"voipKeyId"] isKindOfClass:[NSNull class]]?@"":dict[@"voipKeyId"];

model.apnsAuthKeyPath=[dict[@"apnsAuthKeyPath"] isKindOfClass:[NSNull class]]?@"":dict[@"apnsAuthKeyPath"];

model.oppoAppKey=[dict[@"oppoAppKey"] isKindOfClass:[NSNull class]]?@"":dict[@"oppoAppKey"];

model.androidPackageNames=[dict[@"androidPackageNames"] isKindOfClass:[NSNull class]]?@"":dict[@"androidPackageNames"];

model.iosPackageNames=[dict[@"iosPackageNames"] isKindOfClass:[NSNull class]]?@"":dict[@"iosPackageNames"];

model.txAppId=[dict[@"txAppId"] isKindOfClass:[NSNull class]]?@"":dict[@"txAppId"];

model.jpushKey=[dict[@"jpushKey"] isKindOfClass:[NSNull class]]?@"":dict[@"jpushKey"];

model.vivoAppKey=[dict[@"vivoAppKey"] isKindOfClass:[NSNull class]]?@"":dict[@"vivoAppKey"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.jpushSecret=[dict[@"jpushSecret"] isKindOfClass:[NSNull class]]?@"":dict[@"jpushSecret"];

model.oppoPassageId=[dict[@"oppoPassageId"] isKindOfClass:[NSNull class]]?@"":dict[@"oppoPassageId"];

model.jpushRSA=[dict[@"jpushRSA"] isKindOfClass:[NSNull class]]?@"":dict[@"jpushRSA"];


 return model;
}

 +(void)cloneObj:(AdminPushConfigModel*) source target:(AdminPushConfigModel*)target
{

target.txSecretKey=source.txSecretKey;

target.voipAuthKeyPath=source.voipAuthKeyPath;

target.vivoSecretKey=source.vivoSecretKey;

target.oppoSecretKey=source.oppoSecretKey;

target.hwAppSecret=source.hwAppSecret;

target.miPassageId=source.miPassageId;

target.vivoAppId=source.vivoAppId;

target.apnsTeamId=source.apnsTeamId;

target.apnsKeyId=source.apnsKeyId;

target.hwAppId=source.hwAppId;

target.jpushSandbox=source.jpushSandbox;

target.miSecretKey=source.miSecretKey;

target.voipKeyId=source.voipKeyId;

target.apnsAuthKeyPath=source.apnsAuthKeyPath;

target.oppoAppKey=source.oppoAppKey;

target.androidPackageNames=source.androidPackageNames;

target.iosPackageNames=source.iosPackageNames;

target.txAppId=source.txAppId;

target.jpushKey=source.jpushKey;

target.vivoAppKey=source.vivoAppKey;

target.id_field=source.id_field;

target.jpushSecret=source.jpushSecret;

target.oppoPassageId=source.oppoPassageId;

target.jpushRSA=source.jpushRSA;

}

@end

