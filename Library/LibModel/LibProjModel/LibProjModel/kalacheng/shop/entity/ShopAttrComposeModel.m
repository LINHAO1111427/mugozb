//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopAttrComposeModel.h"




 @implementation ShopAttrComposeModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"attribute2Id"]=@(_attribute2Id);

dict[@"goodsId"]=@(_goodsId);

dict[@"price"]=@(_price);

dict[@"attribute1Id"]=@(_attribute1Id);

dict[@"frozenStock"]=@(_frozenStock);

dict[@"id"]=@(_id_field);

dict[@"name2"]=_name2;

dict[@"stock"]=@(_stock);

dict[@"favorablePrice"]=@(_favorablePrice);

dict[@"name1"]=_name1;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrComposeModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopAttrComposeModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopAttrComposeModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopAttrComposeModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrComposeModel* sumMdl=[ShopAttrComposeModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopAttrComposeModel*)getFromDict:(NSDictionary*)dict
{
ShopAttrComposeModel* model=[[ShopAttrComposeModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.attribute2Id=[dict[@"attribute2Id"] isKindOfClass:[NSNull class]]?0:[dict[@"attribute2Id"] longLongValue];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.attribute1Id=[dict[@"attribute1Id"] isKindOfClass:[NSNull class]]?0:[dict[@"attribute1Id"] longLongValue];

model.frozenStock=[dict[@"frozenStock"] isKindOfClass:[NSNull class]]?0:[dict[@"frozenStock"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.name2=[dict[@"name2"] isKindOfClass:[NSNull class]]?@"":dict[@"name2"];

model.stock=[dict[@"stock"] isKindOfClass:[NSNull class]]?0:[dict[@"stock"] intValue];

model.favorablePrice=[dict[@"favorablePrice"] isKindOfClass:[NSNull class]]?0:[dict[@"favorablePrice"] doubleValue];

model.name1=[dict[@"name1"] isKindOfClass:[NSNull class]]?@"":dict[@"name1"];


 return model;
}

 +(void)cloneObj:(ShopAttrComposeModel*) source target:(ShopAttrComposeModel*)target
{

target.attribute2Id=source.attribute2Id;

target.goodsId=source.goodsId;

target.price=source.price;

target.attribute1Id=source.attribute1Id;

target.frozenStock=source.frozenStock;

target.id_field=source.id_field;

target.name2=source.name2;

target.stock=source.stock;

target.favorablePrice=source.favorablePrice;

target.name1=source.name1;

}

@end

