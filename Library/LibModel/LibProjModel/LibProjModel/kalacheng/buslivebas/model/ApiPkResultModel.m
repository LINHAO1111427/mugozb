//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiPkResultModel.h"




 @implementation ApiPkResultModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"anchorId"]=@(_anchorId);

dict[@"votesPK"]=@(_votesPK);

dict[@"toVotesPK"]=@(_toVotesPK);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPkResultModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiPkResultModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiPkResultModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiPkResultModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiPkResultModel* sumMdl=[ApiPkResultModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiPkResultModel*)getFromDict:(NSDictionary*)dict
{
ApiPkResultModel* model=[[ApiPkResultModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.votesPK=[dict[@"votesPK"] isKindOfClass:[NSNull class]]?0:[dict[@"votesPK"] doubleValue];

model.toVotesPK=[dict[@"toVotesPK"] isKindOfClass:[NSNull class]]?0:[dict[@"toVotesPK"] doubleValue];


 return model;
}

 +(void)cloneObj:(ApiPkResultModel*) source target:(ApiPkResultModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.anchorId=source.anchorId;

target.votesPK=source.votesPK;

target.toVotesPK=source.toVotesPK;

}

@end

