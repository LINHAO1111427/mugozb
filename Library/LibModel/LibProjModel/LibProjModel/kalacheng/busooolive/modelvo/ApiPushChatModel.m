//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiPushChatModel.h"




 @implementation ApiPushChatModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"userGradeImg"]=_userGradeImg;

dict[@"avatar"]=_avatar;

dict[@"sessionID"]=@(_sessionID);

dict[@"anchorId"]=@(_anchorId);

dict[@"feeId"]=@(_feeId);

dict[@"userId"]=@(_userId);

dict[@"search"]=_search;

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"oooChannelId"]=@(_oooChannelId);

dict[@"id"]=@(_id_field);

dict[@"chatType"]=@(_chatType);

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);

dict[@"userNobleImg"]=_userNobleImg;

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPushChatModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiPushChatModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiPushChatModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiPushChatModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiPushChatModel* sumMdl=[ApiPushChatModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiPushChatModel*)getFromDict:(NSDictionary*)dict
{
ApiPushChatModel* model=[[ApiPushChatModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.sessionID=[dict[@"sessionID"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionID"] longLongValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.feeId=[dict[@"feeId"] isKindOfClass:[NSNull class]]?0:[dict[@"feeId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.search=[dict[@"search"] isKindOfClass:[NSNull class]]?@"":dict[@"search"];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.oooChannelId=[dict[@"oooChannelId"] isKindOfClass:[NSNull class]]?0:[dict[@"oooChannelId"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.chatType=[dict[@"chatType"] isKindOfClass:[NSNull class]]?0:[dict[@"chatType"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.userNobleImg=[dict[@"userNobleImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userNobleImg"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiPushChatModel*) source target:(ApiPushChatModel*)target
{

target.onlineStatus=source.onlineStatus;

target.userGradeImg=source.userGradeImg;

target.avatar=source.avatar;

target.sessionID=source.sessionID;

target.anchorId=source.anchorId;

target.feeId=source.feeId;

target.userId=source.userId;

target.search=source.search;

target.createTime=source.createTime;

target.oooChannelId=source.oooChannelId;

target.id_field=source.id_field;

target.chatType=source.chatType;

target.coin=source.coin;

target.status=source.status;

target.userNobleImg=source.userNobleImg;

target.username=source.username;

}

@end

