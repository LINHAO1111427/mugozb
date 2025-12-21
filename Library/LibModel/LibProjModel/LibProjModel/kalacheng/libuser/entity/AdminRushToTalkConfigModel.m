//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AdminRushToTalkConfigModel.h"




 @implementation AdminRushToTalkConfigModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"telephoneMoney"]=@(_telephoneMoney);

dict[@"id"]=@(_id_field);

dict[@"chatType"]=@(_chatType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AdminRushToTalkConfigModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AdminRushToTalkConfigModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AdminRushToTalkConfigModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AdminRushToTalkConfigModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminRushToTalkConfigModel* sumMdl=[AdminRushToTalkConfigModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AdminRushToTalkConfigModel*)getFromDict:(NSDictionary*)dict
{
AdminRushToTalkConfigModel* model=[[AdminRushToTalkConfigModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.telephoneMoney=[dict[@"telephoneMoney"] isKindOfClass:[NSNull class]]?0:[dict[@"telephoneMoney"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.chatType=[dict[@"chatType"] isKindOfClass:[NSNull class]]?0:[dict[@"chatType"] intValue];


 return model;
}

 +(void)cloneObj:(AdminRushToTalkConfigModel*) source target:(AdminRushToTalkConfigModel*)target
{

target.createTime=source.createTime;

target.telephoneMoney=source.telephoneMoney;

target.id_field=source.id_field;

target.chatType=source.chatType;

}

@end

