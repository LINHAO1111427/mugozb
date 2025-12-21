//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopCarModel.h"




 @implementation ShopCarModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"skuName"]=_skuName;

dict[@"uid"]=@(_uid);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"goodsId"]=@(_goodsId);

dict[@"goodsPrice"]=@(_goodsPrice);

dict[@"businessId"]=@(_businessId);

dict[@"id"]=@(_id_field);

dict[@"composeId"]=@(_composeId);

dict[@"goodsName"]=_goodsName;

dict[@"goodsNum"]=@(_goodsNum);

dict[@"goodsPicture"]=_goodsPicture;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopCarModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopCarModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopCarModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopCarModel* sumMdl=[ShopCarModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopCarModel*)getFromDict:(NSDictionary*)dict
{
ShopCarModel* model=[[ShopCarModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.skuName=[dict[@"skuName"] isKindOfClass:[NSNull class]]?@"":dict[@"skuName"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];


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

model.goodsPrice=[dict[@"goodsPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsPrice"] doubleValue];

model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.composeId=[dict[@"composeId"] isKindOfClass:[NSNull class]]?0:[dict[@"composeId"] longLongValue];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];

model.goodsNum=[dict[@"goodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsNum"] intValue];

model.goodsPicture=[dict[@"goodsPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsPicture"];


 return model;
}

 +(void)cloneObj:(ShopCarModel*) source target:(ShopCarModel*)target
{

target.skuName=source.skuName;

target.uid=source.uid;

target.addTime=source.addTime;

target.goodsId=source.goodsId;

target.goodsPrice=source.goodsPrice;

target.businessId=source.businessId;

target.id_field=source.id_field;

target.composeId=source.composeId;

target.goodsName=source.goodsName;

target.goodsNum=source.goodsNum;

target.goodsPicture=source.goodsPicture;

}

@end

