//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "PkGiftSenderModel.h"




 @implementation PkGiftSenderModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isVoicePk"]=@(_isVoicePk);

dict[@"avatar"]=_avatar;

dict[@"userId"]=@(_userId);

dict[@"coin"]=@(_coin);

dict[@"pkType"]=@(_pkType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PkGiftSenderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
PkGiftSenderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<PkGiftSenderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<PkGiftSenderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkGiftSenderModel* sumMdl=[PkGiftSenderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(PkGiftSenderModel*)getFromDict:(NSDictionary*)dict
{
PkGiftSenderModel* model=[[PkGiftSenderModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isVoicePk=[dict[@"isVoicePk"] isKindOfClass:[NSNull class]]?0:[dict[@"isVoicePk"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.pkType=[dict[@"pkType"] isKindOfClass:[NSNull class]]?0:[dict[@"pkType"] intValue];


 return model;
}

 +(void)cloneObj:(PkGiftSenderModel*) source target:(PkGiftSenderModel*)target
{

target.isVoicePk=source.isVoicePk;

target.avatar=source.avatar;

target.userId=source.userId;

target.coin=source.coin;

target.pkType=source.pkType;

}

@end

