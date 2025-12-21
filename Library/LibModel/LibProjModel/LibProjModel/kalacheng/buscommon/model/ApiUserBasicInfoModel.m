//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserBasicInfoModel.h"




 @implementation ApiUserBasicInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"role"]=@(_role);

dict[@"signature"]=_signature;

dict[@"joinRoomShow"]=@(_joinRoomShow);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"liveThumb"]=_liveThumb;

dict[@"nobleName"]=_nobleName;

dict[@"noTalking"]=@(_noTalking);

dict[@"roomPKVotes"]=@(_roomPKVotes);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"uid"]=@(_uid);

dict[@"isInAssistant"]=@(_isInAssistant);

dict[@"roomRole"]=@(_roomRole);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"sex"]=@(_sex);

dict[@"iszombiep"]=@(_iszombiep);

dict[@"avatar"]=_avatar;

dict[@"anchorId"]=@(_anchorId);

dict[@"currContValue"]=@(_currContValue);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"pull"]=_pull;

dict[@"roomPkSid"]=@(_roomPkSid);

dict[@"roomVotes"]=@(_roomVotes);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"hostVolumed"]=@(_hostVolumed);

dict[@"isInTheRoom"]=@(_isInTheRoom);

dict[@"presenterUserId"]=@(_presenterUserId);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"age"]=@(_age);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserBasicInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserBasicInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserBasicInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserBasicInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserBasicInfoModel* sumMdl=[ApiUserBasicInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserBasicInfoModel*)getFromDict:(NSDictionary*)dict
{
ApiUserBasicInfoModel* model=[[ApiUserBasicInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.joinRoomShow=[dict[@"joinRoomShow"] isKindOfClass:[NSNull class]]?0:[dict[@"joinRoomShow"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.noTalking=[dict[@"noTalking"] isKindOfClass:[NSNull class]]?0:[dict[@"noTalking"] intValue];

model.roomPKVotes=[dict[@"roomPKVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"roomPKVotes"] doubleValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.isInAssistant=[dict[@"isInAssistant"] isKindOfClass:[NSNull class]]?0:[dict[@"isInAssistant"] intValue];

model.roomRole=[dict[@"roomRole"] isKindOfClass:[NSNull class]]?0:[dict[@"roomRole"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.iszombiep=[dict[@"iszombiep"] isKindOfClass:[NSNull class]]?0:[dict[@"iszombiep"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.currContValue=[dict[@"currContValue"] isKindOfClass:[NSNull class]]?0:[dict[@"currContValue"] doubleValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.roomPkSid=[dict[@"roomPkSid"] isKindOfClass:[NSNull class]]?0:[dict[@"roomPkSid"] longLongValue];

model.roomVotes=[dict[@"roomVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"roomVotes"] doubleValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.hostVolumed=[dict[@"hostVolumed"] isKindOfClass:[NSNull class]]?0:[dict[@"hostVolumed"] intValue];

model.isInTheRoom=[dict[@"isInTheRoom"] isKindOfClass:[NSNull class]]?0:[dict[@"isInTheRoom"] intValue];

model.presenterUserId=[dict[@"presenterUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"presenterUserId"] longLongValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiUserBasicInfoModel*) source target:(ApiUserBasicInfoModel*)target
{

target.role=source.role;

target.signature=source.signature;

target.joinRoomShow=source.joinRoomShow;

target.userGradeImg=source.userGradeImg;

target.liveThumb=source.liveThumb;

target.nobleName=source.nobleName;

target.noTalking=source.noTalking;

target.roomPKVotes=source.roomPKVotes;

target.nobleGradeImg=source.nobleGradeImg;

target.uid=source.uid;

target.isInAssistant=source.isInAssistant;

target.roomRole=source.roomRole;

target.wealthGradeImg=source.wealthGradeImg;

target.sex=source.sex;

target.iszombiep=source.iszombiep;

target.avatar=source.avatar;

target.anchorId=source.anchorId;

target.currContValue=source.currContValue;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.pull=source.pull;

target.roomPkSid=source.roomPkSid;

target.roomVotes=source.roomVotes;

target.anchorGradeImg=source.anchorGradeImg;

target.hostVolumed=source.hostVolumed;

target.isInTheRoom=source.isInTheRoom;

target.presenterUserId=source.presenterUserId;

target.nobleGrade=source.nobleGrade;

target.age=source.age;

target.username=source.username;

}

@end

