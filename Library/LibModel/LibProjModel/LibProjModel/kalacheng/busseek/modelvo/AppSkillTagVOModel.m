//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSkillTagVOModel.h"




 @implementation AppSkillTagVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"skillTypeId"]=@(_skillTypeId);

dict[@"skillTagName"]=_skillTagName;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSkillTagVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSkillTagVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSkillTagVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSkillTagVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSkillTagVOModel* sumMdl=[AppSkillTagVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSkillTagVOModel*)getFromDict:(NSDictionary*)dict
{
AppSkillTagVOModel* model=[[AppSkillTagVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.skillTypeId=[dict[@"skillTypeId"] isKindOfClass:[NSNull class]]?0:[dict[@"skillTypeId"] longLongValue];

model.skillTagName=[dict[@"skillTagName"] isKindOfClass:[NSNull class]]?@"":dict[@"skillTagName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(AppSkillTagVOModel*) source target:(AppSkillTagVOModel*)target
{

target.skillTypeId=source.skillTypeId;

target.skillTagName=source.skillTagName;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

}

@end

