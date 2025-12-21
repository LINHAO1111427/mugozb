//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopLiveDetailDTOModel.h"
#import "ShopLiveGoodsModel.h"




 @implementation ShopLiveDetailDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"liveGoodsList" : [ShopLiveGoodsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"thumb"]=_thumb;

dict[@"liveUsers"]=@(_liveUsers);

dict[@"title"]=_title;


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

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLiveDetailDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopLiveDetailDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopLiveDetailDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopLiveDetailDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopLiveDetailDTOModel* sumMdl=[ShopLiveDetailDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopLiveDetailDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopLiveDetailDTOModel* model=[[ShopLiveDetailDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.liveUsers=[dict[@"liveUsers"] isKindOfClass:[NSNull class]]?0:[dict[@"liveUsers"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

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

 +(void)cloneObj:(ShopLiveDetailDTOModel*) source target:(ShopLiveDetailDTOModel*)target
{

target.thumb=source.thumb;

target.liveUsers=source.liveUsers;

target.title=source.title;

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

