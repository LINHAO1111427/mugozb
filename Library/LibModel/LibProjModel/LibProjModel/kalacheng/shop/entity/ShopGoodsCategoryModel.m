//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsCategoryModel.h"




 @implementation ShopGoodsCategoryModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"totalAmount"]=@(_totalAmount);

dict[@"sale"]=@(_sale);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"num"]=@(_num);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"remake"]=_remake;

dict[@"sort"]=@(_sort);

dict[@"parentId"]=@(_parentId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsCategoryModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsCategoryModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsCategoryModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsCategoryModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsCategoryModel* sumMdl=[ShopGoodsCategoryModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsCategoryModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsCategoryModel* model=[[ShopGoodsCategoryModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.sale=[dict[@"sale"] isKindOfClass:[NSNull class]]?0:[dict[@"sale"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?0:[dict[@"num"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.parentId=[dict[@"parentId"] isKindOfClass:[NSNull class]]?0:[dict[@"parentId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ShopGoodsCategoryModel*) source target:(ShopGoodsCategoryModel*)target
{

target.totalAmount=source.totalAmount;

target.sale=source.sale;

target.addTime=source.addTime;

target.num=source.num;

target.name=source.name;

target.id_field=source.id_field;

target.remake=source.remake;

target.sort=source.sort;

target.parentId=source.parentId;

}

@end

