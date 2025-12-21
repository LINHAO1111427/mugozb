//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppJoinChatRoomMsgVOModel.h"




 @implementation AppJoinChatRoomMsgVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyId"]=@(_familyId);

dict[@"userId"]=@(_userId);

dict[@"userName"]=_userName;

dict[@"userAvatar"]=_userAvatar;

dict[@"sex"]=@(_sex);

dict[@"age"]=@(_age);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"nobleName"]=_nobleName;

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"nobleMedal"]=_nobleMedal;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppJoinChatRoomMsgVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppJoinChatRoomMsgVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppJoinChatRoomMsgVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppJoinChatRoomMsgVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppJoinChatRoomMsgVOModel* sumMdl=[AppJoinChatRoomMsgVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppJoinChatRoomMsgVOModel*)getFromDict:(NSDictionary*)dict
{
AppJoinChatRoomMsgVOModel* model=[[AppJoinChatRoomMsgVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];


 return model;
}

 +(void)cloneObj:(AppJoinChatRoomMsgVOModel*) source target:(AppJoinChatRoomMsgVOModel*)target
{

target.familyId=source.familyId;

target.userId=source.userId;

target.userName=source.userName;

target.userAvatar=source.userAvatar;

target.sex=source.sex;

target.age=source.age;

target.wealthGradeImg=source.wealthGradeImg;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.nobleName=source.nobleName;

target.nobleGrade=source.nobleGrade;

target.nobleMedal=source.nobleMedal;

}

@end

