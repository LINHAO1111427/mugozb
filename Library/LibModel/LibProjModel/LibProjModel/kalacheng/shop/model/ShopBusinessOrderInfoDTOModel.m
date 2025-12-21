//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopBusinessOrderInfoDTOModel.h"




 @implementation ShopBusinessOrderInfoDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"income"]=@(_income);

dict[@"price"]=@(_price);

dict[@"count"]=@(_count);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessOrderInfoDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopBusinessOrderInfoDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopBusinessOrderInfoDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopBusinessOrderInfoDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopBusinessOrderInfoDTOModel* sumMdl=[ShopBusinessOrderInfoDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopBusinessOrderInfoDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopBusinessOrderInfoDTOModel* model=[[ShopBusinessOrderInfoDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.income=[dict[@"income"] isKindOfClass:[NSNull class]]?0:[dict[@"income"] doubleValue];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.count=[dict[@"count"] isKindOfClass:[NSNull class]]?0:[dict[@"count"] intValue];


 return model;
}

 +(void)cloneObj:(ShopBusinessOrderInfoDTOModel*) source target:(ShopBusinessOrderInfoDTOModel*)target
{

target.income=source.income;

target.price=source.price;

target.count=source.count;

}

@end

