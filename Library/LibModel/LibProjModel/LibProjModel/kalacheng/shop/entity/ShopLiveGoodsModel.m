//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLiveGoodsModel.h"




 @implementation ShopLiveGoodsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"productLinks"]=_productLinks;

dict[@"goodsId"]=@(_goodsId);

dict[@"goodsPrice"]=@(_goodsPrice);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"idExplain"]=@(_idExplain);

dict[@"sort"]=@(_sort);

dict[@"anchorId"]=@(_anchorId);

dict[@"favorablePrice"]=@(_favorablePrice);

dict[@"channelId"]=@(_channelId);

dict[@"goodsPicture"]=_goodsPicture;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveGoodsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLiveGoodsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLiveGoodsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLiveGoodsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveGoodsModel* sumMdl=[ShopLiveGoodsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLiveGoodsModel*)getFromDict:(NSDictionary*)dict
{
ShopLiveGoodsModel* model=[[ShopLiveGoodsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.productLinks=[dict[@"productLinks"] isKindOfClass:[NSNull class]]?@"":dict[@"productLinks"];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.goodsPrice=[dict[@"goodsPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsPrice"] doubleValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.idExplain=[dict[@"idExplain"] isKindOfClass:[NSNull class]]?0:[dict[@"idExplain"] intValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.favorablePrice=[dict[@"favorablePrice"] isKindOfClass:[NSNull class]]?0:[dict[@"favorablePrice"] doubleValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];


 return model;
}

 +(void)cloneObj:(ShopLiveGoodsModel*) source target:(ShopLiveGoodsModel*)target
{

target.productLinks=source.productLinks;

target.goodsId=source.goodsId;

target.goodsPrice=source.goodsPrice;

target.name=source.name;

target.id_field=source.id_field;

target.idExplain=source.idExplain;

target.sort=source.sort;

target.anchorId=source.anchorId;

target.favorablePrice=source.favorablePrice;

target.channelId=source.channelId;

target.goodsPicture=source.goodsPicture;

}

@end

