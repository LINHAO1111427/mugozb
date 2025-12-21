//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopGoodsAttrDTOModel.h"
#import "ShopAttrValueModel.h"




 @implementation ShopGoodsAttrDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"attrValueList" : [ShopAttrValueModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"attrId"]=@(_attrId);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_attrValueList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopAttrValueModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"attrValueList"]=list;
}//end

dict[@"attrName"]=_attrName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopGoodsAttrDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopGoodsAttrDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopGoodsAttrDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopGoodsAttrDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsAttrDTOModel* sumMdl=[ShopGoodsAttrDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopGoodsAttrDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopGoodsAttrDTOModel* model=[[ShopGoodsAttrDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.attrId=[dict[@"attrId"] isKindOfClass:[NSNull class]]?0:[dict[@"attrId"] longLongValue];

model.attrValueList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"attrValueList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAttrValueModel* sumMdl=[ShopAttrValueModel getFromDict:subDic];
[model.attrValueList addObject:sumMdl];

}
}

}

model.attrName=[dict[@"attrName"] isKindOfClass:[NSNull class]]?@"":dict[@"attrName"];


 return model;
}

 +(void)cloneObj:(ShopGoodsAttrDTOModel*) source target:(ShopGoodsAttrDTOModel*)target
{

target.attrId=source.attrId;

        if(source.attrValueList==nil)
        {
//            target.attrValueList=nil;
        }else
        {
            target.attrValueList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.attrValueList.count;i++)
            {
		  [target.attrValueList addObject:[[ShopAttrValueModel alloc]init]];
            [ShopAttrValueModel cloneObj:source.attrValueList[i] target:target.attrValueList[i]];
            }
        }


target.attrName=source.attrName;

}

@end

