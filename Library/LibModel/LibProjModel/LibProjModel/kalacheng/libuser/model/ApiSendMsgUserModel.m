//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSendMsgUserModel.h"




 @implementation ApiSendMsgUserModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"userId"]=@(_userId);

dict[@"roomId"]=@(_roomId);

dict[@"userName"]=_userName;

dict[@"content"]=_content;

dict[@"line_time"]=@(_line_time);

dict[@"avatar"]=_avatar;

dict[@"type"]=@(_type);

dict[@"sessionID"]=@(_sessionID);

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendMsgUserModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSendMsgUserModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSendMsgUserModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSendMsgUserModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSendMsgUserModel* sumMdl=[ApiSendMsgUserModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSendMsgUserModel*)getFromDict:(NSDictionary*)dict
{
ApiSendMsgUserModel* model=[[ApiSendMsgUserModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.line_time=[dict[@"line_time"] isKindOfClass:[NSNull class]]?0:[dict[@"line_time"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.sessionID=[dict[@"sessionID"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionID"] longLongValue];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiSendMsgUserModel*) source target:(ApiSendMsgUserModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.userId=source.userId;

target.roomId=source.roomId;

target.userName=source.userName;

target.content=source.content;

target.line_time=source.line_time;

target.avatar=source.avatar;

target.type=source.type;

target.sessionID=source.sessionID;

target.code=source.code;

target.msg=source.msg;

}

@end

