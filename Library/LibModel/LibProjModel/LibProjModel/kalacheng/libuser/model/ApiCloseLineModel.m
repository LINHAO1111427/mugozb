//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiCloseLineModel.h"




 @implementation ApiCloseLineModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"toRoomId"]=@(_toRoomId);

dict[@"uid"]=@(_uid);

dict[@"touid"]=@(_touid);

dict[@"conetnt"]=_conetnt;

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCloseLineModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiCloseLineModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiCloseLineModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiCloseLineModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiCloseLineModel* sumMdl=[ApiCloseLineModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiCloseLineModel*)getFromDict:(NSDictionary*)dict
{
ApiCloseLineModel* model=[[ApiCloseLineModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.toRoomId=[dict[@"toRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"toRoomId"] longLongValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.touid=[dict[@"touid"] isKindOfClass:[NSNull class]]?0:[dict[@"touid"] longLongValue];

model.conetnt=[dict[@"conetnt"] isKindOfClass:[NSNull class]]?@"":dict[@"conetnt"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiCloseLineModel*) source target:(ApiCloseLineModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.toRoomId=source.toRoomId;

target.uid=source.uid;

target.touid=source.touid;

target.conetnt=source.conetnt;

target.code=source.code;

target.msg=source.msg;

}

@end

