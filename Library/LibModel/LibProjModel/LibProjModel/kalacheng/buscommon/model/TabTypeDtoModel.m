//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TabTypeDtoModel.h"
#import "TabInfoDtoModel.h"




 @implementation TabTypeDtoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"tabInfoList" : [TabInfoDtoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"name"]=_name;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_tabInfoList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
TabInfoDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"tabInfoList"]=list;
}//end

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"desr"]=_desr;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TabTypeDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TabTypeDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TabTypeDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TabTypeDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TabTypeDtoModel* sumMdl=[TabTypeDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TabTypeDtoModel*)getFromDict:(NSDictionary*)dict
{
TabTypeDtoModel* model=[[TabTypeDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.tabInfoList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"tabInfoList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TabInfoDtoModel* sumMdl=[TabInfoDtoModel getFromDict:subDic];
[model.tabInfoList addObject:sumMdl];

}
}

}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];


 return model;
}

 +(void)cloneObj:(TabTypeDtoModel*) source target:(TabTypeDtoModel*)target
{

target.name=source.name;

        if(source.tabInfoList==nil)
        {
//            target.tabInfoList=nil;
        }else
        {
            target.tabInfoList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.tabInfoList.count;i++)
            {
		  [target.tabInfoList addObject:[[TabInfoDtoModel alloc]init]];
            [TabInfoDtoModel cloneObj:source.tabInfoList[i] target:target.tabInfoList[i]];
            }
        }


target.id_field=source.id_field;

target.sort=source.sort;

target.desr=source.desr;

}

@end

