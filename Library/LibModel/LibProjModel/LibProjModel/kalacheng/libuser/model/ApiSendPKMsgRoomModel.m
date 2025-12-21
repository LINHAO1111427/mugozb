//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSendPKMsgRoomModel.h"




 @implementation ApiSendPKMsgRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"status"]=@(_status);

dict[@"toRoomId"]=@(_toRoomId);

dict[@"toUid"]=@(_toUid);

dict[@"toPull"]=_toPull;

dict[@"toLiveThumb"]=_toLiveThumb;

dict[@"pkTime"]=@(_pkTime);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendPKMsgRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSendPKMsgRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSendPKMsgRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSendPKMsgRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSendPKMsgRoomModel* sumMdl=[ApiSendPKMsgRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSendPKMsgRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiSendPKMsgRoomModel* model=[[ApiSendPKMsgRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.toRoomId=[dict[@"toRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"toRoomId"] longLongValue];

model.toUid=[dict[@"toUid"] isKindOfClass:[NSNull class]]?0:[dict[@"toUid"] longLongValue];

model.toPull=[dict[@"toPull"] isKindOfClass:[NSNull class]]?@"":dict[@"toPull"];

model.toLiveThumb=[dict[@"toLiveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"toLiveThumb"];

model.pkTime=[dict[@"pkTime"] isKindOfClass:[NSNull class]]?0:[dict[@"pkTime"] intValue];


 return model;
}

 +(void)cloneObj:(ApiSendPKMsgRoomModel*) source target:(ApiSendPKMsgRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.status=source.status;

target.toRoomId=source.toRoomId;

target.toUid=source.toUid;

target.toPull=source.toPull;

target.toLiveThumb=source.toLiveThumb;

target.pkTime=source.pkTime;

}

@end

