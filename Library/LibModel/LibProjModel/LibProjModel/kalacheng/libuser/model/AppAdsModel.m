//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppAdsModel.h"




 @implementation AppAdsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"des"]=_des;

dict[@"orderno"]=@(_orderno);

dict[@"thumb"]=_thumb;

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"name"]=_name;

dict[@"pid"]=@(_pid);

dict[@"playTime"]=@(_playTime);

dict[@"id"]=@(_id_field);

dict[@"url"]=_url;

dict[@"sid"]=@(_sid);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppAdsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppAdsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppAdsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppAdsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppAdsModel* sumMdl=[AppAdsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppAdsModel*)getFromDict:(NSDictionary*)dict
{
AppAdsModel* model=[[AppAdsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.des=[dict[@"des"] isKindOfClass:[NSNull class]]?@"":dict[@"des"];

model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.pid=[dict[@"pid"] isKindOfClass:[NSNull class]]?0:[dict[@"pid"] intValue];

model.playTime=[dict[@"playTime"] isKindOfClass:[NSNull class]]?0:[dict[@"playTime"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];

model.sid=[dict[@"sid"] isKindOfClass:[NSNull class]]?0:[dict[@"sid"] intValue];


 return model;
}

 +(void)cloneObj:(AppAdsModel*) source target:(AppAdsModel*)target
{

target.des=source.des;

target.orderno=source.orderno;

target.thumb=source.thumb;

target.addtime=source.addtime;

target.name=source.name;

target.pid=source.pid;

target.playTime=source.playTime;

target.id_field=source.id_field;

target.url=source.url;

target.sid=source.sid;

}

@end

