//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameUserLuckDrawDTOModel.h"
#import "GamePrizeRecordModel.h"
#import "GameLuckDrawModel.h"




 @implementation GameUserLuckDrawDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"gamePrizeRecordList" : [GamePrizeRecordModel class],@"gameLuckDraw" : [GameLuckDrawModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userGameNum"]=@(_userGameNum);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_gamePrizeRecordList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GamePrizeRecordModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"gamePrizeRecordList"]=list;
}//end

dict[@"gameLuckDraw"]=[_gameLuckDraw modelToJSONObject];

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserLuckDrawDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameUserLuckDrawDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameUserLuckDrawDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameUserLuckDrawDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameUserLuckDrawDTOModel* sumMdl=[GameUserLuckDrawDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameUserLuckDrawDTOModel*)getFromDict:(NSDictionary*)dict
{
GameUserLuckDrawDTOModel* model=[[GameUserLuckDrawDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userGameNum=[dict[@"userGameNum"] isKindOfClass:[NSNull class]]?0:[dict[@"userGameNum"] intValue];

model.gamePrizeRecordList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"gamePrizeRecordList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GamePrizeRecordModel* sumMdl=[GamePrizeRecordModel getFromDict:subDic];
[model.gamePrizeRecordList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.gameLuckDraw=[GameLuckDrawModel getFromDict:dict[@"gameLuckDraw"]];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(GameUserLuckDrawDTOModel*) source target:(GameUserLuckDrawDTOModel*)target
{

target.userGameNum=source.userGameNum;

        if(source.gamePrizeRecordList==nil)
        {
//            target.gamePrizeRecordList=nil;
        }else
        {
            target.gamePrizeRecordList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.gamePrizeRecordList.count;i++)
            {
		  [target.gamePrizeRecordList addObject:[[GamePrizeRecordModel alloc]init]];
            [GamePrizeRecordModel cloneObj:source.gamePrizeRecordList[i] target:target.gamePrizeRecordList[i]];
            }
        }

        if(source.gameLuckDraw==nil)
        {
//            target.gameLuckDraw=nil;
        }else
        {
            [GameLuckDrawModel cloneObj:source.gameLuckDraw target:target.gameLuckDraw];
        }

target.coin=source.coin;

}

@end

