//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GamePriceModel.h"




 @implementation GamePriceModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gameId"]=@(_gameId);

dict[@"gameNum"]=@(_gameNum);

dict[@"addTime"]=_addTime;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"remake"]=_remake;

dict[@"time"]=@(_time);

dict[@"useCoin"]=@(_useCoin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GamePriceModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GamePriceModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GamePriceModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GamePriceModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GamePriceModel* sumMdl=[GamePriceModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GamePriceModel*)getFromDict:(NSDictionary*)dict
{
GamePriceModel* model=[[GamePriceModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gameId=[dict[@"gameId"] isKindOfClass:[NSNull class]]?0:[dict[@"gameId"] longLongValue];

model.gameNum=[dict[@"gameNum"] isKindOfClass:[NSNull class]]?0:[dict[@"gameNum"] intValue];

model.addTime=[dict[@"addTime"] isKindOfClass:[NSNull class]]?@"":dict[@"addTime"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.time=[dict[@"time"] isKindOfClass:[NSNull class]]?0:[dict[@"time"] longLongValue];

model.useCoin=[dict[@"useCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"useCoin"] intValue];


 return model;
}

 +(void)cloneObj:(GamePriceModel*) source target:(GamePriceModel*)target
{

target.gameId=source.gameId;

target.gameNum=source.gameNum;

target.addTime=source.addTime;

target.name=source.name;

target.id_field=source.id_field;

target.remake=source.remake;

target.time=source.time;

target.useCoin=source.useCoin;

}

@end

