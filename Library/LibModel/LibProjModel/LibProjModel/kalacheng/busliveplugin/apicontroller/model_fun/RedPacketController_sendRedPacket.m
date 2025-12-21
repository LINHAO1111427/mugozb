//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "RedPacketController_sendRedPacket.h"




  @implementation RedPacketController_sendRedPacket  


 +(NSMutableArray<RedPacketController_sendRedPacket*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RedPacketController_sendRedPacket*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RedPacketController_sendRedPacket* sumMdl=[RedPacketController_sendRedPacket getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RedPacketController_sendRedPacket*)getFromDict:(NSDictionary*)dict
{
RedPacketController_sendRedPacket* model=[[RedPacketController_sendRedPacket alloc]init];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.currencyType=[dict[@"currencyType"] isKindOfClass:[NSNull class]]?0:[dict[@"currencyType"] intValue];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.otherUserId=[dict[@"otherUserId"] isKindOfClass:[NSNull class]]?@"":dict[@"otherUserId"];

model.redPacketAmount=[dict[@"redPacketAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketAmount"] intValue];

model.redPacketRange=[dict[@"redPacketRange"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketRange"] intValue];

model.redPacketType=[dict[@"redPacketType"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketType"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.showId=[dict[@"showId"] isKindOfClass:[NSNull class]]?@"":dict[@"showId"];

model.totalValue=[dict[@"totalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"totalValue"] doubleValue];


 return model;
}

@end

