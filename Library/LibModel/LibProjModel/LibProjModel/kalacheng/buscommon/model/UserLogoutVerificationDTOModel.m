//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserLogoutVerificationDTOModel.h"




 @implementation UserLogoutVerificationDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"role"]=@(_role);

dict[@"logOffSwitch"]=@(_logOffSwitch);

dict[@"votes"]=@(_votes);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserLogoutVerificationDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserLogoutVerificationDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserLogoutVerificationDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserLogoutVerificationDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserLogoutVerificationDTOModel* sumMdl=[UserLogoutVerificationDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserLogoutVerificationDTOModel*)getFromDict:(NSDictionary*)dict
{
UserLogoutVerificationDTOModel* model=[[UserLogoutVerificationDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.logOffSwitch=[dict[@"logOffSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"logOffSwitch"] intValue];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(UserLogoutVerificationDTOModel*) source target:(UserLogoutVerificationDTOModel*)target
{

target.role=source.role;

target.logOffSwitch=source.logOffSwitch;

target.votes=source.votes;

target.coin=source.coin;

}

@end

