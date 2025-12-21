//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppFamilyUserRankVOModel.h"




 @implementation AppFamilyUserRankVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"sex"]=@(_sex);

dict[@"userAvatar"]=_userAvatar;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"userRank"]=@(_userRank);

dict[@"userName"]=_userName;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"userId"]=@(_userId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"familyTotalIncome"]=@(_familyTotalIncome);

dict[@"gradeImg"]=_gradeImg;

dict[@"familyTotalContribution"]=@(_familyTotalContribution);

dict[@"age"]=@(_age);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppFamilyUserRankVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppFamilyUserRankVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppFamilyUserRankVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppFamilyUserRankVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppFamilyUserRankVOModel* sumMdl=[AppFamilyUserRankVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppFamilyUserRankVOModel*)getFromDict:(NSDictionary*)dict
{
AppFamilyUserRankVOModel* model=[[AppFamilyUserRankVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.userRank=[dict[@"userRank"] isKindOfClass:[NSNull class]]?0:[dict[@"userRank"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.familyTotalIncome=[dict[@"familyTotalIncome"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalIncome"] doubleValue];

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.familyTotalContribution=[dict[@"familyTotalContribution"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalContribution"] doubleValue];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];


 return model;
}

 +(void)cloneObj:(AppFamilyUserRankVOModel*) source target:(AppFamilyUserRankVOModel*)target
{

target.wealthGradeImg=source.wealthGradeImg;

target.sex=source.sex;

target.userAvatar=source.userAvatar;

target.nobleMedal=source.nobleMedal;

target.userRank=source.userRank;

target.userName=source.userName;

target.nobleGradeImg=source.nobleGradeImg;

target.userId=source.userId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.familyTotalIncome=source.familyTotalIncome;

target.gradeImg=source.gradeImg;

target.familyTotalContribution=source.familyTotalContribution;

target.age=source.age;

}

@end

