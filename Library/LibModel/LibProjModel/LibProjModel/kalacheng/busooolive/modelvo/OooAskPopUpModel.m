//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OooAskPopUpModel.h"




 @implementation OooAskPopUpModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"userId"]=@(_userId);

dict[@"nextExecuteDate"]=@(_nextExecuteDate);

dict[@"executeStatus"]=@(_executeStatus);

dict[@"toDayNum"]=@(_toDayNum);

dict[@"chatType"]=@(_chatType);

dict[@"feeId"]=@(_feeId);

dict[@"oooChannelId"]=@(_oooChannelId);

dict[@"showAvatar"]=_showAvatar;

dict[@"showTitle"]=_showTitle;

dict[@"showDescribe"]=_showDescribe;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooAskPopUpModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OooAskPopUpModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OooAskPopUpModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OooAskPopUpModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OooAskPopUpModel* sumMdl=[OooAskPopUpModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OooAskPopUpModel*)getFromDict:(NSDictionary*)dict
{
OooAskPopUpModel* model=[[OooAskPopUpModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nextExecuteDate=[dict[@"nextExecuteDate"] isKindOfClass:[NSNull class]]?0:[dict[@"nextExecuteDate"] longLongValue];

model.executeStatus=[dict[@"executeStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"executeStatus"] intValue];

model.toDayNum=[dict[@"toDayNum"] isKindOfClass:[NSNull class]]?0:[dict[@"toDayNum"] intValue];

model.chatType=[dict[@"chatType"] isKindOfClass:[NSNull class]]?0:[dict[@"chatType"] intValue];

model.feeId=[dict[@"feeId"] isKindOfClass:[NSNull class]]?0:[dict[@"feeId"] longLongValue];

model.oooChannelId=[dict[@"oooChannelId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooChannelId"] longLongValue];

model.showAvatar=[dict[@"showAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"showAvatar"];

model.showTitle=[dict[@"showTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"showTitle"];

model.showDescribe=[dict[@"showDescribe"] isKindOfClass:[NSNull class]]?@"":dict[@"showDescribe"];


 return model;
}

 +(void)cloneObj:(OooAskPopUpModel*) source target:(OooAskPopUpModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.userId=source.userId;

target.nextExecuteDate=source.nextExecuteDate;

target.executeStatus=source.executeStatus;

target.toDayNum=source.toDayNum;

target.chatType=source.chatType;

target.feeId=source.feeId;

target.oooChannelId=source.oooChannelId;

target.showAvatar=source.showAvatar;

target.showTitle=source.showTitle;

target.showDescribe=source.showDescribe;

}

@end

