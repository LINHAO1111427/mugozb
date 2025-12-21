//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppMicSeatBorderVOModel.h"




 @implementation AppMicSeatBorderVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"orderno"]=@(_orderno);

dict[@"swf"]=_swf;

dict[@"thumb"]=_thumb;

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"name"]=_name;

dict[@"needcoin"]=@(_needcoin);

dict[@"id"]=@(_id_field);

dict[@"status"]=@(_status);

dict[@"uptime"]=[HttpClient stringFromDate:_uptime];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMicSeatBorderVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppMicSeatBorderVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppMicSeatBorderVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppMicSeatBorderVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMicSeatBorderVOModel* sumMdl=[AppMicSeatBorderVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppMicSeatBorderVOModel*)getFromDict:(NSDictionary*)dict
{
AppMicSeatBorderVOModel* model=[[AppMicSeatBorderVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.orderno=[dict[@"orderno"] isKindOfClass:[NSNull class]]?0:[dict[@"orderno"] intValue];

model.swf=[dict[@"swf"] isKindOfClass:[NSNull class]]?@"":dict[@"swf"];

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

model.needcoin=[dict[@"needcoin"] isKindOfClass:[NSNull class]]?0:[dict[@"needcoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


{
NSString *strDate= dict[@"uptime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.uptime=date;
    }
}


 return model;
}

 +(void)cloneObj:(AppMicSeatBorderVOModel*) source target:(AppMicSeatBorderVOModel*)target
{

target.orderno=source.orderno;

target.swf=source.swf;

target.thumb=source.thumb;

target.addtime=source.addtime;

target.name=source.name;

target.needcoin=source.needcoin;

target.id_field=source.id_field;

target.status=source.status;

target.uptime=source.uptime;

}

@end

