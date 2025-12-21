//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiExitRoomModel.h"




 @implementation ApiExitRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"roomType"]=@(_roomType);

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"roomName"]=_roomName;

dict[@"conetnt"]=_conetnt;

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiExitRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiExitRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiExitRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiExitRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiExitRoomModel* sumMdl=[ApiExitRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiExitRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiExitRoomModel* model=[[ApiExitRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.roomName=[dict[@"roomName"] isKindOfClass:[NSNull class]]?@"":dict[@"roomName"];

model.conetnt=[dict[@"conetnt"] isKindOfClass:[NSNull class]]?@"":dict[@"conetnt"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiExitRoomModel*) source target:(ApiExitRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.roomType=source.roomType;

target.roomTypeVal=source.roomTypeVal;

target.roomName=source.roomName;

target.conetnt=source.conetnt;

target.code=source.code;

target.msg=source.msg;

}

@end

