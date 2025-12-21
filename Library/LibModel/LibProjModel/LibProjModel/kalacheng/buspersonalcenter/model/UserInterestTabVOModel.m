//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInterestTabVOModel.h"




 @implementation UserInterestTabVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"fontColor"]=_fontColor;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInterestTabVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInterestTabVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInterestTabVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInterestTabVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInterestTabVOModel* sumMdl=[UserInterestTabVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInterestTabVOModel*)getFromDict:(NSDictionary*)dict
{
UserInterestTabVOModel* model=[[UserInterestTabVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.fontColor=[dict[@"fontColor"] isKindOfClass:[NSNull class]]?@"":dict[@"fontColor"];


 return model;
}

 +(void)cloneObj:(UserInterestTabVOModel*) source target:(UserInterestTabVOModel*)target
{

target.name=source.name;

target.id_field=source.id_field;

target.fontColor=source.fontColor;

}

@end

