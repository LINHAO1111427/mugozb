//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiQinuRespModel.h"




 @implementation ApiQinuRespModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"fileName"]=_fileName;

dict[@"rootPath"]=_rootPath;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiQinuRespModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiQinuRespModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiQinuRespModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiQinuRespModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiQinuRespModel* sumMdl=[ApiQinuRespModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiQinuRespModel*)getFromDict:(NSDictionary*)dict
{
ApiQinuRespModel* model=[[ApiQinuRespModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.fileName=[dict[@"fileName"] isKindOfClass:[NSNull class]]?@"":dict[@"fileName"];

model.rootPath=[dict[@"rootPath"] isKindOfClass:[NSNull class]]?@"":dict[@"rootPath"];


 return model;
}

 +(void)cloneObj:(ApiQinuRespModel*) source target:(ApiQinuRespModel*)target
{

target.fileName=source.fileName;

target.rootPath=source.rootPath;

}

@end

