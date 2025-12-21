//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLiangModel.h"




 @implementation AppLiangModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"orderno"]=@(_orderno);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"length"]=@(_length);

dict[@"name"]=_name;

dict[@"buytime"]=[HttpClient stringFromDate:_buytime];

dict[@"id"]=@(_id_field);

dict[@"state"]=@(_state);

dict[@"userid"]=@(_userid);

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiangModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLiangModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLiangModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLiangModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiangModel* sumMdl=[AppLiangModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLiangModel*)getFromDict:(NSDictionary*)dict
{
AppLiangModel* model=[[AppLiangModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.length=[dict[@"length"] isKindOfClass:[NSNull class]]?0:[dict[@"length"] intValue];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];


{
NSString *strDate= dict[@"buytime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.buytime=date;
    }
}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.state=[dict[@"state"] isKindOfClass:[NSNull class]]?0:[dict[@"state"] intValue];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppLiangModel*) source target:(AppLiangModel*)target
{

target.orderno=source.orderno;

target.addtime=source.addtime;

target.length=source.length;

target.name=source.name;

target.buytime=source.buytime;

target.id_field=source.id_field;

target.state=source.state;

target.userid=source.userid;

target.coin=source.coin;

target.status=source.status;

}

@end

