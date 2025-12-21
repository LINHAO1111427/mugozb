//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameUserPrizeDTOModel.h"
#import "GamePrizeRecordModel.h"




 @implementation GameUserPrizeDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"gamePrizeRecordList" : [GamePrizeRecordModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"luckDrawDate"]=_luckDrawDate;

dict[@"gameName"]=_gameName;


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


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserPrizeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameUserPrizeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameUserPrizeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameUserPrizeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameUserPrizeDTOModel* sumMdl=[GameUserPrizeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameUserPrizeDTOModel*)getFromDict:(NSDictionary*)dict
{
GameUserPrizeDTOModel* model=[[GameUserPrizeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.luckDrawDate=[dict[@"luckDrawDate"] isKindOfClass:[NSNull class]]?@"":dict[@"luckDrawDate"];

model.gameName=[dict[@"gameName"] isKindOfClass:[NSNull class]]?@"":dict[@"gameName"];

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


 return model;
}

 +(void)cloneObj:(GameUserPrizeDTOModel*) source target:(GameUserPrizeDTOModel*)target
{

target.luckDrawDate=source.luckDrawDate;

target.gameName=source.gameName;

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


}

@end

