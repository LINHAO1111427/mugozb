//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeChatPlazaVOModel.h"




 @implementation AppHomeChatPlazaVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyId"]=@(_familyId);

dict[@"lastMsgJson"]=_lastMsgJson;

dict[@"familyName"]=_familyName;

dict[@"familyNumber"]=@(_familyNumber);

dict[@"familyGrade"]=@(_familyGrade);

dict[@"realTimeNumber"]=@(_realTimeNumber);

dict[@"familyIcon"]=_familyIcon;

dict[@"familyDescription"]=_familyDescription;

dict[@"familyGradeIcon"]=_familyGradeIcon;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatPlazaVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeChatPlazaVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeChatPlazaVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeChatPlazaVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeChatPlazaVOModel* sumMdl=[AppHomeChatPlazaVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeChatPlazaVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeChatPlazaVOModel* model=[[AppHomeChatPlazaVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.lastMsgJson=[dict[@"lastMsgJson"] isKindOfClass:[NSNull class]]?@"":dict[@"lastMsgJson"];

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyNumber=[dict[@"familyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNumber"] intValue];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.realTimeNumber=[dict[@"realTimeNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"realTimeNumber"] longLongValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.familyDescription=[dict[@"familyDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"familyDescription"];

model.familyGradeIcon=[dict[@"familyGradeIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyGradeIcon"];


 return model;
}

 +(void)cloneObj:(AppHomeChatPlazaVOModel*) source target:(AppHomeChatPlazaVOModel*)target
{

target.familyId=source.familyId;

target.lastMsgJson=source.lastMsgJson;

target.familyName=source.familyName;

target.familyNumber=source.familyNumber;

target.familyGrade=source.familyGrade;

target.realTimeNumber=source.realTimeNumber;

target.familyIcon=source.familyIcon;

target.familyDescription=source.familyDescription;

target.familyGradeIcon=source.familyGradeIcon;

}

@end

