//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUsersMicSeatBorderVOModel.h"




 @implementation AppUsersMicSeatBorderVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"thumb"]=_thumb;

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"name"]=_name;

dict[@"endtime"]=[HttpClient stringFromDate:_endtime];

dict[@"seatid"]=@(_seatid);

dict[@"id"]=@(_id_field);

dict[@"userid"]=@(_userid);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersMicSeatBorderVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUsersMicSeatBorderVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUsersMicSeatBorderVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUsersMicSeatBorderVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersMicSeatBorderVOModel* sumMdl=[AppUsersMicSeatBorderVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUsersMicSeatBorderVOModel*)getFromDict:(NSDictionary*)dict
{
AppUsersMicSeatBorderVOModel* model=[[AppUsersMicSeatBorderVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
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


{
NSString *strDate= dict[@"endtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.endtime=date;
    }
}

model.seatid=[dict[@"seatid"] isKindOfClass:[NSNull class]]?0:[dict[@"seatid"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppUsersMicSeatBorderVOModel*) source target:(AppUsersMicSeatBorderVOModel*)target
{

target.thumb=source.thumb;

target.addtime=source.addtime;

target.name=source.name;

target.endtime=source.endtime;

target.seatid=source.seatid;

target.id_field=source.id_field;

target.userid=source.userid;

target.status=source.status;

}

@end

