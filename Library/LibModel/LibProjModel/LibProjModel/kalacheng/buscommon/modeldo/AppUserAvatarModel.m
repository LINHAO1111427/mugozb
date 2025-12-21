//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserAvatarModel.h"




 @implementation AppUserAvatarModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"groupId"]=@(_groupId);

dict[@"userAvatar"]=_userAvatar;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserAvatarModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserAvatarModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserAvatarModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserAvatarModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserAvatarModel* sumMdl=[AppUserAvatarModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserAvatarModel*)getFromDict:(NSDictionary*)dict
{
AppUserAvatarModel* model=[[AppUserAvatarModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppUserAvatarModel*) source target:(AppUserAvatarModel*)target
{

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.groupId=source.groupId;

target.userAvatar=source.userAvatar;

target.userName=source.userName;

target.userId=source.userId;

}

@end

