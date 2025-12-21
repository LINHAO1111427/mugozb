//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameAwardsAndPriceDTOModel.h"
#import "GameAwardsVOModel.h"
#import "GamePriceModel.h"




 @implementation GameAwardsAndPriceDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"gameAwardsList" : [GameAwardsVOModel class],@"gamePriceList" : [GamePriceModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"luckyEndTime"]=_luckyEndTime;

dict[@"luckyPrizeNum"]=@(_luckyPrizeNum);

dict[@"specialNote"]=_specialNote;

dict[@"userLuckyNum"]=@(_userLuckyNum);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_gameAwardsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GameAwardsVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"gameAwardsList"]=list;
}//end

dict[@"luckyStartTime"]=_luckyStartTime;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_gamePriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GamePriceModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"gamePriceList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameAwardsAndPriceDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameAwardsAndPriceDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameAwardsAndPriceDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameAwardsAndPriceDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameAwardsAndPriceDTOModel* sumMdl=[GameAwardsAndPriceDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameAwardsAndPriceDTOModel*)getFromDict:(NSDictionary*)dict
{
GameAwardsAndPriceDTOModel* model=[[GameAwardsAndPriceDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.luckyEndTime=[dict[@"luckyEndTime"] isKindOfClass:[NSNull class]]?@"":dict[@"luckyEndTime"];

model.luckyPrizeNum=[dict[@"luckyPrizeNum"] isKindOfClass:[NSNull class]]?0:[dict[@"luckyPrizeNum"] intValue];

model.specialNote=[dict[@"specialNote"] isKindOfClass:[NSNull class]]?@"":dict[@"specialNote"];

model.userLuckyNum=[dict[@"userLuckyNum"] isKindOfClass:[NSNull class]]?0:[dict[@"userLuckyNum"] intValue];

model.gameAwardsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"gameAwardsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameAwardsVOModel* sumMdl=[GameAwardsVOModel getFromDict:subDic];
[model.gameAwardsList addObject:sumMdl];

}
}

}

model.luckyStartTime=[dict[@"luckyStartTime"] isKindOfClass:[NSNull class]]?@"":dict[@"luckyStartTime"];

model.gamePriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"gamePriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GamePriceModel* sumMdl=[GamePriceModel getFromDict:subDic];
[model.gamePriceList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(GameAwardsAndPriceDTOModel*) source target:(GameAwardsAndPriceDTOModel*)target
{

target.luckyEndTime=source.luckyEndTime;

target.luckyPrizeNum=source.luckyPrizeNum;

target.specialNote=source.specialNote;

target.userLuckyNum=source.userLuckyNum;

        if(source.gameAwardsList==nil)
        {
//            target.gameAwardsList=nil;
        }else
        {
            target.gameAwardsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.gameAwardsList.count;i++)
            {
		  [target.gameAwardsList addObject:[[GameAwardsVOModel alloc]init]];
            [GameAwardsVOModel cloneObj:source.gameAwardsList[i] target:target.gameAwardsList[i]];
            }
        }


target.luckyStartTime=source.luckyStartTime;

        if(source.gamePriceList==nil)
        {
//            target.gamePriceList=nil;
        }else
        {
            target.gamePriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.gamePriceList.count;i++)
            {
		  [target.gamePriceList addObject:[[GamePriceModel alloc]init]];
            [GamePriceModel cloneObj:source.gamePriceList[i] target:target.gamePriceList[i]];
            }
        }


}

@end

