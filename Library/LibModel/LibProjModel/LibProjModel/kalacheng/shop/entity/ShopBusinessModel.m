//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ShopBusinessModel.h"




 @implementation ShopBusinessModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"businessLicense"]=_businessLicense;

dict[@"amount"]=@(_amount);

dict[@"totalSoldNum"]=@(_totalSoldNum);

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"presentPicture"]=_presentPicture;

dict[@"mobile"]=_mobile;

dict[@"materialsReview"]=@(_materialsReview);

dict[@"remake"]=_remake;

dict[@"anchorId"]=@(_anchorId);

dict[@"auditRemake"]=_auditRemake;

dict[@"totalAmount"]=@(_totalAmount);

dict[@"auditTime"]=[HttpClient stringFromDate:_auditTime];

dict[@"name"]=_name;

dict[@"totalCash"]=@(_totalCash);

dict[@"logo"]=_logo;

dict[@"statusRemake"]=_statusRemake;

dict[@"id"]=@(_id_field);

dict[@"present"]=_present;

dict[@"effectiveGoodsNum"]=@(_effectiveGoodsNum);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopBusinessModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ShopBusinessModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ShopBusinessModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ShopBusinessModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShopBusinessModel* sumMdl=[ShopBusinessModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ShopBusinessModel*)getFromDict:(NSDictionary*)dict
{
ShopBusinessModel* model=[[ShopBusinessModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.businessLicense=[dict[@"businessLicense"] isKindOfClass:[NSNull class]]?@"":dict[@"businessLicense"];

model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.totalSoldNum=[dict[@"totalSoldNum"] isKindOfClass:[NSNull class]]?0:[dict[@"totalSoldNum"] intValue];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.presentPicture=[dict[@"presentPicture"] isKindOfClass:[NSNull class]]?@"":dict[@"presentPicture"];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.materialsReview=[dict[@"materialsReview"] isKindOfClass:[NSNull class]]?0:[dict[@"materialsReview"] intValue];

model.remake=[dict[@"remake"] isKindOfClass:[NSNull class]]?@"":dict[@"remake"];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.auditRemake=[dict[@"auditRemake"] isKindOfClass:[NSNull class]]?@"":dict[@"auditRemake"];

model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];


{
NSString *strDate= dict[@"auditTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.auditTime=date;
    }
}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.totalCash=[dict[@"totalCash"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCash"] doubleValue];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.statusRemake=[dict[@"statusRemake"] isKindOfClass:[NSNull class]]?@"":dict[@"statusRemake"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.present=[dict[@"present"] isKindOfClass:[NSNull class]]?@"":dict[@"present"];

model.effectiveGoodsNum=[dict[@"effectiveGoodsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"effectiveGoodsNum"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(ShopBusinessModel*) source target:(ShopBusinessModel*)target
{

target.businessLicense=source.businessLicense;

target.amount=source.amount;

target.totalSoldNum=source.totalSoldNum;

target.addTime=source.addTime;

target.presentPicture=source.presentPicture;

target.mobile=source.mobile;

target.materialsReview=source.materialsReview;

target.remake=source.remake;

target.anchorId=source.anchorId;

target.auditRemake=source.auditRemake;

target.totalAmount=source.totalAmount;

target.auditTime=source.auditTime;

target.name=source.name;

target.totalCash=source.totalCash;

target.logo=source.logo;

target.statusRemake=source.statusRemake;

target.id_field=source.id_field;

target.present=source.present;

target.effectiveGoodsNum=source.effectiveGoodsNum;

target.status=source.status;

}

@end

