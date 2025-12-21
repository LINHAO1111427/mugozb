//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "HttpVoice_openVoiceLive.h"




  @implementation HttpVoice_openVoiceLive  


 +(NSMutableArray<HttpVoice_openVoiceLive*>*)getFromArr:(NSArray*)list
{
NSMutableArray<HttpVoice_openVoiceLive*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
HttpVoice_openVoiceLive* sumMdl=[HttpVoice_openVoiceLive getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(HttpVoice_openVoiceLive*)getFromDict:(NSDictionary*)dict
{
HttpVoice_openVoiceLive* model=[[HttpVoice_openVoiceLive alloc]init];

model.addr=[dict[@"addr"] isKindOfClass:[NSNull class]]?@"":dict[@"addr"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.upStatus=[dict[@"upStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"upStatus"] intValue];


 return model;
}

@end

