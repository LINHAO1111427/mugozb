//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RedPacketVOModel.h"




 @implementation RedPacketVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"currencyType"]=@(_currencyType);

dict[@"deductionAfterTotalValue"]=@(_deductionAfterTotalValue);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"liveType"]=@(_liveType);

dict[@"receivedValue"]=@(_receivedValue);

dict[@"redPacketType"]=@(_redPacketType);

dict[@"roomId"]=@(_roomId);

dict[@"sendUserId"]=@(_sendUserId);

dict[@"deductionTotalValue"]=@(_deductionTotalValue);

dict[@"remainingAmount"]=@(_remainingAmount);

dict[@"showId"]=_showId;

dict[@"otherUserAvatar"]=_otherUserAvatar;

dict[@"sendUserName"]=_sendUserName;

dict[@"expireDate"]=[HttpClient stringFromDate:_expireDate];

dict[@"deductionRatio"]=@(_deductionRatio);

dict[@"id"]=@(_id_field);

dict[@"otherUserId"]=_otherUserId;

dict[@"totalValue"]=@(_totalValue);

dict[@"redPacketStatus"]=@(_redPacketStatus);

dict[@"redPacketAmount"]=@(_redPacketAmount);

dict[@"isReceive"]=@(_isReceive);

dict[@"anchorId"]=@(_anchorId);

dict[@"redPacketRange"]=@(_redPacketRange);

dict[@"otherUserName"]=_otherUserName;

dict[@"myReceivedValue"]=@(_myReceivedValue);

dict[@"sendUserAvatar"]=_sendUserAvatar;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RedPacketVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RedPacketVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RedPacketVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RedPacketVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RedPacketVOModel* sumMdl=[RedPacketVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RedPacketVOModel*)getFromDict:(NSDictionary*)dict
{
RedPacketVOModel* model=[[RedPacketVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.currencyType=[dict[@"currencyType"] isKindOfClass:[NSNull class]]?0:[dict[@"currencyType"] intValue];

model.deductionAfterTotalValue=[dict[@"deductionAfterTotalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"deductionAfterTotalValue"] doubleValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.receivedValue=[dict[@"receivedValue"] isKindOfClass:[NSNull class]]?0:[dict[@"receivedValue"] doubleValue];

model.redPacketType=[dict[@"redPacketType"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketType"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.sendUserId=[dict[@"sendUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"sendUserId"] longLongValue];

model.deductionTotalValue=[dict[@"deductionTotalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"deductionTotalValue"] doubleValue];

model.remainingAmount=[dict[@"remainingAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"remainingAmount"] intValue];

model.showId=[dict[@"showId"] isKindOfClass:[NSNull class]]?@"":dict[@"showId"];

model.otherUserAvatar=[dict[@"otherUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"otherUserAvatar"];

model.sendUserName=[dict[@"sendUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"sendUserName"];


{
NSString *strDate= dict[@"expireDate"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.expireDate=date;
    }
}

model.deductionRatio=[dict[@"deductionRatio"] isKindOfClass:[NSNull class]]?0:[dict[@"deductionRatio"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.otherUserId=[dict[@"otherUserId"] isKindOfClass:[NSNull class]]?@"":dict[@"otherUserId"];

model.totalValue=[dict[@"totalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"totalValue"] doubleValue];

model.redPacketStatus=[dict[@"redPacketStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketStatus"] intValue];

model.redPacketAmount=[dict[@"redPacketAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketAmount"] intValue];

model.isReceive=[dict[@"isReceive"] isKindOfClass:[NSNull class]]?0:[dict[@"isReceive"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.redPacketRange=[dict[@"redPacketRange"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketRange"] intValue];

model.otherUserName=[dict[@"otherUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"otherUserName"];

model.myReceivedValue=[dict[@"myReceivedValue"] isKindOfClass:[NSNull class]]?0:[dict[@"myReceivedValue"] doubleValue];

model.sendUserAvatar=[dict[@"sendUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"sendUserAvatar"];


 return model;
}

 +(void)cloneObj:(RedPacketVOModel*) source target:(RedPacketVOModel*)target
{

target.currencyType=source.currencyType;

target.deductionAfterTotalValue=source.deductionAfterTotalValue;

target.addTime=source.addTime;

target.liveType=source.liveType;

target.receivedValue=source.receivedValue;

target.redPacketType=source.redPacketType;

target.roomId=source.roomId;

target.sendUserId=source.sendUserId;

target.deductionTotalValue=source.deductionTotalValue;

target.remainingAmount=source.remainingAmount;

target.showId=source.showId;

target.otherUserAvatar=source.otherUserAvatar;

target.sendUserName=source.sendUserName;

target.expireDate=source.expireDate;

target.deductionRatio=source.deductionRatio;

target.id_field=source.id_field;

target.otherUserId=source.otherUserId;

target.totalValue=source.totalValue;

target.redPacketStatus=source.redPacketStatus;

target.redPacketAmount=source.redPacketAmount;

target.isReceive=source.isReceive;

target.anchorId=source.anchorId;

target.redPacketRange=source.redPacketRange;

target.otherUserName=source.otherUserName;

target.myReceivedValue=source.myReceivedValue;

target.sendUserAvatar=source.sendUserAvatar;

}

@end

