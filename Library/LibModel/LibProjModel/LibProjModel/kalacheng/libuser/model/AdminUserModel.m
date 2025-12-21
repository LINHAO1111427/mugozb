//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminUserModel.h"




 @implementation AdminUserModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"coinTotal"]=@(_coinTotal);

dict[@"serialNumber"]=@(_serialNumber);

dict[@"quitState"]=@(_quitState);

dict[@"inviteCodeLink"]=_inviteCodeLink;

dict[@"mobile"]=_mobile;

dict[@"desr"]=_desr;

dict[@"userState"]=@(_userState);

dict[@"inviteCode"]=_inviteCode;

dict[@"name"]=_name;

dict[@"logo"]=_logo;

dict[@"id"]=@(_id_field);

dict[@"contacts"]=_contacts;

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminUserModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminUserModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminUserModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminUserModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminUserModel* sumMdl=[AdminUserModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminUserModel*)getFromDict:(NSDictionary*)dict
{
AdminUserModel* model=[[AdminUserModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.coinTotal=[dict[@"coinTotal"] isKindOfClass:[NSNull class]]?0:[dict[@"coinTotal"] doubleValue];

model.serialNumber=[dict[@"serialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNumber"] doubleValue];

model.quitState=[dict[@"quitState"] isKindOfClass:[NSNull class]]?0:[dict[@"quitState"] intValue];

model.inviteCodeLink=[dict[@"inviteCodeLink"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteCodeLink"];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];

model.userState=[dict[@"userState"] isKindOfClass:[NSNull class]]?0:[dict[@"userState"] intValue];

model.inviteCode=[dict[@"inviteCode"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteCode"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.contacts=[dict[@"contacts"] isKindOfClass:[NSNull class]]?@"":dict[@"contacts"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(AdminUserModel*) source target:(AdminUserModel*)target
{

target.coinTotal=source.coinTotal;

target.serialNumber=source.serialNumber;

target.quitState=source.quitState;

target.inviteCodeLink=source.inviteCodeLink;

target.mobile=source.mobile;

target.desr=source.desr;

target.userState=source.userState;

target.inviteCode=source.inviteCode;

target.name=source.name;

target.logo=source.logo;

target.id_field=source.id_field;

target.contacts=source.contacts;

target.username=source.username;

}

@end

