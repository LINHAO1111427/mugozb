//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLiveEffectVOModel.h"




 @implementation AppLiveEffectVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"effectImg"]=_effectImg;

dict[@"effectUrl"]=_effectUrl;

dict[@"id"]=@(_id_field);

dict[@"effectName"]=_effectName;

dict[@"isEnable"]=@(_isEnable);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveEffectVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLiveEffectVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLiveEffectVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLiveEffectVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveEffectVOModel* sumMdl=[AppLiveEffectVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLiveEffectVOModel*)getFromDict:(NSDictionary*)dict
{
AppLiveEffectVOModel* model=[[AppLiveEffectVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.effectImg=[dict[@"effectImg"] isKindOfClass:[NSNull class]]?@"":dict[@"effectImg"];

model.effectUrl=[dict[@"effectUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"effectUrl"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.effectName=[dict[@"effectName"] isKindOfClass:[NSNull class]]?@"":dict[@"effectName"];

model.isEnable=[dict[@"isEnable"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnable"] intValue];


 return model;
}

 +(void)cloneObj:(AppLiveEffectVOModel*) source target:(AppLiveEffectVOModel*)target
{

target.effectImg=source.effectImg;

target.effectUrl=source.effectUrl;

target.id_field=source.id_field;

target.effectName=source.effectName;

target.isEnable=source.isEnable;

}

@end

