//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SingleStringModel.h"




 @implementation SingleStringModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"value"]=_value;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SingleStringModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SingleStringModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SingleStringModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SingleStringModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SingleStringModel* sumMdl=[SingleStringModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SingleStringModel*)getFromDict:(NSDictionary*)dict
{
SingleStringModel* model=[[SingleStringModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.value=[dict[@"value"] isKindOfClass:[NSNull class]]?@"":dict[@"value"];


 return model;
}

 +(void)cloneObj:(SingleStringModel*) source target:(SingleStringModel*)target
{

target.value=source.value;

}

@end

