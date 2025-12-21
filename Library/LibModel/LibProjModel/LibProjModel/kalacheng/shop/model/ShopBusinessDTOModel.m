//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopBusinessDTOModel.h"
#import "ShopBusinessModel.h"
#import "ShopLiveDetailDTOModel.h"
#import "ShopGoodsDTOModel.h"




 @implementation ShopBusinessDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"business" : [ShopBusinessModel class],@"liveDetailDTO" : [ShopLiveDetailDTOModel class],@"goodsDTOList" : [ShopGoodsDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"business"]=[_business modelToJSONObject];

dict[@"sourceType"]=@(_sourceType);

dict[@"liveDetailDTO"]=[_liveDetailDTO modelToJSONObject];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_goodsDTOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShopGoodsDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"goodsDTOList"]=list;
}//end

dict[@"roomId"]=@(_roomId);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopBusinessDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopBusinessDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopBusinessDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopBusinessDTOModel* sumMdl=[ShopBusinessDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopBusinessDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopBusinessDTOModel* model=[[ShopBusinessDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.business=[ShopBusinessModel getFromDict:dict[@"business"]];

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];


//getFromDict对象转换  
model.liveDetailDTO=[ShopLiveDetailDTOModel getFromDict:dict[@"liveDetailDTO"]];

model.goodsDTOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"goodsDTOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopGoodsDTOModel* sumMdl=[ShopGoodsDTOModel getFromDict:subDic];
[model.goodsDTOList addObject:sumMdl];

}
}

}

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopBusinessDTOModel*) source target:(ShopBusinessDTOModel*)target
{
        if(source.business==nil)
        {
//            target.business=nil;
        }else
        {
            [ShopBusinessModel cloneObj:source.business target:target.business];
        }

target.sourceType=source.sourceType;
        if(source.liveDetailDTO==nil)
        {
//            target.liveDetailDTO=nil;
        }else
        {
            [ShopLiveDetailDTOModel cloneObj:source.liveDetailDTO target:target.liveDetailDTO];
        }

        if(source.goodsDTOList==nil)
        {
//            target.goodsDTOList=nil;
        }else
        {
            target.goodsDTOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.goodsDTOList.count;i++)
            {
		  [target.goodsDTOList addObject:[[ShopGoodsDTOModel alloc]init]];
            [ShopGoodsDTOModel cloneObj:source.goodsDTOList[i] target:target.goodsDTOList[i]];
            }
        }


target.roomId=source.roomId;

target.status=source.status;

}

@end

