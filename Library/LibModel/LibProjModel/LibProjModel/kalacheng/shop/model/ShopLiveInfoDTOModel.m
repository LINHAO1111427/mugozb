//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLiveInfoDTOModel.h"
#import "LiveLiveModel.h"
#import "ShopLiveGoodsModel.h"
#import "ShopBusinessModel.h"




 @implementation ShopLiveInfoDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appUsersLive" : [LiveLiveModel class],@"shopLiveGoods" : [ShopLiveGoodsModel class],@"shopBusiness" : [ShopBusinessModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"appUsersLive"]=[_appUsersLive modelToJSONObject];

dict[@"shopLiveGoods"]=[_shopLiveGoods modelToJSONObject];

dict[@"shopBusiness"]=[_shopBusiness modelToJSONObject];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveInfoDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLiveInfoDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLiveInfoDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLiveInfoDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveInfoDTOModel* sumMdl=[ShopLiveInfoDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLiveInfoDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopLiveInfoDTOModel* model=[[ShopLiveInfoDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.appUsersLive=[LiveLiveModel getFromDict:dict[@"appUsersLive"]];


//getFromDict对象转换  
model.shopLiveGoods=[ShopLiveGoodsModel getFromDict:dict[@"shopLiveGoods"]];


//getFromDict对象转换  
model.shopBusiness=[ShopBusinessModel getFromDict:dict[@"shopBusiness"]];


 return model;
}

 +(void)cloneObj:(ShopLiveInfoDTOModel*) source target:(ShopLiveInfoDTOModel*)target
{
        if(source.appUsersLive==nil)
        {
//            target.appUsersLive=nil;
        }else
        {
            [LiveLiveModel cloneObj:source.appUsersLive target:target.appUsersLive];
        }
        if(source.shopLiveGoods==nil)
        {
//            target.shopLiveGoods=nil;
        }else
        {
            [ShopLiveGoodsModel cloneObj:source.shopLiveGoods target:target.shopLiveGoods];
        }
        if(source.shopBusiness==nil)
        {
//            target.shopBusiness=nil;
        }else
        {
            [ShopBusinessModel cloneObj:source.shopBusiness target:target.shopBusiness];
        }

}

@end

