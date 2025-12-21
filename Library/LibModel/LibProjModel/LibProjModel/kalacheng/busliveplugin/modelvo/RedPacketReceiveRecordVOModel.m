//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RedPacketReceiveRecordVOModel.h"




 @implementation RedPacketReceiveRecordVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"currencyType"]=@(_currencyType);

dict[@"totalValue"]=@(_totalValue);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"remainingValue"]=@(_remainingValue);

dict[@"redPacketAmount"]=@(_redPacketAmount);

dict[@"redPacketType"]=@(_redPacketType);

dict[@"avatar"]=_avatar;

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"sendUserId"]=@(_sendUserId);

dict[@"deductionValue"]=@(_deductionValue);

dict[@"id"]=@(_id_field);

dict[@"myReceivedValue"]=@(_myReceivedValue);

dict[@"redPacketId"]=@(_redPacketId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RedPacketReceiveRecordVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RedPacketReceiveRecordVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RedPacketReceiveRecordVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RedPacketReceiveRecordVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RedPacketReceiveRecordVOModel* sumMdl=[RedPacketReceiveRecordVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RedPacketReceiveRecordVOModel*)getFromDict:(NSDictionary*)dict
{
RedPacketReceiveRecordVOModel* model=[[RedPacketReceiveRecordVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.currencyType=[dict[@"currencyType"] isKindOfClass:[NSNull class]]?0:[dict[@"currencyType"] intValue];

model.totalValue=[dict[@"totalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"totalValue"] doubleValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.remainingValue=[dict[@"remainingValue"] isKindOfClass:[NSNull class]]?0:[dict[@"remainingValue"] doubleValue];

model.redPacketAmount=[dict[@"redPacketAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketAmount"] intValue];

model.redPacketType=[dict[@"redPacketType"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketType"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.sendUserId=[dict[@"sendUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"sendUserId"] longLongValue];

model.deductionValue=[dict[@"deductionValue"] isKindOfClass:[NSNull class]]?0:[dict[@"deductionValue"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.myReceivedValue=[dict[@"myReceivedValue"] isKindOfClass:[NSNull class]]?0:[dict[@"myReceivedValue"] doubleValue];

model.redPacketId=[dict[@"redPacketId"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketId"] longLongValue];


 return model;
}

 +(void)cloneObj:(RedPacketReceiveRecordVOModel*) source target:(RedPacketReceiveRecordVOModel*)target
{

target.currencyType=source.currencyType;

target.totalValue=source.totalValue;

target.addTime=source.addTime;

target.remainingValue=source.remainingValue;

target.redPacketAmount=source.redPacketAmount;

target.redPacketType=source.redPacketType;

target.avatar=source.avatar;

target.userName=source.userName;

target.userId=source.userId;

target.sendUserId=source.sendUserId;

target.deductionValue=source.deductionValue;

target.id_field=source.id_field;

target.myReceivedValue=source.myReceivedValue;

target.redPacketId=source.redPacketId;

}

@end

