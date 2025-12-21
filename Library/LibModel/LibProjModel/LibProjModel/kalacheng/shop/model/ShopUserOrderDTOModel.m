//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopUserOrderDTOModel.h"
#import "ShopBusinessOrderModel.h"
#import "AppUserModel.h"
#import "ShopSubOrderModel.h"




 @implementation ShopUserOrderDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"businessOrder" : [ShopBusinessOrderModel class],@"buyUser" : [AppUserModel class],@"subOrderList" : [ShopSubOrderModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"businessOrder"]=[_businessOrder modelToJSONObject];

dict[@"buyUser"]=[_buyUser modelToJSONObject];

dict[@"logisticsNum"]=_logisticsNum;

dict[@"refundLogisticsNum"]=_refundLogisticsNum;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_subOrderList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopSubOrderModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"subOrderList"]=list;
}//end

dict[@"anchorId"]=@(_anchorId);

dict[@"goodsNum"]=@(_goodsNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopUserOrderDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopUserOrderDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopUserOrderDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopUserOrderDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopUserOrderDTOModel* sumMdl=[ShopUserOrderDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopUserOrderDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopUserOrderDTOModel* model=[[ShopUserOrderDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.businessOrder=[ShopBusinessOrderModel getFromDict:dict[@"businessOrder"]];


//getFromDict对象转换  
model.buyUser=[AppUserModel getFromDict:dict[@"buyUser"]];

model.logisticsNum=[dict[@"logisticsNum"] isKindOfClass:[NSNull class]]?@"":dict[@"logisticsNum"];

model.refundLogisticsNum=[dict[@"refundLogisticsNum"] isKindOfClass:[NSNull class]]?@"":dict[@"refundLogisticsNum"];

model.subOrderList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"subOrderList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopSubOrderModel* sumMdl=[ShopSubOrderModel getFromDict:subDic];
[model.subOrderList addObject:sumMdl];

}
}

}

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.goodsNum=[dict[@"goodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsNum"] intValue];


 return model;
}

 +(void)cloneObj:(ShopUserOrderDTOModel*) source target:(ShopUserOrderDTOModel*)target
{
        if(source.businessOrder==nil)
        {
//            target.businessOrder=nil;
        }else
        {
            [ShopBusinessOrderModel cloneObj:source.businessOrder target:target.businessOrder];
        }
        if(source.buyUser==nil)
        {
//            target.buyUser=nil;
        }else
        {
            [AppUserModel cloneObj:source.buyUser target:target.buyUser];
        }

target.logisticsNum=source.logisticsNum;

target.refundLogisticsNum=source.refundLogisticsNum;

        if(source.subOrderList==nil)
        {
//            target.subOrderList=nil;
        }else
        {
            target.subOrderList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.subOrderList.count;i++)
            {
		  [target.subOrderList addObject:[[ShopSubOrderModel alloc]init]];
            [ShopSubOrderModel cloneObj:source.subOrderList[i] target:target.subOrderList[i]];
            }
        }


target.anchorId=source.anchorId;

target.goodsNum=source.goodsNum;

}

@end

