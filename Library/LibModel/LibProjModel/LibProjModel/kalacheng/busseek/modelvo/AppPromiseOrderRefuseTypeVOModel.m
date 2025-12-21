//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppPromiseOrderRefuseTypeVOModel.h"




 @implementation AppPromiseOrderRefuseTypeVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"refuseTypeName"]=_refuseTypeName;

dict[@"id"]=@(_id_field);

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderRefuseTypeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppPromiseOrderRefuseTypeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppPromiseOrderRefuseTypeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppPromiseOrderRefuseTypeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppPromiseOrderRefuseTypeVOModel* sumMdl=[AppPromiseOrderRefuseTypeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppPromiseOrderRefuseTypeVOModel*)getFromDict:(NSDictionary*)dict
{
AppPromiseOrderRefuseTypeVOModel* model=[[AppPromiseOrderRefuseTypeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.refuseTypeName=[dict[@"refuseTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"refuseTypeName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(AppPromiseOrderRefuseTypeVOModel*) source target:(AppPromiseOrderRefuseTypeVOModel*)target
{

target.refuseTypeName=source.refuseTypeName;

target.id_field=source.id_field;

target.isEnable=source.isEnable;

}

@end

