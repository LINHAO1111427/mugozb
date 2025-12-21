//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopAttrValueModel.h"




 @implementation ShopAttrValueModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"attributeId"]=@(_attributeId);

dict[@"goodsId"]=@(_goodsId);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrValueModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopAttrValueModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopAttrValueModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopAttrValueModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrValueModel* sumMdl=[ShopAttrValueModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopAttrValueModel*)getFromDict:(NSDictionary*)dict
{
ShopAttrValueModel* model=[[ShopAttrValueModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.attributeId=[dict[@"attributeId"] isKindOfClass:[NSNull class]]?0:[dict[@"attributeId"] longLongValue];

model.goodsId=[dict[@"goodsId"] isKindOfClass:[NSNull class]]?0:[dict[@"goodsId"] longLongValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(ShopAttrValueModel*) source target:(ShopAttrValueModel*)target
{

target.attributeId=source.attributeId;

target.goodsId=source.goodsId;

target.name=source.name;

target.id_field=source.id_field;

}

@end

