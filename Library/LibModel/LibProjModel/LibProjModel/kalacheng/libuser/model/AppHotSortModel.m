//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHotSortModel.h"




 @implementation AppHotSortModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"image"]=_image;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"sort"]=@(_sort);

dict[@"isTip"]=@(_isTip);

dict[@"params"]=_params;

dict[@"type"]=@(_type);

dict[@"isChecked"]=@(_isChecked);

dict[@"isShow"]=@(_isShow);

dict[@"number"]=@(_number);

dict[@"path"]=_path;

dict[@"name"]=_name;

dict[@"showType"]=@(_showType);

dict[@"id"]=@(_id_field);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHotSortModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHotSortModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHotSortModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHotSortModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHotSortModel* sumMdl=[AppHotSortModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHotSortModel*)getFromDict:(NSDictionary*)dict
{
AppHotSortModel* model=[[AppHotSortModel alloc]init];

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

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.isTip=[dict[@"isTip"] isKindOfClass:[NSNull class]]?0:[dict[@"isTip"] intValue];

model.params=[dict[@"params"] isKindOfClass:[NSNull class]]?@"":dict[@"params"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.isChecked=[dict[@"isChecked"] isKindOfClass:[NSNull class]]?0:[dict[@"isChecked"] intValue];

model.isShow=[dict[@"isShow"] isKindOfClass:[NSNull class]]?0:[dict[@"isShow"] intValue];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.path=[dict[@"path"] isKindOfClass:[NSNull class]]?@"":dict[@"path"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.showType=[dict[@"showType"] isKindOfClass:[NSNull class]]?0:[dict[@"showType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppHotSortModel*) source target:(AppHotSortModel*)target
{

target.image=source.image;

target.addTime=source.addTime;

target.sort=source.sort;

target.isTip=source.isTip;

target.params=source.params;

target.type=source.type;

target.isChecked=source.isChecked;

target.isShow=source.isShow;

target.number=source.number;

target.path=source.path;

target.name=source.name;

target.showType=source.showType;

target.id_field=source.id_field;

}

@end

