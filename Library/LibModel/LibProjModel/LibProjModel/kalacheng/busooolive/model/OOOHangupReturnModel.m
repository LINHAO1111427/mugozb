//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOHangupReturnModel.h"




 @implementation OOOHangupReturnModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"callUpUid"]=@(_callUpUid);

dict[@"payCoin"]=@(_payCoin);

dict[@"role"]=@(_role);

dict[@"hangupResion"]=@(_hangupResion);

dict[@"totalCoin"]=@(_totalCoin);

dict[@"avatar"]=_avatar;

dict[@"freeCallDuration"]=@(_freeCallDuration);

dict[@"isTalked"]=@(_isTalked);

dict[@"vipGradeMsg"]=_vipGradeMsg;

dict[@"callTime"]=@(_callTime);

dict[@"vipCount"]=@(_vipCount);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOHangupReturnModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOHangupReturnModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOHangupReturnModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOHangupReturnModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOHangupReturnModel* sumMdl=[OOOHangupReturnModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOHangupReturnModel*)getFromDict:(NSDictionary*)dict
{
OOOHangupReturnModel* model=[[OOOHangupReturnModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.callUpUid=[dict[@"callUpUid"] isKindOfClass:[NSNull class]]?0:[dict[@"callUpUid"] longLongValue];

model.payCoin=[dict[@"payCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"payCoin"] doubleValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.hangupResion=[dict[@"hangupResion"] isKindOfClass:[NSNull class]]?0:[dict[@"hangupResion"] intValue];

model.totalCoin=[dict[@"totalCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCoin"] doubleValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.freeCallDuration=[dict[@"freeCallDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"freeCallDuration"] intValue];

model.isTalked=[dict[@"isTalked"] isKindOfClass:[NSNull class]]?0:[dict[@"isTalked"] intValue];

model.vipGradeMsg=[dict[@"vipGradeMsg"] isKindOfClass:[NSNull class]]?@"":dict[@"vipGradeMsg"];

model.callTime=[dict[@"callTime"] isKindOfClass:[NSNull class]]?0:[dict[@"callTime"] longLongValue];

model.vipCount=[dict[@"vipCount"] isKindOfClass:[NSNull class]]?0:[dict[@"vipCount"] doubleValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(OOOHangupReturnModel*) source target:(OOOHangupReturnModel*)target
{

target.callUpUid=source.callUpUid;

target.payCoin=source.payCoin;

target.role=source.role;

target.hangupResion=source.hangupResion;

target.totalCoin=source.totalCoin;

target.avatar=source.avatar;

target.freeCallDuration=source.freeCallDuration;

target.isTalked=source.isTalked;

target.vipGradeMsg=source.vipGradeMsg;

target.callTime=source.callTime;

target.vipCount=source.vipCount;

target.username=source.username;

}

@end

