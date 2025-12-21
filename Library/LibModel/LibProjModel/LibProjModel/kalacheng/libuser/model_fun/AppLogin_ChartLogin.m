//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "AppLogin_ChartLogin.h"




  @implementation AppLogin_ChartLogin  


 +(NSMutableArray<AppLogin_ChartLogin*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLogin_ChartLogin*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLogin_ChartLogin* sumMdl=[AppLogin_ChartLogin getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLogin_ChartLogin*)getFromDict:(NSDictionary*)dict
{
AppLogin_ChartLogin* model=[[AppLogin_ChartLogin alloc]init];

model.appVersion=[dict[@"appVersion"] isKindOfClass:[NSNull class]]?@"":dict[@"appVersion"];

model.appVersionCode=[dict[@"appVersionCode"] isKindOfClass:[NSNull class]]?@"":dict[@"appVersionCode"];

model.nickname=[dict[@"nickname"] isKindOfClass:[NSNull class]]?@"":dict[@"nickname"];

model.openid=[dict[@"openid"] isKindOfClass:[NSNull class]]?@"":dict[@"openid"];

model.phoneFirm=[dict[@"phoneFirm"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneFirm"];

model.phoneModel=[dict[@"phoneModel"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneModel"];

model.phoneUuid=[dict[@"phoneUuid"] isKindOfClass:[NSNull class]]?@"":dict[@"phoneUuid"];

model.pic=[dict[@"pic"] isKindOfClass:[NSNull class]]?@"":dict[@"pic"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

@end

