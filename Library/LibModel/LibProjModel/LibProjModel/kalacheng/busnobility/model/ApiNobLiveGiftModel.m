//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiNobLiveGiftModel.h"
#import "NobLiveGiftModel.h"




 @implementation ApiNobLiveGiftModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"giftList" : [NobLiveGiftModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_giftList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
NobLiveGiftModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"giftList"]=list;
}//end

dict[@"backGiftCoin"]=@(_backGiftCoin);

dict[@"giftTypeName"]=_giftTypeName;

dict[@"giftTypeId"]=@(_giftTypeId);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiNobLiveGiftModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiNobLiveGiftModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiNobLiveGiftModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiNobLiveGiftModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiNobLiveGiftModel* sumMdl=[ApiNobLiveGiftModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiNobLiveGiftModel*)getFromDict:(NSDictionary*)dict
{
ApiNobLiveGiftModel* model=[[ApiNobLiveGiftModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.giftList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"giftList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
NobLiveGiftModel* sumMdl=[NobLiveGiftModel getFromDict:subDic];
[model.giftList addObject:sumMdl];

}
}

}

model.backGiftCoin=[dict[@"backGiftCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"backGiftCoin"] doubleValue];

model.giftTypeName=[dict[@"giftTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"giftTypeName"];

model.giftTypeId=[dict[@"giftTypeId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftTypeId"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(ApiNobLiveGiftModel*) source target:(ApiNobLiveGiftModel*)target
{

        if(source.giftList==nil)
        {
//            target.giftList=nil;
        }else
        {
            target.giftList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.giftList.count;i++)
            {
		  [target.giftList addObject:[[NobLiveGiftModel alloc]init]];
            [NobLiveGiftModel cloneObj:source.giftList[i] target:target.giftList[i]];
            }
        }


target.backGiftCoin=source.backGiftCoin;

target.giftTypeName=source.giftTypeName;

target.giftTypeId=source.giftTypeId;

target.coin=source.coin;

}

@end

