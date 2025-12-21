//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUserPromiseOrderEvaluateVOModel.h"




 @implementation AppUserPromiseOrderEvaluateVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"orderScore"]=@(_orderScore);

dict[@"orderComment"]=_orderComment;

dict[@"userAvatar"]=_userAvatar;

dict[@"id"]=@(_id_field);

dict[@"userName"]=_userName;

dict[@"toUserId"]=@(_toUserId);

dict[@"userId"]=@(_userId);

dict[@"promiseOrderId"]=@(_promiseOrderId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUserPromiseOrderEvaluateVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUserPromiseOrderEvaluateVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserPromiseOrderEvaluateVOModel* sumMdl=[AppUserPromiseOrderEvaluateVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUserPromiseOrderEvaluateVOModel*)getFromDict:(NSDictionary*)dict
{
AppUserPromiseOrderEvaluateVOModel* model=[[AppUserPromiseOrderEvaluateVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.orderScore=[dict[@"orderScore"] isKindOfClass:[NSNull class]]?0:[dict[@"orderScore"] doubleValue];

model.orderComment=[dict[@"orderComment"] isKindOfClass:[NSNull class]]?@"":dict[@"orderComment"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.toUserId=[dict[@"toUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"toUserId"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.promiseOrderId=[dict[@"promiseOrderId"] isKindOfClass:[NSNull class]]?0:[dict[@"promiseOrderId"] longLongValue];


 return model;
}

 +(void)cloneObj:(AppUserPromiseOrderEvaluateVOModel*) source target:(AppUserPromiseOrderEvaluateVOModel*)target
{

target.orderScore=source.orderScore;

target.orderComment=source.orderComment;

target.userAvatar=source.userAvatar;

target.id_field=source.id_field;

target.userName=source.userName;

target.toUserId=source.toUserId;

target.userId=source.userId;

target.promiseOrderId=source.promiseOrderId;

}

@end

