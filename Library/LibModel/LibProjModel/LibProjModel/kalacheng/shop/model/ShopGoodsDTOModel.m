//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsDTOModel.h"




 @implementation ShopGoodsDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"productLinks"]=_productLinks;

dict[@"soldNum"]=@(_soldNum);

dict[@"goodsId"]=@(_goodsId);

dict[@"sort"]=@(_sort);

dict[@"categoryName"]=_categoryName;

dict[@"favorablePrice"]=@(_favorablePrice);

dict[@"goodsPicture"]=_goodsPicture;

dict[@"liveSort"]=@(_liveSort);

dict[@"price"]=@(_price);

dict[@"checked"]=@(_checked);

dict[@"channelName"]=_channelName;

dict[@"present"]=_present;

dict[@"goodsName"]=_goodsName;

dict[@"attrName"]=_attrName;

dict[@"categoryId"]=@(_categoryId);

dict[@"channelId"]=@(_channelId);

dict[@"detailPicture"]=_detailPicture;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsDTOModel* sumMdl=[ShopGoodsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsDTOModel* model=[[ShopGoodsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.productLinks=[dict[@"productLinks"] isKindOfClass:[NSNull class]]?@"":dict[@"productLinks"];

model.soldNum=[dict[@"soldNum"] isKindOfClass:[NSNull class]]?0:[dict[@"soldNum"] intValue];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.categoryName=[dict[@"categoryName"] isKindOfClass:[NSNull class]]?@"":dict[@"categoryName"];

model.favorablePrice=[dict[@"favorablePrice"] isKindOfClass:[NSNull class]]?0:[dict[@"favorablePrice"] doubleValue];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];

model.liveSort=[dict[@"liveSort"] isKindOfClass:[NSNull class]]?0:[dict[@"liveSort"] intValue];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.checked=[dict[@"checked"] isKindOfClass:[NSNull class]]?0:[dict[@"checked"] intValue];

model.channelName=[dict[@"channelName"] isKindOfClass:[NSNull class]]?@"":dict[@"channelName"];

model.present=[dict[@"present"] isKindOfClass:[NSNull class]]?@"":dict[@"present"];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];

model.attrName=[dict[@"attrName"] isKindOfClass:[NSNull class]]?@"":dict[@"attrName"];

model.categoryId=[dict[@"categoryId"] isKindOfClass:[NSNull class]]?0:[dict[@"categoryId"] longLongValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.detailPicture=[dict[@"detailPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"detailPicture"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopGoodsDTOModel*) source target:(ShopGoodsDTOModel*)target
{

target.productLinks=source.productLinks;

target.soldNum=source.soldNum;

target.goodsId=source.goodsId;

target.sort=source.sort;

target.categoryName=source.categoryName;

target.favorablePrice=source.favorablePrice;

target.goodsPicture=source.goodsPicture;

target.liveSort=source.liveSort;

target.price=source.price;

target.checked=source.checked;

target.channelName=source.channelName;

target.present=source.present;

target.goodsName=source.goodsName;

target.attrName=source.attrName;

target.categoryId=source.categoryId;

target.channelId=source.channelId;

target.detailPicture=source.detailPicture;

target.status=source.status;

}

@end

