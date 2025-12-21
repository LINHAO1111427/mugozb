//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSendMsgRoomModel.h"




 @implementation ApiSendMsgRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"userName"]=_userName;

dict[@"uid"]=@(_uid);

dict[@"content"]=_content;

dict[@"level"]=_level;

dict[@"time"]=@(_time);

dict[@"heart"]=@(_heart);

dict[@"type"]=@(_type);

dict[@"liangName"]=_liangName;

dict[@"vipType"]=@(_vipType);

dict[@"guardType"]=@(_guardType);

dict[@"manager"]=@(_manager);

dict[@"liveNiceName"]=_liveNiceName;

dict[@"liveFunction"]=@(_liveFunction);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendMsgRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSendMsgRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSendMsgRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSendMsgRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSendMsgRoomModel* sumMdl=[ApiSendMsgRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSendMsgRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiSendMsgRoomModel* model=[[ApiSendMsgRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.level=[dict[@"level"] isKindOfClass:[NSNull class]]?@"":dict[@"level"];

model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?0:[dict[@"time"] intValue];

model.heart=[dict[@"heart"] isKindOfClass:[NSNull class]]?0:[dict[@"heart"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.liangName=[dict[@"liangName"] isKindOfClass:[NSNull class]]?@"":dict[@"liangName"];

model.vipType=[dict[@"vipType"] isKindOfClass:[NSNull class]]?0:[dict[@"vipType"] intValue];

model.guardType=[dict[@"guardType"] isKindOfClass:[NSNull class]]?0:[dict[@"guardType"] intValue];

model.manager=[dict[@"manager"] isKindOfClass:[NSNull class]]?0:[dict[@"manager"] intValue];

model.liveNiceName=[dict[@"liveNiceName"] isKindOfClass:[NSNull class]]?@"":dict[@"liveNiceName"];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];


 return model;
}

 +(void)cloneObj:(ApiSendMsgRoomModel*) source target:(ApiSendMsgRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.userName=source.userName;

target.uid=source.uid;

target.content=source.content;

target.level=source.level;

target.time=source.time;

target.heart=source.heart;

target.type=source.type;

target.liangName=source.liangName;

target.vipType=source.vipType;

target.guardType=source.guardType;

target.manager=source.manager;

target.liveNiceName=source.liveNiceName;

target.liveFunction=source.liveFunction;

}

@end

