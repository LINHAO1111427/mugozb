//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopOrderNumDTOModel.h"




 @implementation ShopOrderNumDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"finishedNum"]=@(_finishedNum);

dict[@"toBeReceivedNum"]=@(_toBeReceivedNum);

dict[@"toBePayNum"]=@(_toBePayNum);

dict[@"toBeDeliveredNum"]=@(_toBeDeliveredNum);

dict[@"cancelGoodsNum"]=@(_cancelGoodsNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopOrderNumDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopOrderNumDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopOrderNumDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopOrderNumDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopOrderNumDTOModel* sumMdl=[ShopOrderNumDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopOrderNumDTOModel*)getFromDict:(NSDictionary*)dict
{
ShopOrderNumDTOModel* model=[[ShopOrderNumDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.finishedNum=[dict[@"finishedNum"] isKindOfClass:[NSNull class]]?0:[dict[@"finishedNum"] intValue];

model.toBeReceivedNum=[dict[@"toBeReceivedNum"] isKindOfClass:[NSNull class]]?0:[dict[@"toBeReceivedNum"] intValue];

model.toBePayNum=[dict[@"toBePayNum"] isKindOfClass:[NSNull class]]?0:[dict[@"toBePayNum"] intValue];

model.toBeDeliveredNum=[dict[@"toBeDeliveredNum"] isKindOfClass:[NSNull class]]?0:[dict[@"toBeDeliveredNum"] intValue];

model.cancelGoodsNum=[dict[@"cancelGoodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"cancelGoodsNum"] intValue];


 return model;
}

 +(void)cloneObj:(ShopOrderNumDTOModel*) source target:(ShopOrderNumDTOModel*)target
{

target.finishedNum=source.finishedNum;

target.toBeReceivedNum=source.toBeReceivedNum;

target.toBePayNum=source.toBePayNum;

target.toBeDeliveredNum=source.toBeDeliveredNum;

target.cancelGoodsNum=source.cancelGoodsNum;

}

@end

