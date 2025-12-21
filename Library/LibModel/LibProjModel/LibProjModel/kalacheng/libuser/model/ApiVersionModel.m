//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiVersionModel.h"




 @implementation ApiVersionModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"des"]=_des;

dict[@"isConstraint"]=@(_isConstraint);

dict[@"versionNo"]=_versionNo;

dict[@"url"]=_url;

dict[@"versionCode"]=@(_versionCode);

dict[@"shareAddress"]=_shareAddress;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiVersionModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiVersionModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiVersionModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiVersionModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiVersionModel* sumMdl=[ApiVersionModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiVersionModel*)getFromDict:(NSDictionary*)dict
{
ApiVersionModel* model=[[ApiVersionModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.des=[dict[@"des"] isKindOfClass:[NSNull class]]?@"":dict[@"des"];

model.isConstraint=[dict[@"isConstraint"] isKindOfClass:[NSNull class]]?0:[dict[@"isConstraint"] intValue];

model.versionNo=[dict[@"versionNo"] isKindOfClass:[NSNull class]]?@"":dict[@"versionNo"];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];

model.versionCode=[dict[@"versionCode"] isKindOfClass:[NSNull class]]?0:[dict[@"versionCode"] intValue];

model.shareAddress=[dict[@"shareAddress"] isKindOfClass:[NSNull class]]?@"":dict[@"shareAddress"];


 return model;
}

 +(void)cloneObj:(ApiVersionModel*) source target:(ApiVersionModel*)target
{

target.des=source.des;

target.isConstraint=source.isConstraint;

target.versionNo=source.versionNo;

target.url=source.url;

target.versionCode=source.versionCode;

target.shareAddress=source.shareAddress;

}

@end

