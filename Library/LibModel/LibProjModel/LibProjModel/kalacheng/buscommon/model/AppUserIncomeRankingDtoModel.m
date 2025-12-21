//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserIncomeRankingDtoModel.h"




 @implementation AppUserIncomeRankingDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"serialNumber"]=@(_serialNumber);

dict[@"userGrade"]=@(_userGrade);

dict[@"sex"]=@(_sex);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"avatar"]=_avatar;

dict[@"numberOfInvitations"]=@(_numberOfInvitations);

dict[@"totalTicket"]=@(_totalTicket);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"totalAmount"]=@(_totalAmount);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"isRanking"]=@(_isRanking);

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserIncomeRankingDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserIncomeRankingDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserIncomeRankingDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserIncomeRankingDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserIncomeRankingDtoModel* sumMdl=[AppUserIncomeRankingDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserIncomeRankingDtoModel*)getFromDict:(NSDictionary*)dict
{
AppUserIncomeRankingDtoModel* model=[[AppUserIncomeRankingDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.serialNumber=[dict[@"serialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNumber"] intValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.numberOfInvitations=[dict[@"numberOfInvitations"] isKindOfClass:[NSNull class]]?0:[dict[@"numberOfInvitations"] intValue];

model.totalTicket=[dict[@"totalTicket"] isKindOfClass:[NSNull class]]?0:[dict[@"totalTicket"] doubleValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.isRanking=[dict[@"isRanking"] isKindOfClass:[NSNull class]]?0:[dict[@"isRanking"] intValue];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"wealthGrade"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(AppUserIncomeRankingDtoModel*) source target:(AppUserIncomeRankingDtoModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.anchorGrade=source.anchorGrade;

target.serialNumber=source.serialNumber;

target.userGrade=source.userGrade;

target.sex=source.sex;

target.userGradeImg=source.userGradeImg;

target.avatar=source.avatar;

target.numberOfInvitations=source.numberOfInvitations;

target.totalTicket=source.totalTicket;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.totalAmount=source.totalAmount;

target.anchorGradeImg=source.anchorGradeImg;

target.isRanking=source.isRanking;

target.wealthGrade=source.wealthGrade;

target.nobleGrade=source.nobleGrade;

target.username=source.username;

}

@end

