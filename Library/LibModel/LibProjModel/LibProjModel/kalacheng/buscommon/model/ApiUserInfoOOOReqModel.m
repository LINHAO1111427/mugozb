//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserInfoOOOReqModel.h"




 @implementation ApiUserInfoOOOReqModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"avatar"]=_avatar;

dict[@"userId"]=@(_userId);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoOOOReqModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserInfoOOOReqModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserInfoOOOReqModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserInfoOOOReqModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoOOOReqModel* sumMdl=[ApiUserInfoOOOReqModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserInfoOOOReqModel*)getFromDict:(NSDictionary*)dict
{
ApiUserInfoOOOReqModel* model=[[ApiUserInfoOOOReqModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiUserInfoOOOReqModel*) source target:(ApiUserInfoOOOReqModel*)target
{

target.onlineStatus=source.onlineStatus;

target.avatar=source.avatar;

target.userId=source.userId;

target.username=source.username;

}

@end

