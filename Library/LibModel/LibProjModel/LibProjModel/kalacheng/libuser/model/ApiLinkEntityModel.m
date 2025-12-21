//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLinkEntityModel.h"




 @implementation ApiLinkEntityModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"sessionID"]=@(_sessionID);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLinkEntityModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLinkEntityModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLinkEntityModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLinkEntityModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLinkEntityModel* sumMdl=[ApiLinkEntityModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLinkEntityModel*)getFromDict:(NSDictionary*)dict
{
ApiLinkEntityModel* model=[[ApiLinkEntityModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.sessionID=[dict[@"sessionID"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionID"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiLinkEntityModel*) source target:(ApiLinkEntityModel*)target
{

target.sessionID=source.sessionID;

}

@end

