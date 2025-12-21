//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserTokenModel.h"




 @implementation UserTokenModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userAvatarId"]=@(_userAvatarId);

dict[@"userid"]=@(_userid);

dict[@"UserToken"]=_UserToken;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserTokenModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserTokenModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserTokenModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserTokenModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserTokenModel* sumMdl=[UserTokenModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserTokenModel*)getFromDict:(NSDictionary*)dict
{
UserTokenModel* model=[[UserTokenModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userAvatarId=[dict[@"userAvatarId"] isKindOfClass:[NSNull class]]?0:[dict[@"userAvatarId"] longLongValue];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.UserToken=[dict[@"UserToken"] isKindOfClass:[NSNull class]]?@"":dict[@"UserToken"];


 return model;
}

 +(void)cloneObj:(UserTokenModel*) source target:(UserTokenModel*)target
{

target.userAvatarId=source.userAvatarId;

target.userid=source.userid;

target.UserToken=source.UserToken;

}

@end

