//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiLightSenderModel.h"




 @implementation ApiLightSenderModel  


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

dict[@"liangName"]=_liangName;

dict[@"vipType"]=@(_vipType);

dict[@"guardType"]=@(_guardType);

dict[@"code"]=@(_code);

dict[@"msg"]=_msg;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLightSenderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiLightSenderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiLightSenderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiLightSenderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiLightSenderModel* sumMdl=[ApiLightSenderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiLightSenderModel*)getFromDict:(NSDictionary*)dict
{
ApiLightSenderModel* model=[[ApiLightSenderModel alloc]init];

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

model.liangName=[dict[@"liangName"] isKindOfClass:[NSNull class]]?@"":dict[@"liangName"];

model.vipType=[dict[@"vipType"] isKindOfClass:[NSNull class]]?0:[dict[@"vipType"] intValue];

model.guardType=[dict[@"guardType"] isKindOfClass:[NSNull class]]?0:[dict[@"guardType"] intValue];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];


 return model;
}

 +(void)cloneObj:(ApiLightSenderModel*) source target:(ApiLightSenderModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.roomId=source.roomId;

target.userName=source.userName;

target.uid=source.uid;

target.content=source.content;

target.level=source.level;

target.time=source.time;

target.heart=source.heart;

target.liangName=source.liangName;

target.vipType=source.vipType;

target.guardType=source.guardType;

target.code=source.code;

target.msg=source.msg;

}

@end

