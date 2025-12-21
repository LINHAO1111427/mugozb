//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LivePkConfigurationVOModel.h"




 @implementation LivePkConfigurationVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"pkTime"]=@(_pkTime);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LivePkConfigurationVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LivePkConfigurationVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LivePkConfigurationVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LivePkConfigurationVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LivePkConfigurationVOModel* sumMdl=[LivePkConfigurationVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LivePkConfigurationVOModel*)getFromDict:(NSDictionary*)dict
{
LivePkConfigurationVOModel* model=[[LivePkConfigurationVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.pkTime=[dict[@"pkTime"] isKindOfClass:[NSNull class]]?0:[dict[@"pkTime"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] intValue];


 return model;
}

 +(void)cloneObj:(LivePkConfigurationVOModel*) source target:(LivePkConfigurationVOModel*)target
{

target.pkTime=source.pkTime;

target.id_field=source.id_field;

}

@end

