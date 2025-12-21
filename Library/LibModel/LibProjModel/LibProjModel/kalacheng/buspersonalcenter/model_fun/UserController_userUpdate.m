//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import "UserController_userUpdate.h"




  @implementation UserController_userUpdate  


 +(NSMutableArray<UserController_userUpdate*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserController_userUpdate*>* mdlArr=[[NSMutableArray alloc] init];
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserController_userUpdate* sumMdl=[UserController_userUpdate getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserController_userUpdate*)getFromDict:(NSDictionary*)dict
{
UserController_userUpdate* model=[[UserController_userUpdate alloc]init];

model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.constellation=[dict[@"constellation"] isKindOfClass:[NSNull class]]?@"":dict[@"constellation"];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.sanwei=[dict[@"sanwei"] isKindOfClass:[NSNull class]]?@"":dict[@"sanwei"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];

model.vocation=[dict[@"vocation"] isKindOfClass:[NSNull class]]?@"":dict[@"vocation"];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.weight=[dict[@"weight"] isKindOfClass:[NSNull class]]?0:[dict[@"weight"] intValue];


 return model;
}

@end

