//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppShowPromiseOrderVOModel.h"




 @implementation AppShowPromiseOrderVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"promiseDuration"]=@(_promiseDuration);

dict[@"skillName"]=_skillName;

dict[@"isConfirm"]=@(_isConfirm);

dict[@"isUserAppeal"]=@(_isUserAppeal);

dict[@"totalPrice"]=@(_totalPrice);

dict[@"userAvatar"]=_userAvatar;

dict[@"orderStatus"]=@(_orderStatus);

dict[@"orderRole"]=@(_orderRole);

dict[@"userName"]=_userName;

dict[@"isEvaluate"]=@(_isEvaluate);

dict[@"promiseOrderId"]=@(_promiseOrderId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowPromiseOrderVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppShowPromiseOrderVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppShowPromiseOrderVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppShowPromiseOrderVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppShowPromiseOrderVOModel* sumMdl=[AppShowPromiseOrderVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppShowPromiseOrderVOModel*)getFromDict:(NSDictionary*)dict
{
AppShowPromiseOrderVOModel* model=[[AppShowPromiseOrderVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.promiseDuration=[dict[@"promiseDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"promiseDuration"] intValue];

model.skillName=[dict[@"skillName"] isKindOfClass:[NSNull class]]?@"":dict[@"skillName"];

model.isConfirm=[dict[@"isConfirm"] isKindOfClass:[NSNull class]]?0:[dict[@"isConfirm"] intValue];

model.isUserAppeal=[dict[@"isUserAppeal"] isKindOfClass:[NSNull class]]?0:[dict[@"isUserAppeal"] intValue];

model.totalPrice=[dict[@"totalPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"totalPrice"] doubleValue];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.orderStatus=[dict[@"orderStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"orderStatus"] intValue];

model.orderRole=[dict[@"orderRole"] isKindOfClass:[NSNull class]]?0:[dict[@"orderRole"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.isEvaluate=[dict[@"isEvaluate"] isKindOfClass:[NSNull class]]?0:[dict[@"isEvaluate"] intValue];

model.promiseOrderId=[dict[@"promiseOrderId"] isKindOfClass:[NSNull class]]?0:[dict[@"promiseOrderId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppShowPromiseOrderVOModel*) source target:(AppShowPromiseOrderVOModel*)target
{

target.promiseDuration=source.promiseDuration;

target.skillName=source.skillName;

target.isConfirm=source.isConfirm;

target.isUserAppeal=source.isUserAppeal;

target.totalPrice=source.totalPrice;

target.userAvatar=source.userAvatar;

target.orderStatus=source.orderStatus;

target.orderRole=source.orderRole;

target.userName=source.userName;

target.isEvaluate=source.isEvaluate;

target.promiseOrderId=source.promiseOrderId;

}

@end

