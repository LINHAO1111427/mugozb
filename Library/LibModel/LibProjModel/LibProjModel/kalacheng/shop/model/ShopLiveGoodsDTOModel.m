//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLiveGoodsDTOModel.h"
#import "ShopLiveGoodsModel.h"




 @implementation ShopLiveGoodsDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"liveGoodsList" : [ShopLiveGoodsModel class]};
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
NSArray* objList=_liveGoodsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopLiveGoodsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"liveGoodsList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveGoodsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLiveGoodsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLiveGoodsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLiveGoodsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveGoodsDTOModel* sumMdl=[ShopLiveGoodsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLiveGoodsDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopLiveGoodsDTOModel* model=[[ShopLiveGoodsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.businessId=[dict[@"businessId"] isKindOfClass:[NSNull class]]?0:[dict[@"businessId"] longLongValue];

model.businessLogo=[dict[@"businessLogo"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLogo"];

model.businessName=[dict[@"businessName"] isKindOfClass:[NSNull class]]?@"":dict[@"businessName"];

model.liveGoodsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"liveGoodsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveGoodsModel* sumMdl=[ShopLiveGoodsModel getFromDict:subDic];
[model.liveGoodsList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ShopLiveGoodsDTOModel*) source target:(ShopLiveGoodsDTOModel*)target
{

target.businessId=source.businessId;

target.businessLogo=source.businessLogo;

target.businessName=source.businessName;

        if(source.liveGoodsList==nil)
        {
//            target.liveGoodsList=nil;
        }else
        {
            target.liveGoodsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.liveGoodsList.count;i++)
            {
		  [target.liveGoodsList addObject:[[ShopLiveGoodsModel alloc]init]];
            [ShopLiveGoodsModel cloneObj:source.liveGoodsList[i] target:target.liveGoodsList[i]];
            }
        }


}

@end

