//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserDtoModel.h"




 @implementation AppUserDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"nobleGradeName"]=_nobleGradeName;

dict[@"agentId"]=@(_agentId);

dict[@"isOOOAccount"]=@(_isOOOAccount);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"role"]=@(_role);

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"groupId"]=@(_groupId);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"pid"]=@(_pid);

dict[@"readShortVideoNumber"]=@(_readShortVideoNumber);

dict[@"isJoinJg"]=@(_isJoinJg);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userid"]=@(_userid);

dict[@"totalAmountCash"]=@(_totalAmountCash);

dict[@"regType"]=@(_regType);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"amount"]=@(_amount);

dict[@"votestotal"]=@(_votestotal);

dict[@"userGrade"]=@(_userGrade);

dict[@"sex"]=@(_sex);

dict[@"avatar"]=_avatar;

dict[@"managerId"]=@(_managerId);

dict[@"guildId"]=@(_guildId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"totalAmount"]=@(_totalAmount);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"totalCharge"]=@(_totalCharge);

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"inviteCode"]=_inviteCode;

dict[@"votes"]=@(_votes);

dict[@"managerCoId"]=@(_managerCoId);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"isSvip"]=@(_isSvip);

dict[@"age"]=@(_age);

dict[@"goodnum"]=_goodnum;

dict[@"coin"]=@(_coin);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserDtoModel* sumMdl=[AppUserDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserDtoModel*)getFromDict:(NSDictionary*)dict
{
AppUserDtoModel* model=[[AppUserDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.nobleGradeName=[dict[@"nobleGradeName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeName"];

model.agentId=[dict[@"agentId"] isKindOfClass:[NSNull class]]?0:[dict[@"agentId"] longLongValue];

model.isOOOAccount=[dict[@"isOOOAccount"] isKindOfClass:[NSNull class]]?0:[dict[@"isOOOAccount"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.groupId=[dict[@"groupId"] isKindOfClass:[NSNull class]]?0:[dict[@"groupId"] longLongValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.pid=[dict[@"pid"] isKindOfClass:[NSNull class]]?0:[dict[@"pid"] longLongValue];

model.readShortVideoNumber=[dict[@"readShortVideoNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"readShortVideoNumber"] intValue];

model.isJoinJg=[dict[@"isJoinJg"] isKindOfClass:[NSNull class]]?0:[dict[@"isJoinJg"] intValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.totalAmountCash=[dict[@"totalAmountCash"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmountCash"] doubleValue];

model.regType=[dict[@"regType"] isKindOfClass:[NSNull class]]?0:[dict[@"regType"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.votestotal=[dict[@"votestotal"] isKindOfClass:[NSNull class]]?0:[dict[@"votestotal"] doubleValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.managerId=[dict[@"managerId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerId"] longLongValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.totalCharge=[dict[@"totalCharge"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCharge"] doubleValue];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"wealthGrade"] intValue];

model.inviteCode=[dict[@"inviteCode"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteCode"];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.managerCoId=[dict[@"managerCoId"] isKindOfClass:[NSNull class]]?0:[dict[@"managerCoId"] longLongValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.isSvip=[dict[@"isSvip"] isKindOfClass:[NSNull class]]?0:[dict[@"isSvip"] intValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(AppUserDtoModel*) source target:(AppUserDtoModel*)target
{

target.nobleGradeName=source.nobleGradeName;

target.agentId=source.agentId;

target.isOOOAccount=source.isOOOAccount;

target.anchorGrade=source.anchorGrade;

target.role=source.role;

target.city=source.city;

target.signature=source.signature;

target.groupId=source.groupId;

target.userGradeImg=source.userGradeImg;

target.pid=source.pid;

target.readShortVideoNumber=source.readShortVideoNumber;

target.isJoinJg=source.isJoinJg;

target.nobleGradeImg=source.nobleGradeImg;

target.userid=source.userid;

target.totalAmountCash=source.totalAmountCash;

target.regType=source.regType;

target.wealthGradeImg=source.wealthGradeImg;

target.amount=source.amount;

target.votestotal=source.votestotal;

target.userGrade=source.userGrade;

target.sex=source.sex;

target.avatar=source.avatar;

target.managerId=source.managerId;

target.guildId=source.guildId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.totalAmount=source.totalAmount;

target.anchorGradeImg=source.anchorGradeImg;

target.totalCharge=source.totalCharge;

target.wealthGrade=source.wealthGrade;

target.inviteCode=source.inviteCode;

target.votes=source.votes;

target.managerCoId=source.managerCoId;

target.nobleGrade=source.nobleGrade;

target.isSvip=source.isSvip;

target.age=source.age;

target.goodnum=source.goodnum;

target.coin=source.coin;

target.username=source.username;

}

@end

