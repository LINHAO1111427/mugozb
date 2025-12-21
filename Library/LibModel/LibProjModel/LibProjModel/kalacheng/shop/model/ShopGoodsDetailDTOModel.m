//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsDetailDTOModel.h"
#import "ShopAttrComposeModel.h"
#import "ShopGoodsModel.h"
#import "ShopGoodsDTOModel.h"
#import "ShopGoodsAttrDTOModel.h"




 @implementation ShopGoodsDetailDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"composeList" : [ShopAttrComposeModel class],@"shopGoods" : [ShopGoodsModel class],@"shopGoodsDTOS" : [ShopGoodsDTOModel class],@"recommendGoodsDTOS" : [ShopGoodsDTOModel class],@"attrDTOList" : [ShopGoodsAttrDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"totalSoldNum"]=@(_totalSoldNum);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_composeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopAttrComposeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"composeList"]=list;
}//end

dict[@"shopGoods"]=[_shopGoods modelToJSONObject];

dict[@"businessLogo"]=_businessLogo;

dict[@"businessName"]=_businessName;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shopGoodsDTOS;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopGoodsDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shopGoodsDTOS"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_recommendGoodsDTOS;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopGoodsDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"recommendGoodsDTOS"]=list;
}//end

dict[@"anchorId"]=@(_anchorId);

dict[@"effectiveGoodsNum"]=@(_effectiveGoodsNum);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_attrDTOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopGoodsAttrDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"attrDTOList"]=list;
}//end

dict[@"shopCarNum"]=@(_shopCarNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsDetailDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsDetailDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsDetailDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsDetailDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsDetailDTOModel* sumMdl=[ShopGoodsDetailDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsDetailDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsDetailDTOModel* model=[[ShopGoodsDetailDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.totalSoldNum=[dict[@"totalSoldNum"] isKindOfClass:[NSNull class]]?0:[dict[@"totalSoldNum"] intValue];

model.composeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"composeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrComposeModel* sumMdl=[ShopAttrComposeModel getFromDict:subDic];
[model.composeList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.shopGoods=[ShopGoodsModel getFromDict:dict[@"shopGoods"]];

model.businessLogo=[dict[@"businessLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLogo"];

model.businessName=[dict[@"businessName"] isKindOfClass:[NSNull class]]?@"":dict[@"businessName"];

model.shopGoodsDTOS=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shopGoodsDTOS"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsDTOModel* sumMdl=[ShopGoodsDTOModel getFromDict:subDic];
[model.shopGoodsDTOS addObject:sumMdl];

}
}

}

model.recommendGoodsDTOS=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"recommendGoodsDTOS"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsDTOModel* sumMdl=[ShopGoodsDTOModel getFromDict:subDic];
[model.recommendGoodsDTOS addObject:sumMdl];

}
}

}

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.effectiveGoodsNum=[dict[@"effectiveGoodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"effectiveGoodsNum"] intValue];

model.attrDTOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"attrDTOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsAttrDTOModel* sumMdl=[ShopGoodsAttrDTOModel getFromDict:subDic];
[model.attrDTOList addObject:sumMdl];

}
}

}

model.shopCarNum=[dict[@"shopCarNum"] isKindOfClass:[NSNull class]]?0:[dict[@"shopCarNum"] intValue];


 return model;
}

 +(void)cloneObj:(ShopGoodsDetailDTOModel*) source target:(ShopGoodsDetailDTOModel*)target
{

target.totalSoldNum=source.totalSoldNum;

        if(source.composeList==nil)
        {
//            target.composeList=nil;
        }else
        {
            target.composeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.composeList.count;i++)
            {
		  [target.composeList addObject:[[ShopAttrComposeModel alloc]init]];
            [ShopAttrComposeModel cloneObj:source.composeList[i] target:target.composeList[i]];
            }
        }

        if(source.shopGoods==nil)
        {
//            target.shopGoods=nil;
        }else
        {
            [ShopGoodsModel cloneObj:source.shopGoods target:target.shopGoods];
        }

target.businessLogo=source.businessLogo;

target.businessName=source.businessName;

        if(source.shopGoodsDTOS==nil)
        {
//            target.shopGoodsDTOS=nil;
        }else
        {
            target.shopGoodsDTOS=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shopGoodsDTOS.count;i++)
            {
		  [target.shopGoodsDTOS addObject:[[ShopGoodsDTOModel alloc]init]];
            [ShopGoodsDTOModel cloneObj:source.shopGoodsDTOS[i] target:target.shopGoodsDTOS[i]];
            }
        }


        if(source.recommendGoodsDTOS==nil)
        {
//            target.recommendGoodsDTOS=nil;
        }else
        {
            target.recommendGoodsDTOS=[[NSMutableArray alloc] init];
            for(int i=0;i<source.recommendGoodsDTOS.count;i++)
            {
		  [target.recommendGoodsDTOS addObject:[[ShopGoodsDTOModel alloc]init]];
            [ShopGoodsDTOModel cloneObj:source.recommendGoodsDTOS[i] target:target.recommendGoodsDTOS[i]];
            }
        }


target.anchorId=source.anchorId;

target.effectiveGoodsNum=source.effectiveGoodsNum;

        if(source.attrDTOList==nil)
        {
//            target.attrDTOList=nil;
        }else
        {
            target.attrDTOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.attrDTOList.count;i++)
            {
		  [target.attrDTOList addObject:[[ShopGoodsAttrDTOModel alloc]init]];
            [ShopGoodsAttrDTOModel cloneObj:source.attrDTOList[i] target:target.attrDTOList[i]];
            }
        }


target.shopCarNum=source.shopCarNum;

}

@end

