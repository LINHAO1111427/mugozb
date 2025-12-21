//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "Home_getHomO2ODataList.h"




  @implementation Home_getHomO2ODataList  


 +(NSMutableArray<Home_getHomO2ODataList*>*)getFromArr:(NSArray*)list
{
NSMutableArray<Home_getHomO2ODataList*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
Home_getHomO2ODataList* sumMdl=[Home_getHomO2ODataList getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(Home_getHomO2ODataList*)getFromDict:(NSDictionary*)dict
{
Home_getHomO2ODataList* model=[[Home_getHomO2ODataList alloc]init];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.pageIndex=[dict[@"pageIndex"] isKindOfClass:[NSNull class]]?0:[dict[@"pageIndex"] intValue];

model.pageSize=[dict[@"pageSize"] isKindOfClass:[NSNull class]]?0:[dict[@"pageSize"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.tabIds=[dict[@"tabIds"] isKindOfClass:[NSNull class]]?@"":dict[@"tabIds"];

model.twoClassifyId=[dict[@"twoClassifyId"] isKindOfClass:[NSNull class]]?0:[dict[@"twoClassifyId"] longLongValue];


 return model;
}

@end

