//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppPromiseOrderInfoVOModel.h"




 @implementation AppPromiseOrderInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"promiseStartTime"]=[HttpClient stringFromDate:_promiseStartTime];

dict[@"distance"]=@(_distance);

dict[@"isUserAppeal"]=@(_isUserAppeal);

dict[@"totalPrice"]=@(_totalPrice);

dict[@"latitude"]=@(_latitude);

dict[@"userAvatar"]=_userAvatar;

dict[@"orderStatus"]=@(_orderStatus);

dict[@"anchorId"]=@(_anchorId);

dict[@"orderRole"]=@(_orderRole);

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"isAnchorLeave"]=@(_isAnchorLeave);

dict[@"promiseCity"]=_promiseCity;

dict[@"promiseOrderId"]=@(_promiseOrderId);

dict[@"promiseDuration"]=@(_promiseDuration);

dict[@"skillName"]=_skillName;

dict[@"promiseStore"]=_promiseStore;

dict[@"isConfirm"]=@(_isConfirm);

dict[@"promiseAddress"]=_promiseAddress;

dict[@"processShowText"]=_processShowText;

dict[@"isEvaluate"]=@(_isEvaluate);

dict[@"longitude"]=@(_longitude);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppPromiseOrderInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppPromiseOrderInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppPromiseOrderInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppPromiseOrderInfoVOModel* sumMdl=[AppPromiseOrderInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppPromiseOrderInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AppPromiseOrderInfoVOModel* model=[[AppPromiseOrderInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"promiseStartTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.promiseStartTime=date;
    }
}

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.isUserAppeal=[dict[@"isUserAppeal"] isKindOfClass:[NSNull class]]?0:[dict[@"isUserAppeal"] intValue];

model.totalPrice=[dict[@"totalPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"totalPrice"] doubleValue];

model.latitude=[dict[@"latitude"] isKindOfClass:[NSNull class]]?0:[dict[@"latitude"] doubleValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.orderStatus=[dict[@"orderStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"orderStatus"] intValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.orderRole=[dict[@"orderRole"] isKindOfClass:[NSNull class]]?0:[dict[@"orderRole"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.isAnchorLeave=[dict[@"isAnchorLeave"] isKindOfClass:[NSNull class]]?0:[dict[@"isAnchorLeave"] intValue];

model.promiseCity=[dict[@"promiseCity"] isKindOfClass:[NSNull class]]?@"":dict[@"promiseCity"];

model.promiseOrderId=[dict[@"promiseOrderId"] isKindOfClass:[NSNull class]]?0:[dict[@"promiseOrderId"] longLongValue];

model.promiseDuration=[dict[@"promiseDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"promiseDuration"] intValue];

model.skillName=[dict[@"skillName"] isKindOfClass:[NSNull class]]?@"":dict[@"skillName"];

model.promiseStore=[dict[@"promiseStore"] isKindOfClass:[NSNull class]]?@"":dict[@"promiseStore"];

model.isConfirm=[dict[@"isConfirm"] isKindOfClass:[NSNull class]]?0:[dict[@"isConfirm"] intValue];

model.promiseAddress=[dict[@"promiseAddress"] isKindOfClass:[NSNull class]]?@"":dict[@"promiseAddress"];

model.processShowText=[dict[@"processShowText"] isKindOfClass:[NSNull class]]?@"":dict[@"processShowText"];

model.isEvaluate=[dict[@"isEvaluate"] isKindOfClass:[NSNull class]]?0:[dict[@"isEvaluate"] intValue];

model.longitude=[dict[@"longitude"] isKindOfClass:[NSNull class]]?0:[dict[@"longitude"] doubleValue];


 return model;
}

 +(void)cloneObj:(AppPromiseOrderInfoVOModel*) source target:(AppPromiseOrderInfoVOModel*)target
{

target.promiseStartTime=source.promiseStartTime;

target.distance=source.distance;

target.isUserAppeal=source.isUserAppeal;

target.totalPrice=source.totalPrice;

target.latitude=source.latitude;

target.userAvatar=source.userAvatar;

target.orderStatus=source.orderStatus;

target.anchorId=source.anchorId;

target.orderRole=source.orderRole;

target.userName=source.userName;

target.userId=source.userId;

target.isAnchorLeave=source.isAnchorLeave;

target.promiseCity=source.promiseCity;

target.promiseOrderId=source.promiseOrderId;

target.promiseDuration=source.promiseDuration;

target.skillName=source.skillName;

target.promiseStore=source.promiseStore;

target.isConfirm=source.isConfirm;

target.promiseAddress=source.promiseAddress;

target.processShowText=source.processShowText;

target.isEvaluate=source.isEvaluate;

target.longitude=source.longitude;

}

@end

