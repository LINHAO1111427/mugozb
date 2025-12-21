//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopWithdrawRecordModel.h"




 @implementation ShopWithdrawRecordModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"amount"]=@(_amount);

dict[@"orderNo"]=_orderNo;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"businessId"]=@(_businessId);

dict[@"anchorId"]=@(_anchorId);

dict[@"realAmount"]=@(_realAmount);

dict[@"accountId"]=@(_accountId);

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"balance"]=@(_balance);

dict[@"servicePerc"]=@(_servicePerc);

dict[@"platformPerc"]=@(_platformPerc);

dict[@"id"]=@(_id_field);

dict[@"serviceMoney"]=@(_serviceMoney);

dict[@"remarks"]=_remarks;

dict[@"platformMoney"]=@(_platformMoney);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopWithdrawRecordModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopWithdrawRecordModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopWithdrawRecordModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopWithdrawRecordModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopWithdrawRecordModel* sumMdl=[ShopWithdrawRecordModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopWithdrawRecordModel*)getFromDict:(NSDictionary*)dict
{
ShopWithdrawRecordModel* model=[[ShopWithdrawRecordModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.orderNo=[dict[@"orderNo"] isKindOfClass:[NSNull class]]?@"":dict[@"orderNo"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.realAmount=[dict[@"realAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"realAmount"] doubleValue];

model.accountId=[dict[@"accountId"] isKindOfClass:[NSNull class]]?0:[dict[@"accountId"] longLongValue];


{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}

model.balance=[dict[@"balance"] isKindOfClass:[NSNull class]]?0:[dict[@"balance"] doubleValue];

model.servicePerc=[dict[@"servicePerc"] isKindOfClass:[NSNull class]]?0:[dict[@"servicePerc"] doubleValue];

model.platformPerc=[dict[@"platformPerc"] isKindOfClass:[NSNull class]]?0:[dict[@"platformPerc"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.serviceMoney=[dict[@"serviceMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"serviceMoney"] doubleValue];

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];

model.platformMoney=[dict[@"platformMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"platformMoney"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopWithdrawRecordModel*) source target:(ShopWithdrawRecordModel*)target
{

target.amount=source.amount;

target.orderNo=source.orderNo;

target.addTime=source.addTime;

target.businessId=source.businessId;

target.anchorId=source.anchorId;

target.realAmount=source.realAmount;

target.accountId=source.accountId;

target.upTime=source.upTime;

target.balance=source.balance;

target.servicePerc=source.servicePerc;

target.platformPerc=source.platformPerc;

target.id_field=source.id_field;

target.serviceMoney=source.serviceMoney;

target.remarks=source.remarks;

target.platformMoney=source.platformMoney;

target.status=source.status;

}

@end

