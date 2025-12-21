//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "StarPriceDOModel.h"




 @implementation StarPriceDOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"money"]=@(_money);

dict[@"price"]=@(_price);

dict[@"videoCoin"]=@(_videoCoin);

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<StarPriceDOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
StarPriceDOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<StarPriceDOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<StarPriceDOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(StarPriceDOModel*)getFromDict:(NSDictionary*)dict
{
StarPriceDOModel* model=[[StarPriceDOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.money=[dict[@"money"] isKindOfClass:[NSNull class]]?0:[dict[@"money"] doubleValue];

model.price=[dict[@"price"] isKindOfClass:[NSNull class]]?0:[dict[@"price"] doubleValue];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(StarPriceDOModel*) source target:(StarPriceDOModel*)target
{

target.money=source.money;

target.price=source.price;

target.videoCoin=source.videoCoin;

target.voiceCoin=source.voiceCoin;

target.id_field=source.id_field;

}

@end

