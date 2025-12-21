//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOInviteRetModel.h"




 @implementation OOOInviteRetModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userStatus"]=@(_userStatus);

dict[@"thumb"]=_thumb;

dict[@"feeUid"]=@(_feeUid);

dict[@"groupId"]=@(_groupId);

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"videoImg"]=_videoImg;

dict[@"inviteTimeOutMilliSecond"]=@(_inviteTimeOutMilliSecond);

dict[@"isVideo"]=@(_isVideo);

dict[@"sessionId"]=@(_sessionId);

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"oooFee"]=@(_oooFee);

dict[@"feeCoin"]=@(_feeCoin);

dict[@"hostUid"]=@(_hostUid);

dict[@"videoUrl"]=_videoUrl;

dict[@"freeCallDuration"]=@(_freeCallDuration);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"whetherToPay"]=@(_whetherToPay);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOInviteRetModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOInviteRetModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOInviteRetModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOInviteRetModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOInviteRetModel* sumMdl=[OOOInviteRetModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOInviteRetModel*)getFromDict:(NSDictionary*)dict
{
OOOInviteRetModel* model=[[OOOInviteRetModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userStatus=[dict[@"userStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"userStatus"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.feeUid=[dict[@"feeUid"] isKindOfClass:[NSNull class]]?0:[dict[@"feeUid"] longLongValue];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.videoImg=[dict[@"videoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"videoImg"];

model.inviteTimeOutMilliSecond=[dict[@"inviteTimeOutMilliSecond"] isKindOfClass:[NSNull class]]?0:[dict[@"inviteTimeOutMilliSecond"] longLongValue];

model.isVideo=[dict[@"isVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isVideo"] intValue];

model.sessionId=[dict[@"sessionId"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.oooFee=[dict[@"oooFee"] isKindOfClass:[NSNull class]]?0:[dict[@"oooFee"] doubleValue];

model.feeCoin=[dict[@"feeCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"feeCoin"] doubleValue];

model.hostUid=[dict[@"hostUid"] isKindOfClass:[NSNull class]]?0:[dict[@"hostUid"] longLongValue];

model.videoUrl=[dict[@"videoUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"videoUrl"];

model.freeCallDuration=[dict[@"freeCallDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"freeCallDuration"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.whetherToPay=[dict[@"whetherToPay"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherToPay"] intValue];


 return model;
}

 +(void)cloneObj:(OOOInviteRetModel*) source target:(OOOInviteRetModel*)target
{

target.userStatus=source.userStatus;

target.thumb=source.thumb;

target.feeUid=source.feeUid;

target.groupId=source.groupId;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.videoImg=source.videoImg;

target.inviteTimeOutMilliSecond=source.inviteTimeOutMilliSecond;

target.isVideo=source.isVideo;

target.sessionId=source.sessionId;

target.userName=source.userName;

target.userId=source.userId;

target.oooFee=source.oooFee;

target.feeCoin=source.feeCoin;

target.hostUid=source.hostUid;

target.videoUrl=source.videoUrl;

target.freeCallDuration=source.freeCallDuration;

target.nobleGrade=source.nobleGrade;

target.whetherToPay=source.whetherToPay;

}

@end

