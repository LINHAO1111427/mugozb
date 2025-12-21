//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminLoginSwitchModel.h"




 @implementation AdminLoginSwitchModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"androidOneClickAuthorization"]=@(_androidOneClickAuthorization);

dict[@"defaultUserAvatar"]=_defaultUserAvatar;

dict[@"defaultSignature"]=_defaultSignature;

dict[@"loginType"]=_loginType;

dict[@"id"]=@(_id_field);

dict[@"isRegCode"]=@(_isRegCode);

dict[@"invitationPopDisplay"]=@(_invitationPopDisplay);

dict[@"invitationBindingMethod"]=@(_invitationBindingMethod);

dict[@"openInstallAppKey"]=_openInstallAppKey;

dict[@"shareType"]=_shareType;

dict[@"touristMode"]=@(_touristMode);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminLoginSwitchModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminLoginSwitchModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminLoginSwitchModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminLoginSwitchModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminLoginSwitchModel* sumMdl=[AdminLoginSwitchModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminLoginSwitchModel*)getFromDict:(NSDictionary*)dict
{
AdminLoginSwitchModel* model=[[AdminLoginSwitchModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.androidOneClickAuthorization=[dict[@"androidOneClickAuthorization"] isKindOfClass:[NSNull class]]?0:[dict[@"androidOneClickAuthorization"] intValue];

model.defaultUserAvatar=[dict[@"defaultUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"defaultUserAvatar"];

model.defaultSignature=[dict[@"defaultSignature"] isKindOfClass:[NSNull class]]?@"":dict[@"defaultSignature"];

model.loginType=[dict[@"loginType"] isKindOfClass:[NSNull class]]?@"":dict[@"loginType"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isRegCode=[dict[@"isRegCode"] isKindOfClass:[NSNull class]]?0:[dict[@"isRegCode"] intValue];

model.invitationPopDisplay=[dict[@"invitationPopDisplay"] isKindOfClass:[NSNull class]]?0:[dict[@"invitationPopDisplay"] intValue];

model.invitationBindingMethod=[dict[@"invitationBindingMethod"] isKindOfClass:[NSNull class]]?0:[dict[@"invitationBindingMethod"] intValue];

model.openInstallAppKey=[dict[@"openInstallAppKey"] isKindOfClass:[NSNull class]]?@"":dict[@"openInstallAppKey"];

model.shareType=[dict[@"shareType"] isKindOfClass:[NSNull class]]?@"":dict[@"shareType"];

model.touristMode=[dict[@"touristMode"] isKindOfClass:[NSNull class]]?0:[dict[@"touristMode"] intValue];


 return model;
}

 +(void)cloneObj:(AdminLoginSwitchModel*) source target:(AdminLoginSwitchModel*)target
{

target.androidOneClickAuthorization=source.androidOneClickAuthorization;

target.defaultUserAvatar=source.defaultUserAvatar;

target.defaultSignature=source.defaultSignature;

target.loginType=source.loginType;

target.id_field=source.id_field;

target.isRegCode=source.isRegCode;

target.invitationPopDisplay=source.invitationPopDisplay;

target.invitationBindingMethod=source.invitationBindingMethod;

target.openInstallAppKey=source.openInstallAppKey;

target.shareType=source.shareType;

target.touristMode=source.touristMode;

}

@end

