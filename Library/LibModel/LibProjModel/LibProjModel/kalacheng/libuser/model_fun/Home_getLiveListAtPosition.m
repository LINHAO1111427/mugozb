//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "Home_getLiveListAtPosition.h"




  @implementation Home_getLiveListAtPosition  


 +(NSMutableArray<Home_getLiveListAtPosition*>*)getFromArr:(NSArray*)list
{
NSMutableArray<Home_getLiveListAtPosition*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
Home_getLiveListAtPosition* sumMdl=[Home_getLiveListAtPosition getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(Home_getLiveListAtPosition*)getFromDict:(NSDictionary*)dict
{
Home_getLiveListAtPosition* model=[[Home_getLiveListAtPosition alloc]init];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.findType=[dict[@"findType"] isKindOfClass:[NSNull class]]?0:[dict[@"findType"] intValue];

model.guildId=[dict[@"guildId"] isKindOfClass:[NSNull class]]?0:[dict[@"guildId"] longLongValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.isAttention=[dict[@"isAttention"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttention"] intValue];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.pageIndex=[dict[@"pageIndex"] isKindOfClass:[NSNull class]]?0:[dict[@"pageIndex"] intValue];

model.pageSize=[dict[@"pageSize"] isKindOfClass:[NSNull class]]?0:[dict[@"pageSize"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];


 return model;
}

@end

