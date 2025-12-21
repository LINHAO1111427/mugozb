//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiKickLiveModel.h"




 @implementation ApiKickLiveModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"roomId"]=@(_roomId);

dict[@"uid"]=@(_uid);

dict[@"touid"]=@(_touid);

dict[@"toUserName"]=_toUserName;

dict[@"content"]=_content;

dict[@"watchNumber"]=@(_watchNumber);

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiKickLiveModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiKickLiveModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiKickLiveModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiKickLiveModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiKickLiveModel* sumMdl=[ApiKickLiveModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiKickLiveModel*)getFromDict:(NSDictionary*)dict
{
ApiKickLiveModel* model=[[ApiKickLiveModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.touid=[dict[@"touid"] isKindOfClass:[NSNull class]]?0:[dict[@"touid"] longLongValue];

model.toUserName=[dict[@"toUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"toUserName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.watchNumber=[dict[@"watchNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"watchNumber"] intValue];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiKickLiveModel*) source target:(ApiKickLiveModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.uid=source.uid;

target.touid=source.touid;

target.toUserName=source.toUserName;

target.content=source.content;

target.watchNumber=source.watchNumber;

target.code=source.code;

target.msg=source.msg;

}

@end

