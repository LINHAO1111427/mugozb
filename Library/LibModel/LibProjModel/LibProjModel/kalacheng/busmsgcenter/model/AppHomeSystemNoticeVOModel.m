//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppHomeSystemNoticeVOModel.h"




 @implementation AppHomeSystemNoticeVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addtimeStr"]=_addtimeStr;

dict[@"noReadNumber"]=@(_noReadNumber);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"showTitle"]=_showTitle;

dict[@"firstMsg"]=_firstMsg;

dict[@"logo"]=_logo;

dict[@"noticeType"]=@(_noticeType);

dict[@"title"]=_title;

dict[@"noticeId"]=@(_noticeId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeSystemNoticeVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppHomeSystemNoticeVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppHomeSystemNoticeVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppHomeSystemNoticeVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeSystemNoticeVOModel* sumMdl=[AppHomeSystemNoticeVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppHomeSystemNoticeVOModel*)getFromDict:(NSDictionary*)dict
{
AppHomeSystemNoticeVOModel* model=[[AppHomeSystemNoticeVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.addtimeStr=[dict[@"addtimeStr"] isKindOfClass:[NSNull class]]?@"":dict[@"addtimeStr"];

model.noReadNumber=[dict[@"noReadNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"noReadNumber"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.showTitle=[dict[@"showTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"showTitle"];

model.firstMsg=[dict[@"firstMsg"] isKindOfClass:[NSNull class]]?@"":dict[@"firstMsg"];

model.logo=[dict[@"logo"] isKindOfClass:[NSNull class]]?@"":dict[@"logo"];

model.noticeType=[dict[@"noticeType"] isKindOfClass:[NSNull class]]?0:[dict[@"noticeType"] longLongValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.noticeId=[dict[@"noticeId"] isKindOfClass:[NSNull class]]?0:[dict[@"noticeId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppHomeSystemNoticeVOModel*) source target:(AppHomeSystemNoticeVOModel*)target
{

target.addtimeStr=source.addtimeStr;

target.noReadNumber=source.noReadNumber;

target.addtime=source.addtime;

target.showTitle=source.showTitle;

target.firstMsg=source.firstMsg;

target.logo=source.logo;

target.noticeType=source.noticeType;

target.title=source.title;

target.noticeId=source.noticeId;

}

@end

