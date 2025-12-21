//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "NobleCenterVipPriceDTOModel.h"




 @implementation NobleCenterVipPriceDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"iosCoin"]=@(_iosCoin);

dict[@"iosId"]=_iosId;

dict[@"payType"]=@(_payType);

dict[@"endDay"]=@(_endDay);

dict[@"name"]=_name;

dict[@"androidCoin"]=@(_androidCoin);

dict[@"id"]=@(_id_field);

dict[@"sendCoin"]=@(_sendCoin);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<NobleCenterVipPriceDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
NobleCenterVipPriceDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<NobleCenterVipPriceDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<NobleCenterVipPriceDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
NobleCenterVipPriceDTOModel* sumMdl=[NobleCenterVipPriceDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(NobleCenterVipPriceDTOModel*)getFromDict:(NSDictionary*)dict
{
NobleCenterVipPriceDTOModel* model=[[NobleCenterVipPriceDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.iosCoin=[dict[@"iosCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"iosCoin"] doubleValue];

model.iosId=[dict[@"iosId"] isKindOfClass:[NSNull class]]?@"":dict[@"iosId"];

model.payType=[dict[@"payType"] isKindOfClass:[NSNull class]]?0:[dict[@"payType"] intValue];

model.endDay=[dict[@"endDay"] isKindOfClass:[NSNull class]]?0:[dict[@"endDay"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.androidCoin=[dict[@"androidCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"androidCoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sendCoin=[dict[@"sendCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"sendCoin"] doubleValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(NobleCenterVipPriceDTOModel*) source target:(NobleCenterVipPriceDTOModel*)target
{

target.iosCoin=source.iosCoin;

target.iosId=source.iosId;

target.payType=source.payType;

target.endDay=source.endDay;

target.name=source.name;

target.androidCoin=source.androidCoin;

target.id_field=source.id_field;

target.sendCoin=source.sendCoin;

target.coin=source.coin;

}

@end

