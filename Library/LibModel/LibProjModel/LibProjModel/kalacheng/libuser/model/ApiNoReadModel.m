//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiNoReadModel.h"




 @implementation ApiNoReadModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"totalNoRead"]=@(_totalNoRead);

dict[@"shortVideoNoRead"]=@(_shortVideoNoRead);

dict[@"systemNoRead"]=@(_systemNoRead);

dict[@"officialNewsNoRead"]=@(_officialNewsNoRead);

dict[@"videoNoRead"]=@(_videoNoRead);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiNoReadModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiNoReadModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiNoReadModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiNoReadModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiNoReadModel* sumMdl=[ApiNoReadModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiNoReadModel*)getFromDict:(NSDictionary*)dict
{
ApiNoReadModel* model=[[ApiNoReadModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.totalNoRead=[dict[@"totalNoRead"] isKindOfClass:[NSNull class]]?0:[dict[@"totalNoRead"] longLongValue];

model.shortVideoNoRead=[dict[@"shortVideoNoRead"] isKindOfClass:[NSNull class]]?0:[dict[@"shortVideoNoRead"] longLongValue];

model.systemNoRead=[dict[@"systemNoRead"] isKindOfClass:[NSNull class]]?0:[dict[@"systemNoRead"] longLongValue];

model.officialNewsNoRead=[dict[@"officialNewsNoRead"] isKindOfClass:[NSNull class]]?0:[dict[@"officialNewsNoRead"] longLongValue];

model.videoNoRead=[dict[@"videoNoRead"] isKindOfClass:[NSNull class]]?0:[dict[@"videoNoRead"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiNoReadModel*) source target:(ApiNoReadModel*)target
{

target.totalNoRead=source.totalNoRead;

target.shortVideoNoRead=source.shortVideoNoRead;

target.systemNoRead=source.systemNoRead;

target.officialNewsNoRead=source.officialNewsNoRead;

target.videoNoRead=source.videoNoRead;

}

@end

