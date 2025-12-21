//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeFamilyUserVOModel.h"




 @implementation AppHomeFamilyUserVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyRole"]=@(_familyRole);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"isItBanned"]=@(_isItBanned);

dict[@"applyReason"]=_applyReason;

dict[@"familyDayContribution"]=@(_familyDayContribution);

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"familyDayIncome"]=@(_familyDayIncome);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"familyTotalIncome"]=@(_familyTotalIncome);

dict[@"gradeImg"]=_gradeImg;

dict[@"familyTotalContribution"]=@(_familyTotalContribution);

dict[@"age"]=@(_age);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeFamilyUserVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeFamilyUserVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeFamilyUserVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeFamilyUserVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeFamilyUserVOModel* sumMdl=[AppHomeFamilyUserVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeFamilyUserVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeFamilyUserVOModel* model=[[AppHomeFamilyUserVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyRole=[dict[@"familyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"familyRole"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.isItBanned=[dict[@"isItBanned"] isKindOfClass:[NSNull class]]?0:[dict[@"isItBanned"] intValue];

model.applyReason=[dict[@"applyReason"] isKindOfClass:[NSNull class]]?@"":dict[@"applyReason"];

model.familyDayContribution=[dict[@"familyDayContribution"] isKindOfClass:[NSNull class]]?0:[dict[@"familyDayContribution"] doubleValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.familyDayIncome=[dict[@"familyDayIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"familyDayIncome"] doubleValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.familyTotalIncome=[dict[@"familyTotalIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalIncome"] doubleValue];

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.familyTotalContribution=[dict[@"familyTotalContribution"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalContribution"] doubleValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];


 return model;
}

 +(void)cloneObj:(AppHomeFamilyUserVOModel*) source target:(AppHomeFamilyUserVOModel*)target
{

target.familyRole=source.familyRole;

target.wealthGradeImg=source.wealthGradeImg;

target.isItBanned=source.isItBanned;

target.applyReason=source.applyReason;

target.familyDayContribution=source.familyDayContribution;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.nobleMedal=source.nobleMedal;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.familyDayIncome=source.familyDayIncome;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.familyTotalIncome=source.familyTotalIncome;

target.gradeImg=source.gradeImg;

target.familyTotalContribution=source.familyTotalContribution;

target.age=source.age;

}

@end

