//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "RechargeRulesVOModel.h"
#import "RechargeCenterGiftPackVOModel.h"




 @implementation RechargeRulesVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"gifList" : [RechargeCenterGiftPackVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_gifList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
RechargeCenterGiftPackVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"gifList"]=list;
}//end

dict[@"money"]=@(_money);

dict[@"productId"]=_productId;

dict[@"dicountDesr"]=_dicountDesr;

dict[@"nobleDiscountMoney"]=@(_nobleDiscountMoney);

dict[@"name"]=_name;

dict[@"discountMoney"]=@(_discountMoney);

dict[@"id"]=@(_id_field);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RechargeRulesVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
RechargeRulesVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<RechargeRulesVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<RechargeRulesVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeRulesVOModel* sumMdl=[RechargeRulesVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(RechargeRulesVOModel*)getFromDict:(NSDictionary*)dict
{
RechargeRulesVOModel* model=[[RechargeRulesVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"gifList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
RechargeCenterGiftPackVOModel* sumMdl=[RechargeCenterGiftPackVOModel getFromDict:subDic];
[model.gifList addObject:sumMdl];

}
}

}

model.money=[dict[@"money"] isKindOfClass:[NSNull class]]?0:[dict[@"money"] doubleValue];

model.productId=[dict[@"productId"] isKindOfClass:[NSNull class]]?@"":dict[@"productId"];

model.dicountDesr=[dict[@"dicountDesr"] isKindOfClass:[NSNull class]]?@"":dict[@"dicountDesr"];

model.nobleDiscountMoney=[dict[@"nobleDiscountMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleDiscountMoney"] doubleValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.discountMoney=[dict[@"discountMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"discountMoney"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(RechargeRulesVOModel*) source target:(RechargeRulesVOModel*)target
{

        if(source.gifList==nil)
        {
//            target.gifList=nil;
        }else
        {
            target.gifList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.gifList.count;i++)
            {
		  [target.gifList addObject:[[RechargeCenterGiftPackVOModel alloc]init]];
            [RechargeCenterGiftPackVOModel cloneObj:source.gifList[i] target:target.gifList[i]];
            }
        }


target.money=source.money;

target.productId=source.productId;

target.dicountDesr=source.dicountDesr;

target.nobleDiscountMoney=source.nobleDiscountMoney;

target.name=source.name;

target.discountMoney=source.discountMoney;

target.id_field=source.id_field;

target.coin=source.coin;

}

@end

