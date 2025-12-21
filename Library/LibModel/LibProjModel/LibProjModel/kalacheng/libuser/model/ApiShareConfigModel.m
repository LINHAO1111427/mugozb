//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShareConfigModel.h"




 @implementation ApiShareConfigModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"shareTitle"]=_shareTitle;

dict[@"logo"]=_logo;

dict[@"shareDes"]=_shareDes;

dict[@"url"]=_url;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShareConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShareConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShareConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShareConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShareConfigModel* sumMdl=[ApiShareConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShareConfigModel*)getFromDict:(NSDictionary*)dict
{
ApiShareConfigModel* model=[[ApiShareConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.shareTitle=[dict[@"shareTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"shareTitle"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.shareDes=[dict[@"shareDes"] isKindOfClass:[NSNull class]]?@"":dict[@"shareDes"];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];


 return model;
}

 +(void)cloneObj:(ApiShareConfigModel*) source target:(ApiShareConfigModel*)target
{

target.shareTitle=source.shareTitle;

target.logo=source.logo;

target.shareDes=source.shareDes;

target.url=source.url;

}

@end

