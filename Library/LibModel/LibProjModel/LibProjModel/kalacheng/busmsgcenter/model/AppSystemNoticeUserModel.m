//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppSystemNoticeUserModel.h"




 @implementation AppSystemNoticeUserModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"noticeType"]=@(_noticeType);

dict[@"id"]=@(_id_field);

dict[@"title"]=_title;

dict[@"userId"]=@(_userId);

dict[@"content"]=_content;

dict[@"noticeId"]=@(_noticeId);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSystemNoticeUserModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppSystemNoticeUserModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppSystemNoticeUserModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppSystemNoticeUserModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSystemNoticeUserModel* sumMdl=[AppSystemNoticeUserModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppSystemNoticeUserModel*)getFromDict:(NSDictionary*)dict
{
AppSystemNoticeUserModel* model=[[AppSystemNoticeUserModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.noticeType=[dict[@"noticeType"] isKindOfClass:[NSNull class]]?0:[dict[@"noticeType"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.noticeId=[dict[@"noticeId"] isKindOfClass:[NSNull class]]?0:[dict[@"noticeId"] longLongValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppSystemNoticeUserModel*) source target:(AppSystemNoticeUserModel*)target
{

target.addtime=source.addtime;

target.noticeType=source.noticeType;

target.id_field=source.id_field;

target.title=source.title;

target.userId=source.userId;

target.content=source.content;

target.noticeId=source.noticeId;

target.status=source.status;

}

@end

