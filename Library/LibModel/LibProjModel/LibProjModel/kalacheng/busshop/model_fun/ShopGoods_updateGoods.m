//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "ShopGoods_updateGoods.h"




  @implementation ShopGoods_updateGoods  


 +(NSMutableArray<ShopGoods_updateGoods*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoods_updateGoods*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoods_updateGoods* sumMdl=[ShopGoods_updateGoods getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoods_updateGoods*)getFromDict:(NSDictionary*)dict
{
ShopGoods_updateGoods* model=[[ShopGoods_updateGoods alloc]init];

model.categoryId=[dict[@"categoryId"] isKindOfClass:[NSNull class]]?0:[dict[@"categoryId"] longLongValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.detailPicture=[dict[@"detailPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"detailPicture"];

model.favorablePrice=[dict[@"favorablePrice"] isKindOfClass:[NSNull class]]?0:[dict[@"favorablePrice"] doubleValue];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];

model.present=[dict[@"present"] isKindOfClass:[NSNull class]]?@"":dict[@"present"];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.productLinks=[dict[@"productLinks"] isKindOfClass:[NSNull class]]?@"":dict[@"productLinks"];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

@end

