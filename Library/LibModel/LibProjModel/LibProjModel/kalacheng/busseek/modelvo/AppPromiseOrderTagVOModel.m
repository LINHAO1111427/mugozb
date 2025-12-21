//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppPromiseOrderTagVOModel.h"




 @implementation AppPromiseOrderTagVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"promiseTagName"]=_promiseTagName;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderTagVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppPromiseOrderTagVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppPromiseOrderTagVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppPromiseOrderTagVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppPromiseOrderTagVOModel* sumMdl=[AppPromiseOrderTagVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppPromiseOrderTagVOModel*)getFromDict:(NSDictionary*)dict
{
AppPromiseOrderTagVOModel* model=[[AppPromiseOrderTagVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.promiseTagName=[dict[@"promiseTagName"] isKindOfClass:[NSNull class]]?@"":dict[@"promiseTagName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppPromiseOrderTagVOModel*) source target:(AppPromiseOrderTagVOModel*)target
{

target.promiseTagName=source.promiseTagName;

target.id_field=source.id_field;

}

@end

