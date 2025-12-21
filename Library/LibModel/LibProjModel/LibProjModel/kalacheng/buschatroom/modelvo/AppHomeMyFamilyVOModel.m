//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeMyFamilyVOModel.h"
#import "AppHomeFamilyUserVOModel.h"




 @implementation AppHomeMyFamilyVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appHomeFamilyUserVOList" : [AppHomeFamilyUserVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyRole"]=@(_familyRole);

dict[@"familyIcon"]=_familyIcon;

dict[@"patriarchName"]=_patriarchName;

dict[@"familyDescription"]=_familyDescription;

dict[@"checkRemark"]=_checkRemark;

dict[@"familyGradeIcon"]=_familyGradeIcon;

dict[@"familyDayRating"]=@(_familyDayRating);

dict[@"familyId"]=@(_familyId);


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

dict[@"familyName"]=_familyName;

dict[@"familyNumber"]=@(_familyNumber);

dict[@"patriarchId"]=@(_patriarchId);

dict[@"familyGrade"]=@(_familyGrade);

dict[@"familyStatus"]=@(_familyStatus);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeMyFamilyVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeMyFamilyVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeMyFamilyVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeMyFamilyVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeMyFamilyVOModel* sumMdl=[AppHomeMyFamilyVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeMyFamilyVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeMyFamilyVOModel* model=[[AppHomeMyFamilyVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyRole=[dict[@"familyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"familyRole"] intValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.patriarchName=[dict[@"patriarchName"] isKindOfClass:[NSNull class]]?@"":dict[@"patriarchName"];

model.familyDescription=[dict[@"familyDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"familyDescription"];

model.checkRemark=[dict[@"checkRemark"] isKindOfClass:[NSNull class]]?@"":dict[@"checkRemark"];

model.familyGradeIcon=[dict[@"familyGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyGradeIcon"];

model.familyDayRating=[dict[@"familyDayRating"] isKindOfClass:[NSNull class]]?0:[dict[@"familyDayRating"] doubleValue];

model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

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

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyNumber=[dict[@"familyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNumber"] intValue];

model.patriarchId=[dict[@"patriarchId"] isKindOfClass:[NSNull class]]?0:[dict[@"patriarchId"] longLongValue];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.familyStatus=[dict[@"familyStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"familyStatus"] intValue];


 return model;
}

 +(void)cloneObj:(AppHomeMyFamilyVOModel*) source target:(AppHomeMyFamilyVOModel*)target
{

target.familyRole=source.familyRole;

target.familyIcon=source.familyIcon;

target.patriarchName=source.patriarchName;

target.familyDescription=source.familyDescription;

target.checkRemark=source.checkRemark;

target.familyGradeIcon=source.familyGradeIcon;

target.familyDayRating=source.familyDayRating;

target.familyId=source.familyId;

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


target.familyName=source.familyName;

target.familyNumber=source.familyNumber;

target.patriarchId=source.patriarchId;

target.familyGrade=source.familyGrade;

target.familyStatus=source.familyStatus;

}

@end

