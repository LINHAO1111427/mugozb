//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOLiveRoomTextChatDataModel.h"




 @implementation OOOLiveRoomTextChatDataModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"firstTime"]=[HttpClient stringFromDate:_firstTime];

dict[@"userMsgFlag"]=_userMsgFlag;

dict[@"knowDay"]=@(_knowDay);

dict[@"hostUid"]=@(_hostUid);

dict[@"feeUid"]=@(_feeUid);

dict[@"hotNumber"]=@(_hotNumber);

dict[@"chatNumber"]=@(_chatNumber);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveRoomTextChatDataModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOLiveRoomTextChatDataModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOLiveRoomTextChatDataModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOLiveRoomTextChatDataModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOLiveRoomTextChatDataModel* sumMdl=[OOOLiveRoomTextChatDataModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOLiveRoomTextChatDataModel*)getFromDict:(NSDictionary*)dict
{
OOOLiveRoomTextChatDataModel* model=[[OOOLiveRoomTextChatDataModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"firstTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.firstTime=date;
    }
}

model.userMsgFlag=[dict[@"userMsgFlag"] isKindOfClass:[NSNull class]]?@"":dict[@"userMsgFlag"];

model.knowDay=[dict[@"knowDay"] isKindOfClass:[NSNull class]]?0:[dict[@"knowDay"] intValue];

model.hostUid=[dict[@"hostUid"] isKindOfClass:[NSNull class]]?0:[dict[@"hostUid"] longLongValue];

model.feeUid=[dict[@"feeUid"] isKindOfClass:[NSNull class]]?0:[dict[@"feeUid"] longLongValue];

model.hotNumber=[dict[@"hotNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"hotNumber"] intValue];

model.chatNumber=[dict[@"chatNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"chatNumber"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(OOOLiveRoomTextChatDataModel*) source target:(OOOLiveRoomTextChatDataModel*)target
{

target.firstTime=source.firstTime;

target.userMsgFlag=source.userMsgFlag;

target.knowDay=source.knowDay;

target.hostUid=source.hostUid;

target.feeUid=source.feeUid;

target.hotNumber=source.hotNumber;

target.chatNumber=source.chatNumber;

target.id_field=source.id_field;

}

@end

