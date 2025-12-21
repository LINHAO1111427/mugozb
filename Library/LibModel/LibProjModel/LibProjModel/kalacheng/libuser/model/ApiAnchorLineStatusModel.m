//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiAnchorLineStatusModel.h"




 @implementation ApiAnchorLineStatusModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"status"]=@(_status);

dict[@"roomId"]=@(_roomId);

dict[@"uid"]=@(_uid);

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiAnchorLineStatusModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiAnchorLineStatusModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiAnchorLineStatusModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiAnchorLineStatusModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiAnchorLineStatusModel* sumMdl=[ApiAnchorLineStatusModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiAnchorLineStatusModel*)getFromDict:(NSDictionary*)dict
{
ApiAnchorLineStatusModel* model=[[ApiAnchorLineStatusModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiAnchorLineStatusModel*) source target:(ApiAnchorLineStatusModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.status=source.status;

target.roomId=source.roomId;

target.uid=source.uid;

target.code=source.code;

target.msg=source.msg;

}

@end

