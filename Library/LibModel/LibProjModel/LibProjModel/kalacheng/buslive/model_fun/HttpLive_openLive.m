//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "HttpLive_openLive.h"




  @implementation HttpLive_openLive  


 +(NSMutableArray<HttpLive_openLive*>*)getFromArr:(NSArray*)list
{
NSMutableArray<HttpLive_openLive*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
HttpLive_openLive* sumMdl=[HttpLive_openLive getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(HttpLive_openLive*)getFromDict:(NSDictionary*)dict
{
HttpLive_openLive* model=[[HttpLive_openLive alloc]init];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.province=[dict[@"province"] isKindOfClass:[NSNull class]]?@"":dict[@"province"];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.shopRoomLabel=[dict[@"shopRoomLabel"] isKindOfClass:[NSNull class]]?@"":dict[@"shopRoomLabel"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];


 return model;
}

@end

