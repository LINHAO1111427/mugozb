//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopParentOrderModel.h"




 @implementation ShopParentOrderModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"uid"]=@(_uid);

dict[@"amount"]=@(_amount);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"payTime"]=[HttpClient stringFromDate:_payTime];

dict[@"nhrAmount"]=@(_nhrAmount);

dict[@"orderNum"]=_orderNum;

dict[@"id"]=@(_id_field);

dict[@"remake"]=_remake;

dict[@"channelId"]=@(_channelId);

dict[@"payOrder"]=_payOrder;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopParentOrderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopParentOrderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopParentOrderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopParentOrderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopParentOrderModel* sumMdl=[ShopParentOrderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopParentOrderModel*)getFromDict:(NSDictionary*)dict
{
ShopParentOrderModel* model=[[ShopParentOrderModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}


{
NSString *strDate= dict[@"payTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.payTime=date;
    }
}

model.nhrAmount=[dict[@"nhrAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"nhrAmount"] doubleValue];

model.orderNum=[dict[@"orderNum"] isKindOfClass:[NSNull class]]?@"":dict[@"orderNum"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.payOrder=[dict[@"payOrder"] isKindOfClass:[NSNull class]]?@"":dict[@"payOrder"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopParentOrderModel*) source target:(ShopParentOrderModel*)target
{

target.uid=source.uid;

target.amount=source.amount;

target.addTime=source.addTime;

target.payTime=source.payTime;

target.nhrAmount=source.nhrAmount;

target.orderNum=source.orderNum;

target.id_field=source.id_field;

target.remake=source.remake;

target.channelId=source.channelId;

target.payOrder=source.payOrder;

target.status=source.status;

}

@end

