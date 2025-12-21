//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "TelevisionVideoTypeVOModel.h"




 @implementation TelevisionVideoTypeVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"sequence"]=@(_sequence);

dict[@"id"]=@(_id_field);

dict[@"televisionVideoTypeName"]=_televisionVideoTypeName;

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoTypeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
TelevisionVideoTypeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<TelevisionVideoTypeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<TelevisionVideoTypeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
TelevisionVideoTypeVOModel* sumMdl=[TelevisionVideoTypeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(TelevisionVideoTypeVOModel*)getFromDict:(NSDictionary*)dict
{
TelevisionVideoTypeVOModel* model=[[TelevisionVideoTypeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.sequence=[dict[@"sequence"] isKindOfClass:[NSNull class]]?0:[dict[@"sequence"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.televisionVideoTypeName=[dict[@"televisionVideoTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"televisionVideoTypeName"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(TelevisionVideoTypeVOModel*) source target:(TelevisionVideoTypeVOModel*)target
{

target.sequence=source.sequence;

target.id_field=source.id_field;

target.televisionVideoTypeName=source.televisionVideoTypeName;

target.isEnable=source.isEnable;

}

@end

