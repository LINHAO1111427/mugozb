//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShopLiveGoodsModel.h"




 @implementation ApiShopLiveGoodsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"anchorId"]=@(_anchorId);

dict[@"goodsId"]=@(_goodsId);

dict[@"name"]=_name;

dict[@"goodsPicture"]=_goodsPicture;

dict[@"idExplain"]=@(_idExplain);

dict[@"goodsPrice"]=@(_goodsPrice);

dict[@"productLinks"]=_productLinks;

dict[@"channelId"]=@(_channelId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShopLiveGoodsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShopLiveGoodsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShopLiveGoodsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShopLiveGoodsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShopLiveGoodsModel* sumMdl=[ApiShopLiveGoodsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShopLiveGoodsModel*)getFromDict:(NSDictionary*)dict
{
ApiShopLiveGoodsModel* model=[[ApiShopLiveGoodsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];

model.idExplain=[dict[@"idExplain"] isKindOfClass:[NSNull class]]?0:[dict[@"idExplain"] intValue];

model.goodsPrice=[dict[@"goodsPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsPrice"] doubleValue];

model.productLinks=[dict[@"productLinks"] isKindOfClass:[NSNull class]]?@"":dict[@"productLinks"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiShopLiveGoodsModel*) source target:(ApiShopLiveGoodsModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.id_field=source.id_field;

target.sort=source.sort;

target.anchorId=source.anchorId;

target.goodsId=source.goodsId;

target.name=source.name;

target.goodsPicture=source.goodsPicture;

target.idExplain=source.idExplain;

target.goodsPrice=source.goodsPrice;

target.productLinks=source.productLinks;

target.channelId=source.channelId;

}

@end

