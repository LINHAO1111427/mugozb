//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLiveTagModel.h"




 @implementation AppLiveTagModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"tagStyle"]=_tagStyle;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"isTip"]=@(_isTip);

dict[@"channel_id"]=@(_channel_id);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveTagModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLiveTagModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLiveTagModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLiveTagModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveTagModel* sumMdl=[AppLiveTagModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLiveTagModel*)getFromDict:(NSDictionary*)dict
{
AppLiveTagModel* model=[[AppLiveTagModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.tagStyle=[dict[@"tagStyle"] isKindOfClass:[NSNull class]]?@"":dict[@"tagStyle"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.isTip=[dict[@"isTip"] isKindOfClass:[NSNull class]]?0:[dict[@"isTip"] intValue];

model.channel_id=[dict[@"channel_id"] isKindOfClass:[NSNull class]]?0:[dict[@"channel_id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppLiveTagModel*) source target:(AppLiveTagModel*)target
{

target.addTime=source.addTime;

target.tagStyle=source.tagStyle;

target.name=source.name;

target.id_field=source.id_field;

target.sort=source.sort;

target.isTip=source.isTip;

target.channel_id=source.channel_id;

}

@end

