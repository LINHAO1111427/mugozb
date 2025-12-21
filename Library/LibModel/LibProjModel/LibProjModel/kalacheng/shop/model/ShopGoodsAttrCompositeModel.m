//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsAttrCompositeModel.h"
#import "ShopGoodsAttrModel.h"
#import "ShopAttrValueModel.h"




 @implementation ShopGoodsAttrCompositeModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"shopGoodsAttr" : [ShopGoodsAttrModel class],@"shopAttrValues" : [ShopAttrValueModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"shopGoodsAttr"]=[_shopGoodsAttr modelToJSONObject];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shopAttrValues;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopAttrValueModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shopAttrValues"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrCompositeModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsAttrCompositeModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsAttrCompositeModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsAttrCompositeModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsAttrCompositeModel* sumMdl=[ShopGoodsAttrCompositeModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsAttrCompositeModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsAttrCompositeModel* model=[[ShopGoodsAttrCompositeModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.shopGoodsAttr=[ShopGoodsAttrModel getFromDict:dict[@"shopGoodsAttr"]];

model.shopAttrValues=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shopAttrValues"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrValueModel* sumMdl=[ShopAttrValueModel getFromDict:subDic];
[model.shopAttrValues addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ShopGoodsAttrCompositeModel*) source target:(ShopGoodsAttrCompositeModel*)target
{
        if(source.shopGoodsAttr==nil)
        {
//            target.shopGoodsAttr=nil;
        }else
        {
            [ShopGoodsAttrModel cloneObj:source.shopGoodsAttr target:target.shopGoodsAttr];
        }

        if(source.shopAttrValues==nil)
        {
//            target.shopAttrValues=nil;
        }else
        {
            target.shopAttrValues=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shopAttrValues.count;i++)
            {
		  [target.shopAttrValues addObject:[[ShopAttrValueModel alloc]init]];
            [ShopAttrValueModel cloneObj:source.shopAttrValues[i] target:target.shopAttrValues[i]];
            }
        }


}

@end

