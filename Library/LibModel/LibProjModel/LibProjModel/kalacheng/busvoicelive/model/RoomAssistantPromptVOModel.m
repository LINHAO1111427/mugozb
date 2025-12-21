//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RoomAssistantPromptVOModel.h"




 @implementation RoomAssistantPromptVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"presenterUid"]=@(_presenterUid);

dict[@"invitePeopleId"]=@(_invitePeopleId);

dict[@"userId"]=@(_userId);

dict[@"userName"]=_userName;

dict[@"userAvatar"]=_userAvatar;

dict[@"content"]=_content;

dict[@"lineTime"]=@(_lineTime);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RoomAssistantPromptVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RoomAssistantPromptVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RoomAssistantPromptVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RoomAssistantPromptVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RoomAssistantPromptVOModel* sumMdl=[RoomAssistantPromptVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RoomAssistantPromptVOModel*)getFromDict:(NSDictionary*)dict
{
RoomAssistantPromptVOModel* model=[[RoomAssistantPromptVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.presenterUid=[dict[@"presenterUid"] isKindOfClass:[NSNull class]]?0:[dict[@"presenterUid"] longLongValue];

model.invitePeopleId=[dict[@"invitePeopleId"] isKindOfClass:[NSNull class]]?0:[dict[@"invitePeopleId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.lineTime=[dict[@"lineTime"] isKindOfClass:[NSNull class]]?0:[dict[@"lineTime"] intValue];


 return model;
}

 +(void)cloneObj:(RoomAssistantPromptVOModel*) source target:(RoomAssistantPromptVOModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.presenterUid=source.presenterUid;

target.invitePeopleId=source.invitePeopleId;

target.userId=source.userId;

target.userName=source.userName;

target.userAvatar=source.userAvatar;

target.content=source.content;

target.lineTime=source.lineTime;

}

@end

