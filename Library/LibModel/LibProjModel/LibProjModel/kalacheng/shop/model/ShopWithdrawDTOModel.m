//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopWithdrawDTOModel.h"
#import "ShopWithdrawRecordModel.h"
#import "AppUsersCashAccountModel.h"




 @implementation ShopWithdrawDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"shopWithdrawRecordList" : [ShopWithdrawRecordModel class],@"account" : [AppUsersCashAccountModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"realAmount"]=@(_realAmount);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shopWithdrawRecordList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopWithdrawRecordModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shopWithdrawRecordList"]=list;
}//end

dict[@"sellRate"]=@(_sellRate);

dict[@"service"]=@(_service);

dict[@"account"]=[_account modelToJSONObject];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopWithdrawDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopWithdrawDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopWithdrawDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopWithdrawDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopWithdrawDTOModel* sumMdl=[ShopWithdrawDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopWithdrawDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopWithdrawDTOModel* model=[[ShopWithdrawDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.realAmount=[dict[@"realAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"realAmount"] doubleValue];

model.shopWithdrawRecordList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shopWithdrawRecordList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopWithdrawRecordModel* sumMdl=[ShopWithdrawRecordModel getFromDict:subDic];
[model.shopWithdrawRecordList addObject:sumMdl];

}
}

}

model.sellRate=[dict[@"sellRate"] isKindOfClass:[NSNull class]]?0:[dict[@"sellRate"] doubleValue];

model.service=[dict[@"service"] isKindOfClass:[NSNull class]]?0:[dict[@"service"] doubleValue];


//getFromDict对象转换  
model.account=[AppUsersCashAccountModel getFromDict:dict[@"account"]];


 return model;
}

 +(void)cloneObj:(ShopWithdrawDTOModel*) source target:(ShopWithdrawDTOModel*)target
{

target.realAmount=source.realAmount;

        if(source.shopWithdrawRecordList==nil)
        {
//            target.shopWithdrawRecordList=nil;
        }else
        {
            target.shopWithdrawRecordList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shopWithdrawRecordList.count;i++)
            {
		  [target.shopWithdrawRecordList addObject:[[ShopWithdrawRecordModel alloc]init]];
            [ShopWithdrawRecordModel cloneObj:source.shopWithdrawRecordList[i] target:target.shopWithdrawRecordList[i]];
            }
        }


target.sellRate=source.sellRate;

target.service=source.service;
        if(source.account==nil)
        {
//            target.account=nil;
        }else
        {
            [AppUsersCashAccountModel cloneObj:source.account target:target.account];
        }

}

@end

