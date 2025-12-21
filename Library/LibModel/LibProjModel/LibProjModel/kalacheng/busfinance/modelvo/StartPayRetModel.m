//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "StartPayRetModel.h"




 @implementation StartPayRetModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"scanUrl"]=_scanUrl;

dict[@"orderId"]=_orderId;

dict[@"appid"]=_appid;

dict[@"iosPayId"]=_iosPayId;

dict[@"WXPayInfo"]=_WXPayInfo;

dict[@"aliPayInfo"]=_aliPayInfo;

dict[@"originalId"]=_originalId;

dict[@"url"]=_url;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<StartPayRetModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
StartPayRetModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<StartPayRetModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<StartPayRetModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StartPayRetModel* sumMdl=[StartPayRetModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(StartPayRetModel*)getFromDict:(NSDictionary*)dict
{
StartPayRetModel* model=[[StartPayRetModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.scanUrl=[dict[@"scanUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"scanUrl"];

model.orderId=[dict[@"orderId"] isKindOfClass:[NSNull class]]?@"":dict[@"orderId"];

model.appid=[dict[@"appid"] isKindOfClass:[NSNull class]]?@"":dict[@"appid"];

model.iosPayId=[dict[@"iosPayId"] isKindOfClass:[NSNull class]]?@"":dict[@"iosPayId"];

model.WXPayInfo=[dict[@"WXPayInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"WXPayInfo"];

model.aliPayInfo=[dict[@"aliPayInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"aliPayInfo"];

model.originalId=[dict[@"originalId"] isKindOfClass:[NSNull class]]?@"":dict[@"originalId"];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];


 return model;
}

 +(void)cloneObj:(StartPayRetModel*) source target:(StartPayRetModel*)target
{

target.scanUrl=source.scanUrl;

target.orderId=source.orderId;

target.appid=source.appid;

target.iosPayId=source.iosPayId;

target.WXPayInfo=source.WXPayInfo;

target.aliPayInfo=source.aliPayInfo;

target.originalId=source.originalId;

target.url=source.url;

}

@end

