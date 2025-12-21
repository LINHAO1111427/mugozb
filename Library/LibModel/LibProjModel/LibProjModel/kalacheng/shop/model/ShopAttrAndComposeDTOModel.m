//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopAttrAndComposeDTOModel.h"
#import "ShopAttrComposeModel.h"
#import "ShopGoodsAttrDTOModel.h"




 @implementation ShopAttrAndComposeDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"attrComposeList" : [ShopAttrComposeModel class],@"shopGoodsAttrDTOS" : [ShopGoodsAttrDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_attrComposeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopAttrComposeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"attrComposeList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shopGoodsAttrDTOS;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopGoodsAttrDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shopGoodsAttrDTOS"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAttrAndComposeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopAttrAndComposeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopAttrAndComposeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopAttrAndComposeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrAndComposeDTOModel* sumMdl=[ShopAttrAndComposeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopAttrAndComposeDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopAttrAndComposeDTOModel* model=[[ShopAttrAndComposeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.attrComposeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"attrComposeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrComposeModel* sumMdl=[ShopAttrComposeModel getFromDict:subDic];
[model.attrComposeList addObject:sumMdl];

}
}

}

model.shopGoodsAttrDTOS=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shopGoodsAttrDTOS"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsAttrDTOModel* sumMdl=[ShopGoodsAttrDTOModel getFromDict:subDic];
[model.shopGoodsAttrDTOS addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ShopAttrAndComposeDTOModel*) source target:(ShopAttrAndComposeDTOModel*)target
{

        if(source.attrComposeList==nil)
        {
//            target.attrComposeList=nil;
        }else
        {
            target.attrComposeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.attrComposeList.count;i++)
            {
		  [target.attrComposeList addObject:[[ShopAttrComposeModel alloc]init]];
            [ShopAttrComposeModel cloneObj:source.attrComposeList[i] target:target.attrComposeList[i]];
            }
        }


        if(source.shopGoodsAttrDTOS==nil)
        {
//            target.shopGoodsAttrDTOS=nil;
        }else
        {
            target.shopGoodsAttrDTOS=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shopGoodsAttrDTOS.count;i++)
            {
		  [target.shopGoodsAttrDTOS addObject:[[ShopGoodsAttrDTOModel alloc]init]];
            [ShopGoodsAttrDTOModel cloneObj:source.shopGoodsAttrDTOS[i] target:target.shopGoodsAttrDTOS[i]];
            }
        }


}

@end

