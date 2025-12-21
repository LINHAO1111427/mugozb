//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSkillTypeVOModel.h"




 @implementation AppSkillTypeVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"skillDescription"]=_skillDescription;

dict[@"skillName"]=_skillName;

dict[@"highestPrice"]=@(_highestPrice);

dict[@"isRecommend"]=@(_isRecommend);

dict[@"lowestPrice"]=@(_lowestPrice);

dict[@"recommendHighestPrice"]=@(_recommendHighestPrice);

dict[@"id"]=@(_id_field);

dict[@"skillImage"]=_skillImage;

dict[@"classifyDescription"]=_classifyDescription;

dict[@"classifyImage"]=_classifyImage;

dict[@"isEnable"]=@(_isEnable);

dict[@"recommendLowestPrice"]=@(_recommendLowestPrice);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSkillTypeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSkillTypeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSkillTypeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSkillTypeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSkillTypeVOModel* sumMdl=[AppSkillTypeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSkillTypeVOModel*)getFromDict:(NSDictionary*)dict
{
AppSkillTypeVOModel* model=[[AppSkillTypeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.skillDescription=[dict[@"skillDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"skillDescription"];

model.skillName=[dict[@"skillName"] isKindOfClass:[NSNull class]]?@"":dict[@"skillName"];

model.highestPrice=[dict[@"highestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"highestPrice"] doubleValue];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.lowestPrice=[dict[@"lowestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"lowestPrice"] doubleValue];

model.recommendHighestPrice=[dict[@"recommendHighestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"recommendHighestPrice"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.skillImage=[dict[@"skillImage"] isKindOfClass:[NSNull class]]?@"":dict[@"skillImage"];

model.classifyDescription=[dict[@"classifyDescription"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyDescription"];

model.classifyImage=[dict[@"classifyImage"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyImage"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];

model.recommendLowestPrice=[dict[@"recommendLowestPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"recommendLowestPrice"] doubleValue];


 return model;
}

 +(void)cloneObj:(AppSkillTypeVOModel*) source target:(AppSkillTypeVOModel*)target
{

target.skillDescription=source.skillDescription;

target.skillName=source.skillName;

target.highestPrice=source.highestPrice;

target.isRecommend=source.isRecommend;

target.lowestPrice=source.lowestPrice;

target.recommendHighestPrice=source.recommendHighestPrice;

target.id_field=source.id_field;

target.skillImage=source.skillImage;

target.classifyDescription=source.classifyDescription;

target.classifyImage=source.classifyImage;

target.isEnable=source.isEnable;

target.recommendLowestPrice=source.recommendLowestPrice;

}

@end

