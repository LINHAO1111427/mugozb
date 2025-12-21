//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameKindModel.h"




 @implementation GameKindModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isProtect"]=@(_isProtect);

dict[@"luckyProbability"]=@(_luckyProbability);

dict[@"protectPrizeId"]=@(_protectPrizeId);

dict[@"addTime"]=_addTime;

dict[@"gameExplain"]=_gameExplain;

dict[@"luckyPrizeId"]=@(_luckyPrizeId);

dict[@"bottomProportion"]=@(_bottomProportion);

dict[@"remake"]=_remake;

dict[@"isLuckyBonus"]=@(_isLuckyBonus);

dict[@"isBottom"]=@(_isBottom);

dict[@"luckyEndTime"]=@(_luckyEndTime);

dict[@"isOpen"]=@(_isOpen);

dict[@"bottomPrizeNum"]=@(_bottomPrizeNum);

dict[@"luckyPrizeNum"]=@(_luckyPrizeNum);

dict[@"specialNote"]=_specialNote;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"bottomPrizeId"]=@(_bottomPrizeId);

dict[@"luckyStartTime"]=@(_luckyStartTime);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameKindModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameKindModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameKindModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameKindModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameKindModel* sumMdl=[GameKindModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameKindModel*)getFromDict:(NSDictionary*)dict
{
GameKindModel* model=[[GameKindModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isProtect=[dict[@"isProtect"] isKindOfClass:[NSNull class]]?0:[dict[@"isProtect"] intValue];

model.luckyProbability=[dict[@"luckyProbability"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyProbability"] doubleValue];

model.protectPrizeId=[dict[@"protectPrizeId"] isKindOfClass:[NSNull class]]?0:[dict[@"protectPrizeId"] longLongValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?@"":dict[@"addTime"];

model.gameExplain=[dict[@"gameExplain"] isKindOfClass:[NSNull class]]?@"":dict[@"gameExplain"];

model.luckyPrizeId=[dict[@"luckyPrizeId"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyPrizeId"] longLongValue];

model.bottomProportion=[dict[@"bottomProportion"] isKindOfClass:[NSNull class]]?0:[dict[@"bottomProportion"] doubleValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.isLuckyBonus=[dict[@"isLuckyBonus"] isKindOfClass:[NSNull class]]?0:[dict[@"isLuckyBonus"] intValue];

model.isBottom=[dict[@"isBottom"] isKindOfClass:[NSNull class]]?0:[dict[@"isBottom"] intValue];

model.luckyEndTime=[dict[@"luckyEndTime"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyEndTime"] intValue];

model.isOpen=[dict[@"isOpen"] isKindOfClass:[NSNull class]]?0:[dict[@"isOpen"] intValue];

model.bottomPrizeNum=[dict[@"bottomPrizeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"bottomPrizeNum"] intValue];

model.luckyPrizeNum=[dict[@"luckyPrizeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyPrizeNum"] intValue];

model.specialNote=[dict[@"specialNote"] isKindOfClass:[NSNull class]]?@"":dict[@"specialNote"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.bottomPrizeId=[dict[@"bottomPrizeId"] isKindOfClass:[NSNull class]]?0:[dict[@"bottomPrizeId"] longLongValue];

model.luckyStartTime=[dict[@"luckyStartTime"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyStartTime"] intValue];


 return model;
}

 +(void)cloneObj:(GameKindModel*) source target:(GameKindModel*)target
{

target.isProtect=source.isProtect;

target.luckyProbability=source.luckyProbability;

target.protectPrizeId=source.protectPrizeId;

target.addTime=source.addTime;

target.gameExplain=source.gameExplain;

target.luckyPrizeId=source.luckyPrizeId;

target.bottomProportion=source.bottomProportion;

target.remake=source.remake;

target.isLuckyBonus=source.isLuckyBonus;

target.isBottom=source.isBottom;

target.luckyEndTime=source.luckyEndTime;

target.isOpen=source.isOpen;

target.bottomPrizeNum=source.bottomPrizeNum;

target.luckyPrizeNum=source.luckyPrizeNum;

target.specialNote=source.specialNote;

target.name=source.name;

target.id_field=source.id_field;

target.bottomPrizeId=source.bottomPrizeId;

target.luckyStartTime=source.luckyStartTime;

}

@end

