//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiBaseEntityModel.h"




 @implementation ApiBaseEntityModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"msg"]=_msg;

dict[@"code"]=@(_code);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiBaseEntityModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiBaseEntityModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiBaseEntityModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiBaseEntityModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiBaseEntityModel* sumMdl=[ApiBaseEntityModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiBaseEntityModel*)getFromDict:(NSDictionary*)dict
{
ApiBaseEntityModel* model=[[ApiBaseEntityModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];


 return model;
}

 +(void)cloneObj:(ApiBaseEntityModel*) source target:(ApiBaseEntityModel*)target
{

target.msg=source.msg;

target.code=source.code;

}

@end

