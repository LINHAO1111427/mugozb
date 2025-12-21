//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopCarAskDTOModel.h"




 @implementation ShopCarAskDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"goodsId"]=@(_goodsId);

dict[@"goodsNum"]=@(_goodsNum);

dict[@"skuId"]=@(_skuId);

dict[@"carId"]=@(_carId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarAskDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopCarAskDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopCarAskDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopCarAskDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopCarAskDTOModel* sumMdl=[ShopCarAskDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopCarAskDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopCarAskDTOModel* model=[[ShopCarAskDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.goodsNum=[dict[@"goodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsNum"] intValue];

model.skuId=[dict[@"skuId"] isKindOfClass:[NSNull class]]?0:[dict[@"skuId"] longLongValue];

model.carId=[dict[@"carId"] isKindOfClass:[NSNull class]]?0:[dict[@"carId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ShopCarAskDTOModel*) source target:(ShopCarAskDTOModel*)target
{

target.goodsId=source.goodsId;

target.goodsNum=source.goodsNum;

target.skuId=source.skuId;

target.carId=source.carId;

}

@end

