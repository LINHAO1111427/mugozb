//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGuardEntityChildModel.h"




 @implementation ApiGuardEntityChildModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"uid"]=@(_uid);

dict[@"lengthType"]=@(_lengthType);

dict[@"userLevel"]=_userLevel;

dict[@"sex"]=@(_sex);

dict[@"avatar"]=_avatar;

dict[@"userName"]=_userName;

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGuardEntityChildModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGuardEntityChildModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGuardEntityChildModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGuardEntityChildModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGuardEntityChildModel* sumMdl=[ApiGuardEntityChildModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGuardEntityChildModel*)getFromDict:(NSDictionary*)dict
{
ApiGuardEntityChildModel* model=[[ApiGuardEntityChildModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.lengthType=[dict[@"lengthType"] isKindOfClass:[NSNull class]]?0:[dict[@"lengthType"] intValue];

model.userLevel=[dict[@"userLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"userLevel"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] intValue];


 return model;
}

 +(void)cloneObj:(ApiGuardEntityChildModel*) source target:(ApiGuardEntityChildModel*)target
{

target.uid=source.uid;

target.lengthType=source.lengthType;

target.userLevel=source.userLevel;

target.sex=source.sex;

target.avatar=source.avatar;

target.userName=source.userName;

target.coin=source.coin;

}

@end

