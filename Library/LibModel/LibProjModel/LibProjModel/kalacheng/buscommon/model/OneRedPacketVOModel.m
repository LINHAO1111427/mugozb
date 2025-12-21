//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OneRedPacketVOModel.h"




 @implementation OneRedPacketVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"currencyType"]=@(_currencyType);

dict[@"sendUserId"]=@(_sendUserId);

dict[@"totalValue"]=@(_totalValue);

dict[@"deductionAfterTotalValue"]=@(_deductionAfterTotalValue);

dict[@"redPacketRange"]=@(_redPacketRange);

dict[@"redPacketAmount"]=@(_redPacketAmount);

dict[@"sendUserName"]=_sendUserName;

dict[@"isReceive"]=@(_isReceive);

dict[@"myReceivedValue"]=@(_myReceivedValue);

dict[@"redPacketId"]=@(_redPacketId);

dict[@"sendUserAvatar"]=_sendUserAvatar;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OneRedPacketVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OneRedPacketVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OneRedPacketVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OneRedPacketVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OneRedPacketVOModel* sumMdl=[OneRedPacketVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OneRedPacketVOModel*)getFromDict:(NSDictionary*)dict
{
OneRedPacketVOModel* model=[[OneRedPacketVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.currencyType=[dict[@"currencyType"] isKindOfClass:[NSNull class]]?0:[dict[@"currencyType"] intValue];

model.sendUserId=[dict[@"sendUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"sendUserId"] longLongValue];

model.totalValue=[dict[@"totalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"totalValue"] doubleValue];

model.deductionAfterTotalValue=[dict[@"deductionAfterTotalValue"] isKindOfClass:[NSNull class]]?0:[dict[@"deductionAfterTotalValue"] doubleValue];

model.redPacketRange=[dict[@"redPacketRange"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketRange"] intValue];

model.redPacketAmount=[dict[@"redPacketAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketAmount"] intValue];

model.sendUserName=[dict[@"sendUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"sendUserName"];

model.isReceive=[dict[@"isReceive"] isKindOfClass:[NSNull class]]?0:[dict[@"isReceive"] intValue];

model.myReceivedValue=[dict[@"myReceivedValue"] isKindOfClass:[NSNull class]]?0:[dict[@"myReceivedValue"] doubleValue];

model.redPacketId=[dict[@"redPacketId"] isKindOfClass:[NSNull class]]?0:[dict[@"redPacketId"] longLongValue];

model.sendUserAvatar=[dict[@"sendUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"sendUserAvatar"];


 return model;
}

 +(void)cloneObj:(OneRedPacketVOModel*) source target:(OneRedPacketVOModel*)target
{

target.currencyType=source.currencyType;

target.sendUserId=source.sendUserId;

target.totalValue=source.totalValue;

target.deductionAfterTotalValue=source.deductionAfterTotalValue;

target.redPacketRange=source.redPacketRange;

target.redPacketAmount=source.redPacketAmount;

target.sendUserName=source.sendUserName;

target.isReceive=source.isReceive;

target.myReceivedValue=source.myReceivedValue;

target.redPacketId=source.redPacketId;

target.sendUserAvatar=source.sendUserAvatar;

}

@end

