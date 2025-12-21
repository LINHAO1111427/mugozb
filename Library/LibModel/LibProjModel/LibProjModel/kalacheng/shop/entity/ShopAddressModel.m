//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopAddressModel.h"




 @implementation ShopAddressModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"area"]=_area;

dict[@"uid"]=@(_uid);

dict[@"isDefault"]=@(_isDefault);

dict[@"address"]=_address;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"city"]=_city;

dict[@"phoneNum"]=_phoneNum;

dict[@"id"]=@(_id_field);

dict[@"pro"]=_pro;

dict[@"userName"]=_userName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopAddressModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopAddressModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopAddressModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopAddressModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopAddressModel* sumMdl=[ShopAddressModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopAddressModel*)getFromDict:(NSDictionary*)dict
{
ShopAddressModel* model=[[ShopAddressModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.area=[dict[@"area"] isKindOfClass:[NSNull class]]?@"":dict[@"area"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.isDefault=[dict[@"isDefault"] isKindOfClass:[NSNull class]]?0:[dict[@"isDefault"] intValue];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.phoneNum=[dict[@"phoneNum"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneNum"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.pro=[dict[@"pro"] isKindOfClass:[NSNull class]]?@"":dict[@"pro"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];


 return model;
}

 +(void)cloneObj:(ShopAddressModel*) source target:(ShopAddressModel*)target
{

target.area=source.area;

target.uid=source.uid;

target.isDefault=source.isDefault;

target.address=source.address;

target.addTime=source.addTime;

target.city=source.city;

target.phoneNum=source.phoneNum;

target.id_field=source.id_field;

target.pro=source.pro;

target.userName=source.userName;

}

@end

