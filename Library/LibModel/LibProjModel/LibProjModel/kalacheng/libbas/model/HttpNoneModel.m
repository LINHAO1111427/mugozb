//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "HttpNoneModel.h"




 @implementation HttpNoneModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"no_use"]=_no_use;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<HttpNoneModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
HttpNoneModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<HttpNoneModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<HttpNoneModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
HttpNoneModel* sumMdl=[HttpNoneModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(HttpNoneModel*)getFromDict:(NSDictionary*)dict
{
HttpNoneModel* model=[[HttpNoneModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.no_use=[dict[@"no_use"] isKindOfClass:[NSNull class]]?@"":dict[@"no_use"];


 return model;
}

 +(void)cloneObj:(HttpNoneModel*) source target:(HttpNoneModel*)target
{

target.no_use=source.no_use;

}

@end

