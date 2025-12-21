//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "AppShortVideo_setShortVideo.h"




  @implementation AppShortVideo_setShortVideo  


 +(NSMutableArray<AppShortVideo_setShortVideo*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppShortVideo_setShortVideo*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppShortVideo_setShortVideo* sumMdl=[AppShortVideo_setShortVideo getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppShortVideo_setShortVideo*)getFromDict:(NSDictionary*)dict
{
AppShortVideo_setShortVideo* model=[[AppShortVideo_setShortVideo alloc]init];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.classifyId=[dict[@"classifyId"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyId"];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.href=[dict[@"href"] isKindOfClass:[NSNull class]]?@"":dict[@"href"];

model.images=[dict[@"images"] isKindOfClass:[NSNull class]]?@"":dict[@"images"];

model.isPrivate=[dict[@"isPrivate"] isKindOfClass:[NSNull class]]?0:[dict[@"isPrivate"] intValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.productId=[dict[@"productId"] isKindOfClass:[NSNull class]]?0:[dict[@"productId"] longLongValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.videoTime=[dict[@"videoTime"] isKindOfClass:[NSNull class]]?0:[dict[@"videoTime"] intValue];

model.width=[dict[@"width"] isKindOfClass:[NSNull class]]?0:[dict[@"width"] intValue];


 return model;
}

@end

