//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSendLineMsgRoomModel.h"




 @implementation ApiSendLineMsgRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"status"]=@(_status);

dict[@"toRoomId"]=@(_toRoomId);

dict[@"toUid"]=@(_toUid);

dict[@"no"]=@(_no);

dict[@"uid"]=@(_uid);

dict[@"toAvatar"]=_toAvatar;

dict[@"toName"]=_toName;

dict[@"toPull"]=_toPull;

dict[@"toLiveThumb"]=_toLiveThumb;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendLineMsgRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSendLineMsgRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSendLineMsgRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSendLineMsgRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSendLineMsgRoomModel* sumMdl=[ApiSendLineMsgRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSendLineMsgRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiSendLineMsgRoomModel* model=[[ApiSendLineMsgRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.toRoomId=[dict[@"toRoomId"] isKindOfClass:[NSNull class]]?0:[dict[@"toRoomId"] longLongValue];

model.toUid=[dict[@"toUid"] isKindOfClass:[NSNull class]]?0:[dict[@"toUid"] longLongValue];

model.no=[dict[@"no"] isKindOfClass:[NSNull class]]?0:[dict[@"no"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.toAvatar=[dict[@"toAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"toAvatar"];

model.toName=[dict[@"toName"] isKindOfClass:[NSNull class]]?@"":dict[@"toName"];

model.toPull=[dict[@"toPull"] isKindOfClass:[NSNull class]]?@"":dict[@"toPull"];

model.toLiveThumb=[dict[@"toLiveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"toLiveThumb"];


 return model;
}

 +(void)cloneObj:(ApiSendLineMsgRoomModel*) source target:(ApiSendLineMsgRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.status=source.status;

target.toRoomId=source.toRoomId;

target.toUid=source.toUid;

target.no=source.no;

target.uid=source.uid;

target.toAvatar=source.toAvatar;

target.toName=source.toName;

target.toPull=source.toPull;

target.toLiveThumb=source.toLiveThumb;

}

@end

