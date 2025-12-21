//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppGradePrivilegeDTOModel.h"




 @implementation AppGradePrivilegeDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"grade"]=@(_grade);

dict[@"name"]=_name;

dict[@"logo"]=_logo;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradePrivilegeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppGradePrivilegeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppGradePrivilegeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppGradePrivilegeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppGradePrivilegeDTOModel* sumMdl=[AppGradePrivilegeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppGradePrivilegeDTOModel*)getFromDict:(NSDictionary*)dict
{
AppGradePrivilegeDTOModel* model=[[AppGradePrivilegeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.grade=[dict[@"grade"] isKindOfClass:[NSNull class]]?0:[dict[@"grade"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];


 return model;
}

 +(void)cloneObj:(AppGradePrivilegeDTOModel*) source target:(AppGradePrivilegeDTOModel*)target
{

target.grade=source.grade;

target.name=source.name;

target.logo=source.logo;

}

@end

