//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppVideoTopicModel.h"




 @implementation AppVideoTopicModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"image"]=_image;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"tagStyle"]=_tagStyle;

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"isTip"]=@(_isTip);

dict[@"isHot"]=@(_isHot);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppVideoTopicModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppVideoTopicModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppVideoTopicModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppVideoTopicModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppVideoTopicModel* sumMdl=[AppVideoTopicModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppVideoTopicModel*)getFromDict:(NSDictionary*)dict
{
AppVideoTopicModel* model=[[AppVideoTopicModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.image=[dict[@"image"] isKindOfClass:[NSNull class]]?@"":dict[@"image"];


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

model.isHot=[dict[@"isHot"] isKindOfClass:[NSNull class]]?0:[dict[@"isHot"] intValue];


 return model;
}

 +(void)cloneObj:(AppVideoTopicModel*) source target:(AppVideoTopicModel*)target
{

target.image=source.image;

target.addTime=source.addTime;

target.tagStyle=source.tagStyle;

target.name=source.name;

target.id_field=source.id_field;

target.sort=source.sort;

target.isTip=source.isTip;

target.isHot=source.isHot;

}

@end

