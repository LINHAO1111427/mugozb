//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveBeanModel.h"




 @implementation LiveBeanModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"game"]=_game;

dict[@"distance"]=_distance;

dict[@"city"]=_city;

dict[@"signature"]=_signature;

dict[@"thumb"]=_thumb;

dict[@"liveType"]=@(_liveType);

dict[@"gameAction"]=@(_gameAction);

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"roomId"]=@(_roomId);

dict[@"typeDec"]=_typeDec;

dict[@"uid"]=@(_uid);

dict[@"userLevel"]=_userLevel;

dict[@"stream"]=_stream;

dict[@"nickname"]=_nickname;

dict[@"nums"]=@(_nums);

dict[@"typeVal"]=_typeVal;

dict[@"islive"]=@(_islive);

dict[@"isPay"]=@(_isPay);

dict[@"sex"]=@(_sex);

dict[@"avatar"]=_avatar;

dict[@"anchorLevel"]=_anchorLevel;

dict[@"pull"]=_pull;

dict[@"age"]=@(_age);

dict[@"goodnum"]=_goodnum;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveBeanModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveBeanModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveBeanModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveBeanModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveBeanModel* sumMdl=[LiveBeanModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveBeanModel*)getFromDict:(NSDictionary*)dict
{
LiveBeanModel* model=[[LiveBeanModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.game=[dict[@"game"] isKindOfClass:[NSNull class]]?@"":dict[@"game"];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?@"":dict[@"distance"];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.gameAction=[dict[@"gameAction"] isKindOfClass:[NSNull class]]?0:[dict[@"gameAction"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.typeDec=[dict[@"typeDec"] isKindOfClass:[NSNull class]]?@"":dict[@"typeDec"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.userLevel=[dict[@"userLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"userLevel"];

model.stream=[dict[@"stream"] isKindOfClass:[NSNull class]]?@"":dict[@"stream"];

model.nickname=[dict[@"nickname"] isKindOfClass:[NSNull class]]?@"":dict[@"nickname"];

model.nums=[dict[@"nums"] isKindOfClass:[NSNull class]]?0:[dict[@"nums"] intValue];

model.typeVal=[dict[@"typeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"typeVal"];

model.islive=[dict[@"islive"] isKindOfClass:[NSNull class]]?0:[dict[@"islive"] intValue];

model.isPay=[dict[@"isPay"] isKindOfClass:[NSNull class]]?0:[dict[@"isPay"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorLevel=[dict[@"anchorLevel"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorLevel"];

model.pull=[dict[@"pull"] isKindOfClass:[NSNull class]]?@"":dict[@"pull"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];


 return model;
}

 +(void)cloneObj:(LiveBeanModel*) source target:(LiveBeanModel*)target
{

target.game=source.game;

target.distance=source.distance;

target.city=source.city;

target.signature=source.signature;

target.thumb=source.thumb;

target.liveType=source.liveType;

target.gameAction=source.gameAction;

target.title=source.title;

target.type=source.type;

target.roomId=source.roomId;

target.typeDec=source.typeDec;

target.uid=source.uid;

target.userLevel=source.userLevel;

target.stream=source.stream;

target.nickname=source.nickname;

target.nums=source.nums;

target.typeVal=source.typeVal;

target.islive=source.islive;

target.isPay=source.isPay;

target.sex=source.sex;

target.avatar=source.avatar;

target.anchorLevel=source.anchorLevel;

target.pull=source.pull;

target.age=source.age;

target.goodnum=source.goodnum;

}

@end

