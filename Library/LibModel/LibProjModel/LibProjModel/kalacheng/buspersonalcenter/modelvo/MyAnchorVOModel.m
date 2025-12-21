//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MyAnchorVOModel.h"




 @implementation MyAnchorVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"anchorAuditStatus"]=@(_anchorAuditStatus);

dict[@"role"]=@(_role);

dict[@"anchorAuditReason"]=_anchorAuditReason;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyAnchorVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MyAnchorVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MyAnchorVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MyAnchorVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MyAnchorVOModel* sumMdl=[MyAnchorVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MyAnchorVOModel*)getFromDict:(NSDictionary*)dict
{
MyAnchorVOModel* model=[[MyAnchorVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.anchorAuditStatus=[dict[@"anchorAuditStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorAuditStatus"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.anchorAuditReason=[dict[@"anchorAuditReason"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAuditReason"];


 return model;
}

 +(void)cloneObj:(MyAnchorVOModel*) source target:(MyAnchorVOModel*)target
{

target.anchorAuditStatus=source.anchorAuditStatus;

target.role=source.role;

target.anchorAuditReason=source.anchorAuditReason;

}

@end

