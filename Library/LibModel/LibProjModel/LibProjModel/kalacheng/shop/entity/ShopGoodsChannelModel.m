//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsChannelModel.h"




 @implementation ShopGoodsChannelModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"goodsChannel"]=_goodsChannel;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsChannelModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsChannelModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsChannelModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsChannelModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsChannelModel* sumMdl=[ShopGoodsChannelModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsChannelModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsChannelModel* model=[[ShopGoodsChannelModel alloc]init];

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

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.goodsChannel=[dict[@"goodsChannel"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsChannel"];


 return model;
}

 +(void)cloneObj:(ShopGoodsChannelModel*) source target:(ShopGoodsChannelModel*)target
{

target.addTime=source.addTime;

target.id_field=source.id_field;

target.sort=source.sort;

target.goodsChannel=source.goodsChannel;

}

@end

