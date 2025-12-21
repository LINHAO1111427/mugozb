//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopCarDTOModel.h"
#import "ShopCarModel.h"




 @implementation ShopCarDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"shopCarList" : [ShopCarModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"businessId"]=@(_businessId);

dict[@"businessLogo"]=_businessLogo;

dict[@"businessName"]=_businessName;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shopCarList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopCarModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shopCarList"]=list;
}//end

dict[@"viewType"]=@(_viewType);

dict[@"checked"]=@(_checked);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopCarDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopCarDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopCarDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopCarDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopCarDTOModel* sumMdl=[ShopCarDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopCarDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopCarDTOModel* model=[[ShopCarDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.businessLogo=[dict[@"businessLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLogo"];

model.businessName=[dict[@"businessName"] isKindOfClass:[NSNull class]]?@"":dict[@"businessName"];

model.shopCarList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shopCarList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopCarModel* sumMdl=[ShopCarModel getFromDict:subDic];
[model.shopCarList addObject:sumMdl];

}
}

}

model.viewType=[dict[@"viewType"] isKindOfClass:[NSNull class]]?0:[dict[@"viewType"] intValue];

model.checked=[dict[@"checked"] isKindOfClass:[NSNull class]]?0:[dict[@"checked"] intValue];


 return model;
}

 +(void)cloneObj:(ShopCarDTOModel*) source target:(ShopCarDTOModel*)target
{

target.businessId=source.businessId;

target.businessLogo=source.businessLogo;

target.businessName=source.businessName;

        if(source.shopCarList==nil)
        {
//            target.shopCarList=nil;
        }else
        {
            target.shopCarList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shopCarList.count;i++)
            {
		  [target.shopCarList addObject:[[ShopCarModel alloc]init]];
            [ShopCarModel cloneObj:source.shopCarList[i] target:target.shopCarList[i]];
            }
        }


target.viewType=source.viewType;

target.checked=source.checked;

}

@end

