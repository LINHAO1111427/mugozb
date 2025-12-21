//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "ShopGoods_creatGoods.h"




  @implementation ShopGoods_creatGoods  


 +(NSMutableArray<ShopGoods_creatGoods*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoods_creatGoods*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoods_creatGoods* sumMdl=[ShopGoods_creatGoods getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoods_creatGoods*)getFromDict:(NSDictionary*)dict
{
ShopGoods_creatGoods* model=[[ShopGoods_creatGoods alloc]init];

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

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

@end

