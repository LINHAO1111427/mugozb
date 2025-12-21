//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameLuckDrawModel.h"




 @implementation GameLuckDrawModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gameId"]=@(_gameId);

dict[@"sonType"]=_sonType;

dict[@"winNum"]=@(_winNum);

dict[@"gameNum"]=@(_gameNum);

dict[@"addTime"]=_addTime;

dict[@"gameCoin"]=@(_gameCoin);

dict[@"num"]=_num;

dict[@"remake"]=_remake;

dict[@"anchorId"]=@(_anchorId);

dict[@"anchorName"]=_anchorName;

dict[@"isAwards"]=@(_isAwards);

dict[@"parentType"]=_parentType;

dict[@"uid"]=@(_uid);

dict[@"gameName"]=_gameName;

dict[@"id"]=@(_id_field);

dict[@"time"]=@(_time);

dict[@"totalWinCoin"]=@(_totalWinCoin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameLuckDrawModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameLuckDrawModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameLuckDrawModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameLuckDrawModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameLuckDrawModel* sumMdl=[GameLuckDrawModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameLuckDrawModel*)getFromDict:(NSDictionary*)dict
{
GameLuckDrawModel* model=[[GameLuckDrawModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gameId=[dict[@"gameId"] isKindOfClass:[NSNull class]]?0:[dict[@"gameId"] longLongValue];

model.sonType=[dict[@"sonType"] isKindOfClass:[NSNull class]]?@"":dict[@"sonType"];

model.winNum=[dict[@"winNum"] isKindOfClass:[NSNull class]]?0:[dict[@"winNum"] intValue];

model.gameNum=[dict[@"gameNum"] isKindOfClass:[NSNull class]]?0:[dict[@"gameNum"] intValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?@"":dict[@"addTime"];

model.gameCoin=[dict[@"gameCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"gameCoin"] doubleValue];

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?@"":dict[@"num"];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.isAwards=[dict[@"isAwards"] isKindOfClass:[NSNull class]]?0:[dict[@"isAwards"] intValue];

model.parentType=[dict[@"parentType"] isKindOfClass:[NSNull class]]?@"":dict[@"parentType"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.gameName=[dict[@"gameName"] isKindOfClass:[NSNull class]]?@"":dict[@"gameName"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?0:[dict[@"time"] longLongValue];

model.totalWinCoin=[dict[@"totalWinCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"totalWinCoin"] doubleValue];


 return model;
}

 +(void)cloneObj:(GameLuckDrawModel*) source target:(GameLuckDrawModel*)target
{

target.gameId=source.gameId;

target.sonType=source.sonType;

target.winNum=source.winNum;

target.gameNum=source.gameNum;

target.addTime=source.addTime;

target.gameCoin=source.gameCoin;

target.num=source.num;

target.remake=source.remake;

target.anchorId=source.anchorId;

target.anchorName=source.anchorName;

target.isAwards=source.isAwards;

target.parentType=source.parentType;

target.uid=source.uid;

target.gameName=source.gameName;

target.id_field=source.id_field;

target.time=source.time;

target.totalWinCoin=source.totalWinCoin;

}

@end

