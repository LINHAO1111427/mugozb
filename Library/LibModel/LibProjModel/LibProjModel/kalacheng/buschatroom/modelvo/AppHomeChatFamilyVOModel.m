//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeChatFamilyVOModel.h"




 @implementation AppHomeChatFamilyVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"distance"]=@(_distance);

dict[@"familyRank"]=@(_familyRank);

dict[@"familyIcon"]=_familyIcon;

dict[@"familyDescription"]=_familyDescription;

dict[@"familyWeekRating"]=@(_familyWeekRating);

dict[@"familyGradeIcon"]=_familyGradeIcon;

dict[@"familyDayRating"]=@(_familyDayRating);

dict[@"familyId"]=@(_familyId);

dict[@"familyMonthRating"]=@(_familyMonthRating);

dict[@"isApply"]=@(_isApply);

dict[@"isMyChatFamily"]=@(_isMyChatFamily);

dict[@"joinFamilyCoin"]=@(_joinFamilyCoin);

dict[@"familyName"]=_familyName;

dict[@"familyNumber"]=@(_familyNumber);

dict[@"familyGrade"]=@(_familyGrade);

dict[@"familyTotalRating"]=@(_familyTotalRating);

dict[@"familyCheckNumber"]=@(_familyCheckNumber);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatFamilyVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeChatFamilyVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeChatFamilyVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeChatFamilyVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeChatFamilyVOModel* sumMdl=[AppHomeChatFamilyVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeChatFamilyVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeChatFamilyVOModel* model=[[AppHomeChatFamilyVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.familyRank=[dict[@"familyRank"] isKindOfClass:[NSNull class]]?0:[dict[@"familyRank"] intValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.familyDescription=[dict[@"familyDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"familyDescription"];

model.familyWeekRating=[dict[@"familyWeekRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyWeekRating"] doubleValue];

model.familyGradeIcon=[dict[@"familyGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyGradeIcon"];

model.familyDayRating=[dict[@"familyDayRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyDayRating"] doubleValue];

model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.familyMonthRating=[dict[@"familyMonthRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyMonthRating"] doubleValue];

model.isApply=[dict[@"isApply"] isKindOfClass:[NSNull class]]?0:[dict[@"isApply"] longLongValue];

model.isMyChatFamily=[dict[@"isMyChatFamily"] isKindOfClass:[NSNull class]]?0:[dict[@"isMyChatFamily"] intValue];

model.joinFamilyCoin=[dict[@"joinFamilyCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"joinFamilyCoin"] doubleValue];

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyNumber=[dict[@"familyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNumber"] intValue];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.familyTotalRating=[dict[@"familyTotalRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalRating"] doubleValue];

model.familyCheckNumber=[dict[@"familyCheckNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyCheckNumber"] intValue];


 return model;
}

 +(void)cloneObj:(AppHomeChatFamilyVOModel*) source target:(AppHomeChatFamilyVOModel*)target
{

target.distance=source.distance;

target.familyRank=source.familyRank;

target.familyIcon=source.familyIcon;

target.familyDescription=source.familyDescription;

target.familyWeekRating=source.familyWeekRating;

target.familyGradeIcon=source.familyGradeIcon;

target.familyDayRating=source.familyDayRating;

target.familyId=source.familyId;

target.familyMonthRating=source.familyMonthRating;

target.isApply=source.isApply;

target.isMyChatFamily=source.isMyChatFamily;

target.joinFamilyCoin=source.joinFamilyCoin;

target.familyName=source.familyName;

target.familyNumber=source.familyNumber;

target.familyGrade=source.familyGrade;

target.familyTotalRating=source.familyTotalRating;

target.familyCheckNumber=source.familyCheckNumber;

}

@end

