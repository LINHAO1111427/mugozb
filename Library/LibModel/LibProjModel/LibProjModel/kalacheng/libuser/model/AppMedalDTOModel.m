//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMedalDTOModel.h"




 @implementation AppMedalDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"medalLogo"]=_medalLogo;

dict[@"name"]=_name;

dict[@"lv"]=@(_lv);

dict[@"desr"]=_desr;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMedalDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMedalDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMedalDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMedalDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMedalDTOModel* sumMdl=[AppMedalDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMedalDTOModel*)getFromDict:(NSDictionary*)dict
{
AppMedalDTOModel* model=[[AppMedalDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.medalLogo=[dict[@"medalLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"medalLogo"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.lv=[dict[@"lv"] isKindOfClass:[NSNull class]]?0:[dict[@"lv"] intValue];

model.desr=[dict[@"desr"] isKindOfClass:[NSNull class]]?@"":dict[@"desr"];


 return model;
}

 +(void)cloneObj:(AppMedalDTOModel*) source target:(AppMedalDTOModel*)target
{

target.medalLogo=source.medalLogo;

target.name=source.name;

target.lv=source.lv;

target.desr=source.desr;

}

@end

