//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "DynamicController_publishDynamic.h"




  @implementation DynamicController_publishDynamic  


 +(NSMutableArray<DynamicController_publishDynamic*>*)getFromArr:(NSArray*)list
{
NSMutableArray<DynamicController_publishDynamic*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
DynamicController_publishDynamic* sumMdl=[DynamicController_publishDynamic getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(DynamicController_publishDynamic*)getFromDict:(NSDictionary*)dict
{
DynamicController_publishDynamic* model=[[DynamicController_publishDynamic alloc]init];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.hidePublishingAddress=[dict[@"hidePublishingAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"hidePublishingAddress"] intValue];

model.href=[dict[@"href"] isKindOfClass:[NSNull class]]?@"":dict[@"href"];

model.images=[dict[@"images"] isKindOfClass:[NSNull class]]?@"":dict[@"images"];

model.isPrivate=[dict[@"isPrivate"] isKindOfClass:[NSNull class]]?0:[dict[@"isPrivate"] intValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.musicId=[dict[@"musicId"] isKindOfClass:[NSNull class]]?0:[dict[@"musicId"] longLongValue];

model.sourceFrom=[dict[@"sourceFrom"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceFrom"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.topicId=[dict[@"topicId"] isKindOfClass:[NSNull class]]?0:[dict[@"topicId"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.videoTime=[dict[@"videoTime"] isKindOfClass:[NSNull class]]?@"":dict[@"videoTime"];

model.width=[dict[@"width"] isKindOfClass:[NSNull class]]?0:[dict[@"width"] intValue];


 return model;
}

@end

