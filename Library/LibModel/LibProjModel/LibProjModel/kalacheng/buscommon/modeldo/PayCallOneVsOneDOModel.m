//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "PayCallOneVsOneDOModel.h"




 @implementation PayCallOneVsOneDOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"voice"]=_voice;

dict[@"tabName"]=_tabName;

dict[@"openState"]=@(_openState);

dict[@"videoCoin"]=@(_videoCoin);

dict[@"videoImg"]=_videoImg;

dict[@"updateTime"]=[HttpClient stringFromDate:_updateTime];

dict[@"video"]=_video;

dict[@"userId"]=@(_userId);

dict[@"hotSortId"]=@(_hotSortId);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"voiceCoin"]=@(_voiceCoin);

dict[@"id"]=@(_id_field);

dict[@"poster"]=_poster;

dict[@"voiceTime"]=@(_voiceTime);

dict[@"remarks"]=_remarks;

dict[@"liveState"]=@(_liveState);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PayCallOneVsOneDOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
PayCallOneVsOneDOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<PayCallOneVsOneDOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<PayCallOneVsOneDOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PayCallOneVsOneDOModel* sumMdl=[PayCallOneVsOneDOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(PayCallOneVsOneDOModel*)getFromDict:(NSDictionary*)dict
{
PayCallOneVsOneDOModel* model=[[PayCallOneVsOneDOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.voice=[dict[@"voice"] isKindOfClass:[NSNull class]]?@"":dict[@"voice"];

model.tabName=[dict[@"tabName"] isKindOfClass:[NSNull class]]?@"":dict[@"tabName"];

model.openState=[dict[@"openState"] isKindOfClass:[NSNull class]]?0:[dict[@"openState"] intValue];

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.videoImg=[dict[@"videoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"videoImg"];


{
NSString *strDate= dict[@"updateTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.updateTime=date;
    }
}

model.video=[dict[@"video"] isKindOfClass:[NSNull class]]?@"":dict[@"video"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.hotSortId=[dict[@"hotSortId"] isKindOfClass:[NSNull class]]?0:[dict[@"hotSortId"] longLongValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.voiceTime=[dict[@"voiceTime"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceTime"] longLongValue];

model.remarks=[dict[@"remarks"] isKindOfClass:[NSNull class]]?@"":dict[@"remarks"];

model.liveState=[dict[@"liveState"] isKindOfClass:[NSNull class]]?0:[dict[@"liveState"] intValue];


 return model;
}

 +(void)cloneObj:(PayCallOneVsOneDOModel*) source target:(PayCallOneVsOneDOModel*)target
{

target.voice=source.voice;

target.tabName=source.tabName;

target.openState=source.openState;

target.videoCoin=source.videoCoin;

target.videoImg=source.videoImg;

target.updateTime=source.updateTime;

target.video=source.video;

target.userId=source.userId;

target.hotSortId=source.hotSortId;

target.createTime=source.createTime;

target.voiceCoin=source.voiceCoin;

target.id_field=source.id_field;

target.poster=source.poster;

target.voiceTime=source.voiceTime;

target.remarks=source.remarks;

target.liveState=source.liveState;

}

@end

