//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOLiveRoomNoAnswerDtoModel.h"




 @implementation OOOLiveRoomNoAnswerDtoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"uid"]=@(_uid);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"onlineStatus"]=@(_onlineStatus);

dict[@"timeStr"]=_timeStr;

dict[@"audienceId"]=@(_audienceId);

dict[@"avatar"]=_avatar;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);

dict[@"poster"]=_poster;

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOLiveRoomNoAnswerDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOLiveRoomNoAnswerDtoModel* sumMdl=[OOOLiveRoomNoAnswerDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOLiveRoomNoAnswerDtoModel*)getFromDict:(NSDictionary*)dict
{
OOOLiveRoomNoAnswerDtoModel* model=[[OOOLiveRoomNoAnswerDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.onlineStatus=[dict[@"onlineStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"onlineStatus"] intValue];

model.timeStr=[dict[@"timeStr"] isKindOfClass:[NSNull class]]?@"":dict[@"timeStr"];

model.audienceId=[dict[@"audienceId"] isKindOfClass:[NSNull class]]?0:[dict[@"audienceId"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(OOOLiveRoomNoAnswerDtoModel*) source target:(OOOLiveRoomNoAnswerDtoModel*)target
{

target.uid=source.uid;

target.createTime=source.createTime;

target.onlineStatus=source.onlineStatus;

target.timeStr=source.timeStr;

target.audienceId=source.audienceId;

target.avatar=source.avatar;

target.id_field=source.id_field;

target.type=source.type;

target.poster=source.poster;

target.username=source.username;

}

@end

