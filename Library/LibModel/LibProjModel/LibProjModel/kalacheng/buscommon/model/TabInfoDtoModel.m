//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TabInfoDtoModel.h"




 @implementation TabInfoDtoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"tabTypeId"]=@(_tabTypeId);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"desr"]=_desr;

dict[@"fontColor"]=_fontColor;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TabInfoDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TabInfoDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TabInfoDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TabInfoDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TabInfoDtoModel* sumMdl=[TabInfoDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TabInfoDtoModel*)getFromDict:(NSDictionary*)dict
{
TabInfoDtoModel* model=[[TabInfoDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.tabTypeId=[dict[@"tabTypeId"] isKindOfClass:[NSNull class]]?0:[dict[@"tabTypeId"] longLongValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];

model.fontColor=[dict[@"fontColor"] isKindOfClass:[NSNull class]]?@"":dict[@"fontColor"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(TabInfoDtoModel*) source target:(TabInfoDtoModel*)target
{

target.tabTypeId=source.tabTypeId;

target.name=source.name;

target.id_field=source.id_field;

target.sort=source.sort;

target.desr=source.desr;

target.fontColor=source.fontColor;

target.status=source.status;

}

@end

