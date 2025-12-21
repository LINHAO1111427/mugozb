//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsModel.h"




 @implementation ShopGoodsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"productLinks"]=_productLinks;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"soldNum"]=@(_soldNum);

dict[@"num"]=_num;

dict[@"businessId"]=@(_businessId);

dict[@"remake"]=_remake;

dict[@"sort"]=@(_sort);

dict[@"anchorId"]=@(_anchorId);

dict[@"favorablePrice"]=@(_favorablePrice);

dict[@"goodsPicture"]=_goodsPicture;

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"myGoods"]=@(_myGoods);

dict[@"price"]=@(_price);

dict[@"id"]=@(_id_field);

dict[@"present"]=_present;

dict[@"goodsName"]=_goodsName;

dict[@"categoryId"]=@(_categoryId);

dict[@"channelId"]=@(_channelId);

dict[@"detailPicture"]=_detailPicture;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsModel* sumMdl=[ShopGoodsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsModel* model=[[ShopGoodsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.productLinks=[dict[@"productLinks"] isKindOfClass:[NSNull class]]?@"":dict[@"productLinks"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.soldNum=[dict[@"soldNum"] isKindOfClass:[NSNull class]]?0:[dict[@"soldNum"] intValue];

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?@"":dict[@"num"];

model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.favorablePrice=[dict[@"favorablePrice"] isKindOfClass:[NSNull class]]?0:[dict[@"favorablePrice"] doubleValue];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];


{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.myGoods=[dict[@"myGoods"] isKindOfClass:[NSNull class]]?0:[dict[@"myGoods"] intValue];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.present=[dict[@"present"] isKindOfClass:[NSNull class]]?@"":dict[@"present"];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];

model.categoryId=[dict[@"categoryId"] isKindOfClass:[NSNull class]]?0:[dict[@"categoryId"] longLongValue];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.detailPicture=[dict[@"detailPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"detailPicture"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopGoodsModel*) source target:(ShopGoodsModel*)target
{

target.productLinks=source.productLinks;

target.addTime=source.addTime;

target.soldNum=source.soldNum;

target.num=source.num;

target.businessId=source.businessId;

target.remake=source.remake;

target.sort=source.sort;

target.anchorId=source.anchorId;

target.favorablePrice=source.favorablePrice;

target.goodsPicture=source.goodsPicture;

target.upTime=source.upTime;

target.myGoods=source.myGoods;

target.price=source.price;

target.id_field=source.id_field;

target.present=source.present;

target.goodsName=source.goodsName;

target.categoryId=source.categoryId;

target.channelId=source.channelId;

target.detailPicture=source.detailPicture;

target.status=source.status;

}

@end

