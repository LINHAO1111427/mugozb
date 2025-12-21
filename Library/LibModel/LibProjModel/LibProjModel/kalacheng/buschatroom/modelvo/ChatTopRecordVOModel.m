//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ChatTopRecordVOModel.h"




 @implementation ChatTopRecordVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"topType"]=@(_topType);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"topUserOrGorupId"]=@(_topUserOrGorupId);

dict[@"id"]=@(_id_field);

dict[@"topUgid"]=@(_topUgid);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ChatTopRecordVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ChatTopRecordVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ChatTopRecordVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ChatTopRecordVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ChatTopRecordVOModel* sumMdl=[ChatTopRecordVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ChatTopRecordVOModel*)getFromDict:(NSDictionary*)dict
{
ChatTopRecordVOModel* model=[[ChatTopRecordVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.topType=[dict[@"topType"] isKindOfClass:[NSNull class]]?0:[dict[@"topType"] intValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.topUserOrGorupId=[dict[@"topUserOrGorupId"] isKindOfClass:[NSNull class]]?0:[dict[@"topUserOrGorupId"] longLongValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.topUgid=[dict[@"topUgid"] isKindOfClass:[NSNull class]]?0:[dict[@"topUgid"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ChatTopRecordVOModel*) source target:(ChatTopRecordVOModel*)target
{

target.topType=source.topType;

target.createTime=source.createTime;

target.topUserOrGorupId=source.topUserOrGorupId;

target.id_field=source.id_field;

target.topUgid=source.topUgid;

target.userId=source.userId;

}

@end

