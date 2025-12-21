//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLineVoiceModel.h"




 @implementation ApiLineVoiceModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"no"]=@(_no);

dict[@"anchorGrade"]=_anchorGrade;

dict[@"role"]=@(_role);

dict[@"addTime"]=@(_addTime);

dict[@"userGrade"]=_userGrade;

dict[@"sex"]=@(_sex);

dict[@"estimatedExpirationTime"]=@(_estimatedExpirationTime);

dict[@"avatar"]=_avatar;

dict[@"anchorId"]=@(_anchorId);

dict[@"userName"]=_userName;

dict[@"roomId"]=@(_roomId);

dict[@"lineStatus"]=@(_lineStatus);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"uid"]=@(_uid);

dict[@"wealthGrade"]=_wealthGrade;

dict[@"nobleGrade"]=_nobleGrade;

dict[@"age"]=@(_age);

dict[@"coin"]=@(_coin);

dict[@"mikePrivilege"]=@(_mikePrivilege);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLineVoiceModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLineVoiceModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLineVoiceModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLineVoiceModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLineVoiceModel* sumMdl=[ApiLineVoiceModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLineVoiceModel*)getFromDict:(NSDictionary*)dict
{
ApiLineVoiceModel* model=[[ApiLineVoiceModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.no=[dict[@"no"] isKindOfClass:[NSNull class]]?0:[dict[@"no"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGrade"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?0:[dict[@"addTime"] longLongValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?@"":dict[@"userGrade"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.estimatedExpirationTime=[dict[@"estimatedExpirationTime"] isKindOfClass:[NSNull class]]?0:[dict[@"estimatedExpirationTime"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.lineStatus=[dict[@"lineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"lineStatus"] intValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGrade"];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGrade"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.mikePrivilege=[dict[@"mikePrivilege"] isKindOfClass:[NSNull class]]?0:[dict[@"mikePrivilege"] intValue];


 return model;
}

 +(void)cloneObj:(ApiLineVoiceModel*) source target:(ApiLineVoiceModel*)target
{

target.no=source.no;

target.anchorGrade=source.anchorGrade;

target.role=source.role;

target.addTime=source.addTime;

target.userGrade=source.userGrade;

target.sex=source.sex;

target.estimatedExpirationTime=source.estimatedExpirationTime;

target.avatar=source.avatar;

target.anchorId=source.anchorId;

target.userName=source.userName;

target.roomId=source.roomId;

target.lineStatus=source.lineStatus;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.uid=source.uid;

target.wealthGrade=source.wealthGrade;

target.nobleGrade=source.nobleGrade;

target.age=source.age;

target.coin=source.coin;

target.mikePrivilege=source.mikePrivilege;

}

@end

