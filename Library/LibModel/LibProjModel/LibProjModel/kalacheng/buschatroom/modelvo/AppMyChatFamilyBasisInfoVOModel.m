//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMyChatFamilyBasisInfoVOModel.h"




 @implementation AppMyChatFamilyBasisInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyId"]=@(_familyId);

dict[@"familyName"]=_familyName;

dict[@"familyGrade"]=@(_familyGrade);

dict[@"familyIcon"]=_familyIcon;

dict[@"familyGradeIcon"]=_familyGradeIcon;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMyChatFamilyBasisInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMyChatFamilyBasisInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMyChatFamilyBasisInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMyChatFamilyBasisInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMyChatFamilyBasisInfoVOModel* sumMdl=[AppMyChatFamilyBasisInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMyChatFamilyBasisInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AppMyChatFamilyBasisInfoVOModel* model=[[AppMyChatFamilyBasisInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.familyGradeIcon=[dict[@"familyGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyGradeIcon"];


 return model;
}

 +(void)cloneObj:(AppMyChatFamilyBasisInfoVOModel*) source target:(AppMyChatFamilyBasisInfoVOModel*)target
{

target.familyId=source.familyId;

target.familyName=source.familyName;

target.familyGrade=source.familyGrade;

target.familyIcon=source.familyIcon;

target.familyGradeIcon=source.familyGradeIcon;

}

@end

