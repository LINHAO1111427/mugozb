//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopSubOrderModel.h"




 @implementation ShopSubOrderModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"goodsId"]=@(_goodsId);

dict[@"businessId"]=@(_businessId);

dict[@"orderNum"]=_orderNum;

dict[@"remake"]=_remake;

dict[@"goodsPicture"]=_goodsPicture;

dict[@"logisticsName"]=_logisticsName;

dict[@"skuName"]=_skuName;

dict[@"businessOrderId"]=@(_businessOrderId);

dict[@"goodsPrice"]=@(_goodsPrice);

dict[@"id"]=@(_id_field);

dict[@"logisticsNum"]=_logisticsNum;

dict[@"payId"]=@(_payId);

dict[@"composeId"]=@(_composeId);

dict[@"goodsName"]=_goodsName;

dict[@"goodsNum"]=@(_goodsNum);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopSubOrderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopSubOrderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopSubOrderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopSubOrderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopSubOrderModel* sumMdl=[ShopSubOrderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopSubOrderModel*)getFromDict:(NSDictionary*)dict
{
ShopSubOrderModel* model=[[ShopSubOrderModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.orderNum=[dict[@"orderNum"] isKindOfClass:[NSNull class]]?@"":dict[@"orderNum"];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];

model.logisticsName=[dict[@"logisticsName"] isKindOfClass:[NSNull class]]?@"":dict[@"logisticsName"];

model.skuName=[dict[@"skuName"] isKindOfClass:[NSNull class]]?@"":dict[@"skuName"];

model.businessOrderId=[dict[@"businessOrderId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessOrderId"] longLongValue];

model.goodsPrice=[dict[@"goodsPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsPrice"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.logisticsNum=[dict[@"logisticsNum"] isKindOfClass:[NSNull class]]?@"":dict[@"logisticsNum"];

model.payId=[dict[@"payId"] isKindOfClass:[NSNull class]]?0:[dict[@"payId"] longLongValue];

model.composeId=[dict[@"composeId"] isKindOfClass:[NSNull class]]?0:[dict[@"composeId"] longLongValue];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];

model.goodsNum=[dict[@"goodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsNum"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopSubOrderModel*) source target:(ShopSubOrderModel*)target
{

target.addTime=source.addTime;

target.goodsId=source.goodsId;

target.businessId=source.businessId;

target.orderNum=source.orderNum;

target.remake=source.remake;

target.goodsPicture=source.goodsPicture;

target.logisticsName=source.logisticsName;

target.skuName=source.skuName;

target.businessOrderId=source.businessOrderId;

target.goodsPrice=source.goodsPrice;

target.id_field=source.id_field;

target.logisticsNum=source.logisticsNum;

target.payId=source.payId;

target.composeId=source.composeId;

target.goodsName=source.goodsName;

target.goodsNum=source.goodsNum;

target.status=source.status;

}

@end

