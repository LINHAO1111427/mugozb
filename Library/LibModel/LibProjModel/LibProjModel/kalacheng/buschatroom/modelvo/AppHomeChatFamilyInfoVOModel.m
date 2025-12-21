//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeChatFamilyInfoVOModel.h"
#import "AppHomeFamilyUserVOModel.h"




 @implementation AppHomeChatFamilyInfoVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appHomeFamilyCheckUserVOList" : [AppHomeFamilyUserVOModel class],@"appHomeFamilyUserVOList" : [AppHomeFamilyUserVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appHomeFamilyCheckUserVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHomeFamilyUserVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appHomeFamilyCheckUserVOList"]=list;
}//end

dict[@"totalRating"]=@(_totalRating);

dict[@"familyIcon"]=_familyIcon;

dict[@"familyDescription"]=_familyDescription;

dict[@"familyGradeIcon"]=_familyGradeIcon;

dict[@"myFamilyRole"]=@(_myFamilyRole);

dict[@"familyId"]=@(_familyId);

dict[@"isApply"]=@(_isApply);

dict[@"isMyChatFamily"]=@(_isMyChatFamily);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appHomeFamilyUserVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHomeFamilyUserVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appHomeFamilyUserVOList"]=list;
}//end

dict[@"familyNextGradeStartVal"]=@(_familyNextGradeStartVal);

dict[@"joinFamilyCoin"]=@(_joinFamilyCoin);

dict[@"familyName"]=_familyName;

dict[@"familyNumber"]=@(_familyNumber);

dict[@"familyGrade"]=@(_familyGrade);

dict[@"familyNextGrade"]=@(_familyNextGrade);

dict[@"familyTotalRating"]=@(_familyTotalRating);

dict[@"familyProclamation"]=_familyProclamation;

dict[@"weekRating"]=@(_weekRating);

dict[@"familyCheckNumber"]=@(_familyCheckNumber);

dict[@"familyStatus"]=@(_familyStatus);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatFamilyInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeChatFamilyInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeChatFamilyInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeChatFamilyInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeChatFamilyInfoVOModel* sumMdl=[AppHomeChatFamilyInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeChatFamilyInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeChatFamilyInfoVOModel* model=[[AppHomeChatFamilyInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.appHomeFamilyCheckUserVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appHomeFamilyCheckUserVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeFamilyUserVOModel* sumMdl=[AppHomeFamilyUserVOModel getFromDict:subDic];
[model.appHomeFamilyCheckUserVOList addObject:sumMdl];

}
}

}

model.totalRating=[dict[@"totalRating"] isKindOfClass:[NSNull class]]?0:[dict[@"totalRating"] intValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.familyDescription=[dict[@"familyDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"familyDescription"];

model.familyGradeIcon=[dict[@"familyGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyGradeIcon"];

model.myFamilyRole=[dict[@"myFamilyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"myFamilyRole"] intValue];

model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.isApply=[dict[@"isApply"] isKindOfClass:[NSNull class]]?0:[dict[@"isApply"] longLongValue];

model.isMyChatFamily=[dict[@"isMyChatFamily"] isKindOfClass:[NSNull class]]?0:[dict[@"isMyChatFamily"] intValue];

model.appHomeFamilyUserVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appHomeFamilyUserVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeFamilyUserVOModel* sumMdl=[AppHomeFamilyUserVOModel getFromDict:subDic];
[model.appHomeFamilyUserVOList addObject:sumMdl];

}
}

}

model.familyNextGradeStartVal=[dict[@"familyNextGradeStartVal"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNextGradeStartVal"] doubleValue];

model.joinFamilyCoin=[dict[@"joinFamilyCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"joinFamilyCoin"] doubleValue];

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyNumber=[dict[@"familyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNumber"] intValue];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.familyNextGrade=[dict[@"familyNextGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNextGrade"] intValue];

model.familyTotalRating=[dict[@"familyTotalRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyTotalRating"] doubleValue];

model.familyProclamation=[dict[@"familyProclamation"] isKindOfClass:[NSNull class]]?@"":dict[@"familyProclamation"];

model.weekRating=[dict[@"weekRating"] isKindOfClass:[NSNull class]]?0:[dict[@"weekRating"] intValue];

model.familyCheckNumber=[dict[@"familyCheckNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyCheckNumber"] intValue];

model.familyStatus=[dict[@"familyStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"familyStatus"] intValue];


 return model;
}

 +(void)cloneObj:(AppHomeChatFamilyInfoVOModel*) source target:(AppHomeChatFamilyInfoVOModel*)target
{

        if(source.appHomeFamilyCheckUserVOList==nil)
        {
//            target.appHomeFamilyCheckUserVOList=nil;
        }else
        {
            target.appHomeFamilyCheckUserVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appHomeFamilyCheckUserVOList.count;i++)
            {
		  [target.appHomeFamilyCheckUserVOList addObject:[[AppHomeFamilyUserVOModel alloc]init]];
            [AppHomeFamilyUserVOModel cloneObj:source.appHomeFamilyCheckUserVOList[i] target:target.appHomeFamilyCheckUserVOList[i]];
            }
        }


target.totalRating=source.totalRating;

target.familyIcon=source.familyIcon;

target.familyDescription=source.familyDescription;

target.familyGradeIcon=source.familyGradeIcon;

target.myFamilyRole=source.myFamilyRole;

target.familyId=source.familyId;

target.isApply=source.isApply;

target.isMyChatFamily=source.isMyChatFamily;

        if(source.appHomeFamilyUserVOList==nil)
        {
//            target.appHomeFamilyUserVOList=nil;
        }else
        {
            target.appHomeFamilyUserVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appHomeFamilyUserVOList.count;i++)
            {
		  [target.appHomeFamilyUserVOList addObject:[[AppHomeFamilyUserVOModel alloc]init]];
            [AppHomeFamilyUserVOModel cloneObj:source.appHomeFamilyUserVOList[i] target:target.appHomeFamilyUserVOList[i]];
            }
        }


target.familyNextGradeStartVal=source.familyNextGradeStartVal;

target.joinFamilyCoin=source.joinFamilyCoin;

target.familyName=source.familyName;

target.familyNumber=source.familyNumber;

target.familyGrade=source.familyGrade;

target.familyNextGrade=source.familyNextGrade;

target.familyTotalRating=source.familyTotalRating;

target.familyProclamation=source.familyProclamation;

target.weekRating=source.weekRating;

target.familyCheckNumber=source.familyCheckNumber;

target.familyStatus=source.familyStatus;

}

@end

