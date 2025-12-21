//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSendPushChatVOModel.h"




 @implementation AppSendPushChatVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"pushShowContent"]=_pushShowContent;

dict[@"pushMusic"]=_pushMusic;

dict[@"oooAskWait"]=_oooAskWait;

dict[@"sessionId"]=@(_sessionId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSendPushChatVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSendPushChatVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSendPushChatVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSendPushChatVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSendPushChatVOModel* sumMdl=[AppSendPushChatVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSendPushChatVOModel*)getFromDict:(NSDictionary*)dict
{
AppSendPushChatVOModel* model=[[AppSendPushChatVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.pushShowContent=[dict[@"pushShowContent"] isKindOfClass:[NSNull class]]?@"":dict[@"pushShowContent"];

model.pushMusic=[dict[@"pushMusic"] isKindOfClass:[NSNull class]]?@"":dict[@"pushMusic"];

model.oooAskWait=[dict[@"oooAskWait"] isKindOfClass:[NSNull class]]?@"":dict[@"oooAskWait"];

model.sessionId=[dict[@"sessionId"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppSendPushChatVOModel*) source target:(AppSendPushChatVOModel*)target
{

target.pushShowContent=source.pushShowContent;

target.pushMusic=source.pushMusic;

target.oooAskWait=source.oooAskWait;

target.sessionId=source.sessionId;

}

@end

