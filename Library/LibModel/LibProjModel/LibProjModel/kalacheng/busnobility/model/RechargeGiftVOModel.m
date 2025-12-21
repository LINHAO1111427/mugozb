//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RechargeGiftVOModel.h"
#import "GiftPackVOModel.h"




 @implementation RechargeGiftVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"giftList" : [GiftPackVOModel class]};
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
GiftPackVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"giftList"]=list;
}//end

dict[@"money"]=@(_money);

dict[@"id"]=@(_id_field);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeGiftVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RechargeGiftVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RechargeGiftVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RechargeGiftVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeGiftVOModel* sumMdl=[RechargeGiftVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RechargeGiftVOModel*)getFromDict:(NSDictionary*)dict
{
RechargeGiftVOModel* model=[[RechargeGiftVOModel alloc]init];

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
GiftPackVOModel* sumMdl=[GiftPackVOModel getFromDict:subDic];
[model.giftList addObject:sumMdl];

}
}

}

model.money=[dict[@"money"] isKindOfClass:[NSNull class]]?0:[dict[@"money"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] intValue];


 return model;
}

 +(void)cloneObj:(RechargeGiftVOModel*) source target:(RechargeGiftVOModel*)target
{

        if(source.giftList==nil)
        {
//            target.giftList=nil;
        }else
        {
            target.giftList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.giftList.count;i++)
            {
		  [target.giftList addObject:[[GiftPackVOModel alloc]init]];
            [GiftPackVOModel cloneObj:source.giftList[i] target:target.giftList[i]];
            }
        }


target.money=source.money;

target.id_field=source.id_field;

target.coin=source.coin;

}

@end

