//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OTMAssisRetModel.h"




 @implementation OTMAssisRetModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"hostVolumed"]=@(_hostVolumed);

dict[@"isShutUp"]=@(_isShutUp);

dict[@"role"]=@(_role);

dict[@"userToRoomRole"]=@(_userToRoomRole);

dict[@"groupId"]=@(_groupId);

dict[@"userAvatar"]=_userAvatar;

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OTMAssisRetModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OTMAssisRetModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OTMAssisRetModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OTMAssisRetModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OTMAssisRetModel* sumMdl=[OTMAssisRetModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OTMAssisRetModel*)getFromDict:(NSDictionary*)dict
{
OTMAssisRetModel* model=[[OTMAssisRetModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.hostVolumed=[dict[@"hostVolumed"] isKindOfClass:[NSNull class]]?0:[dict[@"hostVolumed"] intValue];

model.isShutUp=[dict[@"isShutUp"] isKindOfClass:[NSNull class]]?0:[dict[@"isShutUp"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.userToRoomRole=[dict[@"userToRoomRole"] isKindOfClass:[NSNull class]]?0:[dict[@"userToRoomRole"] intValue];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(OTMAssisRetModel*) source target:(OTMAssisRetModel*)target
{

target.hostVolumed=source.hostVolumed;

target.isShutUp=source.isShutUp;

target.role=source.role;

target.userToRoomRole=source.userToRoomRole;

target.groupId=source.groupId;

target.userAvatar=source.userAvatar;

target.nobleGrade=source.nobleGrade;

target.userName=source.userName;

target.userId=source.userId;

}

@end

