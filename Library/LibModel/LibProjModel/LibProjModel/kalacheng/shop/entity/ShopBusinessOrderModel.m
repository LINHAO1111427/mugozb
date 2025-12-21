//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopBusinessOrderModel.h"




 @implementation ShopBusinessOrderModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"reason"]=_reason;

dict[@"logisticsId"]=@(_logisticsId);

dict[@"manualRefundMoney"]=@(_manualRefundMoney);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"businessId"]=@(_businessId);

dict[@"businessName"]=_businessName;

dict[@"auditFailureReason"]=_auditFailureReason;

dict[@"orderNum"]=_orderNum;

dict[@"refundOrderNum"]=_refundOrderNum;

dict[@"phoneNum"]=_phoneNum;

dict[@"transactionTime"]=[HttpClient stringFromDate:_transactionTime];

dict[@"addressId"]=@(_addressId);

dict[@"refundType"]=@(_refundType);

dict[@"uid"]=@(_uid);

dict[@"orderAmount"]=@(_orderAmount);

dict[@"refundLogisticsId"]=@(_refundLogisticsId);

dict[@"manualRefundOperator"]=_manualRefundOperator;

dict[@"transactionAmount"]=@(_transactionAmount);

dict[@"id"]=@(_id_field);

dict[@"address"]=_address;

dict[@"refundTime"]=[HttpClient stringFromDate:_refundTime];

dict[@"businessLogo"]=_businessLogo;

dict[@"remake"]=_remake;

dict[@"anchorId"]=@(_anchorId);

dict[@"platformPayOrder"]=_platformPayOrder;

dict[@"goodsChannelId"]=@(_goodsChannelId);

dict[@"quitStatus"]=@(_quitStatus);

dict[@"manualRefundType"]=@(_manualRefundType);

dict[@"refundNotesImages"]=_refundNotesImages;

dict[@"isManualRefund"]=@(_isManualRefund);

dict[@"name"]=_name;

dict[@"refundNotes"]=_refundNotes;

dict[@"payId"]=@(_payId);

dict[@"taskId"]=@(_taskId);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessOrderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopBusinessOrderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopBusinessOrderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopBusinessOrderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopBusinessOrderModel* sumMdl=[ShopBusinessOrderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopBusinessOrderModel*)getFromDict:(NSDictionary*)dict
{
ShopBusinessOrderModel* model=[[ShopBusinessOrderModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.reason=[dict[@"reason"] isKindOfClass:[NSNull class]]?@"":dict[@"reason"];

model.logisticsId=[dict[@"logisticsId"] isKindOfClass:[NSNull class]]?0:[dict[@"logisticsId"] longLongValue];

model.manualRefundMoney=[dict[@"manualRefundMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"manualRefundMoney"] doubleValue];


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

model.businessName=[dict[@"businessName"] isKindOfClass:[NSNull class]]?@"":dict[@"businessName"];

model.auditFailureReason=[dict[@"auditFailureReason"] isKindOfClass:[NSNull class]]?@"":dict[@"auditFailureReason"];

model.orderNum=[dict[@"orderNum"] isKindOfClass:[NSNull class]]?@"":dict[@"orderNum"];

model.refundOrderNum=[dict[@"refundOrderNum"] isKindOfClass:[NSNull class]]?@"":dict[@"refundOrderNum"];

model.phoneNum=[dict[@"phoneNum"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneNum"];


{
NSString *strDate= dict[@"transactionTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.transactionTime=date;
    }
}

model.addressId=[dict[@"addressId"] isKindOfClass:[NSNull class]]?0:[dict[@"addressId"] longLongValue];

model.refundType=[dict[@"refundType"] isKindOfClass:[NSNull class]]?0:[dict[@"refundType"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.orderAmount=[dict[@"orderAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"orderAmount"] doubleValue];

model.refundLogisticsId=[dict[@"refundLogisticsId"] isKindOfClass:[NSNull class]]?0:[dict[@"refundLogisticsId"] longLongValue];

model.manualRefundOperator=[dict[@"manualRefundOperator"] isKindOfClass:[NSNull class]]?@"":dict[@"manualRefundOperator"];

model.transactionAmount=[dict[@"transactionAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"transactionAmount"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];


{
NSString *strDate= dict[@"refundTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.refundTime=date;
    }
}

model.businessLogo=[dict[@"businessLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLogo"];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.platformPayOrder=[dict[@"platformPayOrder"] isKindOfClass:[NSNull class]]?@"":dict[@"platformPayOrder"];

model.goodsChannelId=[dict[@"goodsChannelId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsChannelId"] longLongValue];

model.quitStatus=[dict[@"quitStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"quitStatus"] intValue];

model.manualRefundType=[dict[@"manualRefundType"] isKindOfClass:[NSNull class]]?0:[dict[@"manualRefundType"] intValue];

model.refundNotesImages=[dict[@"refundNotesImages"] isKindOfClass:[NSNull class]]?@"":dict[@"refundNotesImages"];

model.isManualRefund=[dict[@"isManualRefund"] isKindOfClass:[NSNull class]]?0:[dict[@"isManualRefund"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.refundNotes=[dict[@"refundNotes"] isKindOfClass:[NSNull class]]?@"":dict[@"refundNotes"];

model.payId=[dict[@"payId"] isKindOfClass:[NSNull class]]?0:[dict[@"payId"] longLongValue];

model.taskId=[dict[@"taskId"] isKindOfClass:[NSNull class]]?0:[dict[@"taskId"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopBusinessOrderModel*) source target:(ShopBusinessOrderModel*)target
{

target.reason=source.reason;

target.logisticsId=source.logisticsId;

target.manualRefundMoney=source.manualRefundMoney;

target.addTime=source.addTime;

target.businessId=source.businessId;

target.businessName=source.businessName;

target.auditFailureReason=source.auditFailureReason;

target.orderNum=source.orderNum;

target.refundOrderNum=source.refundOrderNum;

target.phoneNum=source.phoneNum;

target.transactionTime=source.transactionTime;

target.addressId=source.addressId;

target.refundType=source.refundType;

target.uid=source.uid;

target.orderAmount=source.orderAmount;

target.refundLogisticsId=source.refundLogisticsId;

target.manualRefundOperator=source.manualRefundOperator;

target.transactionAmount=source.transactionAmount;

target.id_field=source.id_field;

target.address=source.address;

target.refundTime=source.refundTime;

target.businessLogo=source.businessLogo;

target.remake=source.remake;

target.anchorId=source.anchorId;

target.platformPayOrder=source.platformPayOrder;

target.goodsChannelId=source.goodsChannelId;

target.quitStatus=source.quitStatus;

target.manualRefundType=source.manualRefundType;

target.refundNotesImages=source.refundNotesImages;

target.isManualRefund=source.isManualRefund;

target.name=source.name;

target.refundNotes=source.refundNotes;

target.payId=source.payId;

target.taskId=source.taskId;

target.status=source.status;

}

@end

