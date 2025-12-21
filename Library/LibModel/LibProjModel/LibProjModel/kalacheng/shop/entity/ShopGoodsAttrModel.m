//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsAttrModel.h"




 @implementation ShopGoodsAttrModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"goodsId"]=@(_goodsId);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsAttrModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsAttrModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsAttrModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsAttrModel* sumMdl=[ShopGoodsAttrModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsAttrModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsAttrModel* model=[[ShopGoodsAttrModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(ShopGoodsAttrModel*) source target:(ShopGoodsAttrModel*)target
{

target.goodsId=source.goodsId;

target.name=source.name;

target.id_field=source.id_field;

}

@end

