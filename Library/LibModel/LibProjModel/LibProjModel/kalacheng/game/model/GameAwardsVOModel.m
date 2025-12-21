//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameAwardsVOModel.h"




 @implementation GameAwardsVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gameId"]=@(_gameId);

dict[@"addTime"]=_addTime;

dict[@"giftName"]=_giftName;

dict[@"winningProbability"]=@(_winningProbability);

dict[@"remake"]=_remake;

dict[@"awardsType"]=@(_awardsType);

dict[@"picture"]=_picture;

dict[@"giftId"]=@(_giftId);

dict[@"giftNeedcoin"]=@(_giftNeedcoin);

dict[@"flutterScreen"]=@(_flutterScreen);

dict[@"coinNum"]=@(_coinNum);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"time"]=@(_time);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameAwardsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameAwardsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameAwardsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameAwardsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameAwardsVOModel* sumMdl=[GameAwardsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameAwardsVOModel*)getFromDict:(NSDictionary*)dict
{
GameAwardsVOModel* model=[[GameAwardsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gameId=[dict[@"gameId"] isKindOfClass:[NSNull class]]?0:[dict[@"gameId"] longLongValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?@"":dict[@"addTime"];

model.giftName=[dict[@"giftName"] isKindOfClass:[NSNull class]]?@"":dict[@"giftName"];

model.winningProbability=[dict[@"winningProbability"] isKindOfClass:[NSNull class]]?0:[dict[@"winningProbability"] doubleValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.awardsType=[dict[@"awardsType"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsType"] intValue];

model.picture=[dict[@"picture"] isKindOfClass:[NSNull class]]?@"":dict[@"picture"];

model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.giftNeedcoin=[dict[@"giftNeedcoin"] isKindOfClass:[NSNull class]]?0:[dict[@"giftNeedcoin"] doubleValue];

model.flutterScreen=[dict[@"flutterScreen"] isKindOfClass:[NSNull class]]?0:[dict[@"flutterScreen"] intValue];

model.coinNum=[dict[@"coinNum"] isKindOfClass:[NSNull class]]?0:[dict[@"coinNum"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?0:[dict[@"time"] longLongValue];


 return model;
}

 +(void)cloneObj:(GameAwardsVOModel*) source target:(GameAwardsVOModel*)target
{

target.gameId=source.gameId;

target.addTime=source.addTime;

target.giftName=source.giftName;

target.winningProbability=source.winningProbability;

target.remake=source.remake;

target.awardsType=source.awardsType;

target.picture=source.picture;

target.giftId=source.giftId;

target.giftNeedcoin=source.giftNeedcoin;

target.flutterScreen=source.flutterScreen;

target.coinNum=source.coinNum;

target.name=source.name;

target.id_field=source.id_field;

target.time=source.time;

}

@end

