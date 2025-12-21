//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOORegisterCallVOModel.h"




 @implementation OOORegisterCallVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"registerCallSecond"]=@(_registerCallSecond);

dict[@"registerCallTime"]=@(_registerCallTime);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOORegisterCallVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOORegisterCallVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOORegisterCallVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOORegisterCallVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOORegisterCallVOModel* sumMdl=[OOORegisterCallVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOORegisterCallVOModel*)getFromDict:(NSDictionary*)dict
{
OOORegisterCallVOModel* model=[[OOORegisterCallVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.registerCallSecond=[dict[@"registerCallSecond"] isKindOfClass:[NSNull class]]?0:[dict[@"registerCallSecond"] intValue];

model.registerCallTime=[dict[@"registerCallTime"] isKindOfClass:[NSNull class]]?0:[dict[@"registerCallTime"] intValue];


 return model;
}

 +(void)cloneObj:(OOORegisterCallVOModel*) source target:(OOORegisterCallVOModel*)target
{

target.registerCallSecond=source.registerCallSecond;

target.registerCallTime=source.registerCallTime;

}

@end

