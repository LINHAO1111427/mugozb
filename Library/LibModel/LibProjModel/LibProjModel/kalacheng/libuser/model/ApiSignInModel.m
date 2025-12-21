//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSignInModel.h"




 @implementation ApiSignInModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"giftId"]=@(_giftId);

dict[@"image"]=_image;

dict[@"isGet"]=@(_isGet);

dict[@"typeVal"]=@(_typeVal);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"dayNumber"]=@(_dayNumber);

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSignInModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSignInModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSignInModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSignInModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSignInModel* sumMdl=[ApiSignInModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSignInModel*)getFromDict:(NSDictionary*)dict
{
ApiSignInModel* model=[[ApiSignInModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.image=[dict[@"image"] isKindOfClass:[NSNull class]]?@"":dict[@"image"];

model.isGet=[dict[@"isGet"] isKindOfClass:[NSNull class]]?0:[dict[@"isGet"] intValue];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?0:[dict[@"typeVal"] intValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.dayNumber=[dict[@"dayNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"dayNumber"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

 +(void)cloneObj:(ApiSignInModel*) source target:(ApiSignInModel*)target
{

target.giftId=source.giftId;

target.image=source.image;

target.isGet=source.isGet;

target.typeVal=source.typeVal;

target.createTime=source.createTime;

target.dayNumber=source.dayNumber;

target.name=source.name;

target.id_field=source.id_field;

target.type=source.type;

}

@end

