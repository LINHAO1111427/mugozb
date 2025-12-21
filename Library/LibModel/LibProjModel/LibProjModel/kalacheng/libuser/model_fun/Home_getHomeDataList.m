//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "Home_getHomeDataList.h"




  @implementation Home_getHomeDataList  


 +(NSMutableArray<Home_getHomeDataList*>*)getFromArr:(NSArray*)list
{
NSMutableArray<Home_getHomeDataList*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
Home_getHomeDataList* sumMdl=[Home_getHomeDataList getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(Home_getHomeDataList*)getFromDict:(NSDictionary*)dict
{
Home_getHomeDataList* model=[[Home_getHomeDataList alloc]init];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.isLive=[dict[@"isLive"] isKindOfClass:[NSNull class]]?0:[dict[@"isLive"] intValue];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.liveFunction=[dict[@"liveFunction"] isKindOfClass:[NSNull class]]?0:[dict[@"liveFunction"] intValue];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.pageIndex=[dict[@"pageIndex"] isKindOfClass:[NSNull class]]?0:[dict[@"pageIndex"] intValue];

model.pageSize=[dict[@"pageSize"] isKindOfClass:[NSNull class]]?0:[dict[@"pageSize"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.tabIds=[dict[@"tabIds"] isKindOfClass:[NSNull class]]?@"":dict[@"tabIds"];

model.twoClassifyId=[dict[@"twoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"twoClassifyId"] longLongValue];


 return model;
}

@end

