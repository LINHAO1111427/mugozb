//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GamePrizeRecordModel.h"




 @implementation GamePrizeRecordModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"awardsId"]=@(_awardsId);

dict[@"addTime"]=_addTime;

dict[@"awardsNum"]=@(_awardsNum);

dict[@"giftName"]=_giftName;

dict[@"gameKindId"]=@(_gameKindId);

dict[@"awardUnitPrice"]=@(_awardUnitPrice);

dict[@"remake"]=_remake;

dict[@"userName"]=_userName;

dict[@"awardsType"]=@(_awardsType);

dict[@"picture"]=_picture;

dict[@"giftId"]=@(_giftId);

dict[@"uid"]=@(_uid);

dict[@"awardsCoin"]=@(_awardsCoin);

dict[@"awardsName"]=_awardsName;

dict[@"id"]=@(_id_field);

dict[@"time"]=@(_time);

dict[@"luckDrawId"]=@(_luckDrawId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GamePrizeRecordModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GamePrizeRecordModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GamePrizeRecordModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GamePrizeRecordModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GamePrizeRecordModel* sumMdl=[GamePrizeRecordModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GamePrizeRecordModel*)getFromDict:(NSDictionary*)dict
{
GamePrizeRecordModel* model=[[GamePrizeRecordModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.awardsId=[dict[@"awardsId"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsId"] longLongValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?@"":dict[@"addTime"];

model.awardsNum=[dict[@"awardsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsNum"] intValue];

model.giftName=[dict[@"giftName"] isKindOfClass:[NSNull class]]?@"":dict[@"giftName"];

model.gameKindId=[dict[@"gameKindId"] isKindOfClass:[NSNull class]]?0:[dict[@"gameKindId"] longLongValue];

model.awardUnitPrice=[dict[@"awardUnitPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"awardUnitPrice"] doubleValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.awardsType=[dict[@"awardsType"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsType"] intValue];

model.picture=[dict[@"picture"] isKindOfClass:[NSNull class]]?@"":dict[@"picture"];

model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.awardsCoin=[dict[@"awardsCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsCoin"] doubleValue];

model.awardsName=[dict[@"awardsName"] isKindOfClass:[NSNull class]]?@"":dict[@"awardsName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?0:[dict[@"time"] longLongValue];

model.luckDrawId=[dict[@"luckDrawId"] isKindOfClass:[NSNull class]]?0:[dict[@"luckDrawId"] longLongValue];


 return model;
}

 +(void)cloneObj:(GamePrizeRecordModel*) source target:(GamePrizeRecordModel*)target
{

target.awardsId=source.awardsId;

target.addTime=source.addTime;

target.awardsNum=source.awardsNum;

target.giftName=source.giftName;

target.gameKindId=source.gameKindId;

target.awardUnitPrice=source.awardUnitPrice;

target.remake=source.remake;

target.userName=source.userName;

target.awardsType=source.awardsType;

target.picture=source.picture;

target.giftId=source.giftId;

target.uid=source.uid;

target.awardsCoin=source.awardsCoin;

target.awardsName=source.awardsName;

target.id_field=source.id_field;

target.time=source.time;

target.luckDrawId=source.luckDrawId;

}

@end

