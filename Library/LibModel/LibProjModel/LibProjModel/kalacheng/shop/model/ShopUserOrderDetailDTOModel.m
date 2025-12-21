//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopUserOrderDetailDTOModel.h"
#import "ShopOrderReturnProcessDTOModel.h"
#import "ShopParentOrderModel.h"
#import "ShopBusinessOrderModel.h"
#import "ShopSubOrderModel.h"




 @implementation ShopUserOrderDetailDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"processList" : [ShopOrderReturnProcessDTOModel class],@"parentOrder" : [ShopParentOrderModel class],@"businessOrder" : [ShopBusinessOrderModel class],@"subOrderList" : [ShopSubOrderModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_processList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopOrderReturnProcessDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"processList"]=list;
}//end

dict[@"parentOrder"]=[_parentOrder modelToJSONObject];

dict[@"businessOrder"]=[_businessOrder modelToJSONObject];

dict[@"sellerLogisticsContent"]=_sellerLogisticsContent;

dict[@"refundShowDay"]=_refundShowDay;


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

dict[@"buyUserAvatar"]=_buyUserAvatar;

dict[@"closingDate"]=[HttpClient stringFromDate:_closingDate];

dict[@"logisticsName"]=_logisticsName;

dict[@"sellerLogisticsTime"]=[HttpClient stringFromDate:_sellerLogisticsTime];

dict[@"buyUserId"]=@(_buyUserId);

dict[@"buyUserName"]=_buyUserName;

dict[@"refundLogisticsName"]=_refundLogisticsName;

dict[@"logisticsNum"]=_logisticsNum;

dict[@"refundLogisticsNum"]=_refundLogisticsNum;

dict[@"goodsNum"]=@(_goodsNum);

dict[@"buyerLogisticsContent"]=_buyerLogisticsContent;

dict[@"buyerLogisticsTime"]=[HttpClient stringFromDate:_buyerLogisticsTime];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopUserOrderDetailDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopUserOrderDetailDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopUserOrderDetailDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopUserOrderDetailDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopUserOrderDetailDTOModel* sumMdl=[ShopUserOrderDetailDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopUserOrderDetailDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopUserOrderDetailDTOModel* model=[[ShopUserOrderDetailDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.processList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"processList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopOrderReturnProcessDTOModel* sumMdl=[ShopOrderReturnProcessDTOModel getFromDict:subDic];
[model.processList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.parentOrder=[ShopParentOrderModel getFromDict:dict[@"parentOrder"]];


//getFromDict对象转换  
model.businessOrder=[ShopBusinessOrderModel getFromDict:dict[@"businessOrder"]];

model.sellerLogisticsContent=[dict[@"sellerLogisticsContent"] isKindOfClass:[NSNull class]]?@"":dict[@"sellerLogisticsContent"];

model.refundShowDay=[dict[@"refundShowDay"] isKindOfClass:[NSNull class]]?@"":dict[@"refundShowDay"];

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

model.buyUserAvatar=[dict[@"buyUserAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"buyUserAvatar"];


{
NSString *strDate= dict[@"closingDate"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.closingDate=date;
    }
}

model.logisticsName=[dict[@"logisticsName"] isKindOfClass:[NSNull class]]?@"":dict[@"logisticsName"];


{
NSString *strDate= dict[@"sellerLogisticsTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.sellerLogisticsTime=date;
    }
}

model.buyUserId=[dict[@"buyUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"buyUserId"] longLongValue];

model.buyUserName=[dict[@"buyUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"buyUserName"];

model.refundLogisticsName=[dict[@"refundLogisticsName"] isKindOfClass:[NSNull class]]?@"":dict[@"refundLogisticsName"];

model.logisticsNum=[dict[@"logisticsNum"] isKindOfClass:[NSNull class]]?@"":dict[@"logisticsNum"];

model.refundLogisticsNum=[dict[@"refundLogisticsNum"] isKindOfClass:[NSNull class]]?@"":dict[@"refundLogisticsNum"];

model.goodsNum=[dict[@"goodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsNum"] intValue];

model.buyerLogisticsContent=[dict[@"buyerLogisticsContent"] isKindOfClass:[NSNull class]]?@"":dict[@"buyerLogisticsContent"];


{
NSString *strDate= dict[@"buyerLogisticsTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.buyerLogisticsTime=date;
    }
}


 return model;
}

 +(void)cloneObj:(ShopUserOrderDetailDTOModel*) source target:(ShopUserOrderDetailDTOModel*)target
{

        if(source.processList==nil)
        {
//            target.processList=nil;
        }else
        {
            target.processList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.processList.count;i++)
            {
		  [target.processList addObject:[[ShopOrderReturnProcessDTOModel alloc]init]];
            [ShopOrderReturnProcessDTOModel cloneObj:source.processList[i] target:target.processList[i]];
            }
        }

        if(source.parentOrder==nil)
        {
//            target.parentOrder=nil;
        }else
        {
            [ShopParentOrderModel cloneObj:source.parentOrder target:target.parentOrder];
        }
        if(source.businessOrder==nil)
        {
//            target.businessOrder=nil;
        }else
        {
            [ShopBusinessOrderModel cloneObj:source.businessOrder target:target.businessOrder];
        }

target.sellerLogisticsContent=source.sellerLogisticsContent;

target.refundShowDay=source.refundShowDay;

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

target.buyUserAvatar=source.buyUserAvatar;

target.closingDate=source.closingDate;

target.logisticsName=source.logisticsName;

target.sellerLogisticsTime=source.sellerLogisticsTime;

target.buyUserId=source.buyUserId;

target.buyUserName=source.buyUserName;

target.refundLogisticsName=source.refundLogisticsName;

target.logisticsNum=source.logisticsNum;

target.refundLogisticsNum=source.refundLogisticsNum;

target.goodsNum=source.goodsNum;

target.buyerLogisticsContent=source.buyerLogisticsContent;

target.buyerLogisticsTime=source.buyerLogisticsTime;

}

@end

