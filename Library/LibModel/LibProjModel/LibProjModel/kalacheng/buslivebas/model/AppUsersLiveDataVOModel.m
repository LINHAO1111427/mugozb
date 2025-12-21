//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUsersLiveDataVOModel.h"




 @implementation AppUsersLiveDataVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addGiftNumber"]=@(_addGiftNumber);

dict[@"rewardNumber"]=@(_rewardNumber);

dict[@"thumb"]=_thumb;

dict[@"liveType"]=@(_liveType);

dict[@"audienceNumber"]=@(_audienceNumber);

dict[@"title"]=_title;

dict[@"roomId"]=@(_roomId);

dict[@"typeDec"]=_typeDec;

dict[@"number"]=@(_number);

dict[@"uid"]=@(_uid);

dict[@"addFansGroup"]=@(_addFansGroup);

dict[@"liveTime"]=@(_liveTime);

dict[@"startTime"]=[HttpClient stringFromDate:_startTime];

dict[@"id"]=@(_id_field);

dict[@"addr"]=_addr;

dict[@"profit"]=@(_profit);

dict[@"roomType"]=@(_roomType);

dict[@"typeVal"]=_typeVal;

dict[@"isPay"]=@(_isPay);

dict[@"addFollow"]=@(_addFollow);

dict[@"rtmpUrl"]=_rtmpUrl;

dict[@"showid"]=_showid;

dict[@"endTime"]=[HttpClient stringFromDate:_endTime];

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersLiveDataVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUsersLiveDataVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUsersLiveDataVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUsersLiveDataVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersLiveDataVOModel* sumMdl=[AppUsersLiveDataVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUsersLiveDataVOModel*)getFromDict:(NSDictionary*)dict
{
AppUsersLiveDataVOModel* model=[[AppUsersLiveDataVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.addGiftNumber=[dict[@"addGiftNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"addGiftNumber"] intValue];

model.rewardNumber=[dict[@"rewardNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"rewardNumber"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.audienceNumber=[dict[@"audienceNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"audienceNumber"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.typeDec=[dict[@"typeDec"] isKindOfClass:[NSNull class]]?@"":dict[@"typeDec"];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.addFansGroup=[dict[@"addFansGroup"] isKindOfClass:[NSNull class]]?0:[dict[@"addFansGroup"] intValue];

model.liveTime=[dict[@"liveTime"] isKindOfClass:[NSNull class]]?0:[dict[@"liveTime"] longLongValue];


{
NSString *strDate= dict[@"startTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.startTime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.addr=[dict[@"addr"] isKindOfClass:[NSNull class]]?@"":dict[@"addr"];

model.profit=[dict[@"profit"] isKindOfClass:[NSNull class]]?0:[dict[@"profit"] doubleValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"typeVal"];

model.isPay=[dict[@"isPay"] isKindOfClass:[NSNull class]]?0:[dict[@"isPay"] intValue];

model.addFollow=[dict[@"addFollow"] isKindOfClass:[NSNull class]]?0:[dict[@"addFollow"] intValue];

model.rtmpUrl=[dict[@"rtmpUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"rtmpUrl"];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];


{
NSString *strDate= dict[@"endTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.endTime=date;
    }
}

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppUsersLiveDataVOModel*) source target:(AppUsersLiveDataVOModel*)target
{

target.addGiftNumber=source.addGiftNumber;

target.rewardNumber=source.rewardNumber;

target.thumb=source.thumb;

target.liveType=source.liveType;

target.audienceNumber=source.audienceNumber;

target.title=source.title;

target.roomId=source.roomId;

target.typeDec=source.typeDec;

target.number=source.number;

target.uid=source.uid;

target.addFansGroup=source.addFansGroup;

target.liveTime=source.liveTime;

target.startTime=source.startTime;

target.id_field=source.id_field;

target.addr=source.addr;

target.profit=source.profit;

target.roomType=source.roomType;

target.typeVal=source.typeVal;

target.isPay=source.isPay;

target.addFollow=source.addFollow;

target.rtmpUrl=source.rtmpUrl;

target.showid=source.showid;

target.endTime=source.endTime;

target.coin=source.coin;

target.status=source.status;

}

@end

