//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppChatFamilyOptIntoVOModel.h"




 @implementation AppChatFamilyOptIntoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"familyRole"]=@(_familyRole);

dict[@"isSquareMute"]=@(_isSquareMute);

dict[@"toFamilyRole"]=@(_toFamilyRole);

dict[@"isSquareKickPeople"]=@(_isSquareKickPeople);

dict[@"muteStatus"]=@(_muteStatus);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyOptIntoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppChatFamilyOptIntoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppChatFamilyOptIntoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppChatFamilyOptIntoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppChatFamilyOptIntoVOModel* sumMdl=[AppChatFamilyOptIntoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppChatFamilyOptIntoVOModel*)getFromDict:(NSDictionary*)dict
{
AppChatFamilyOptIntoVOModel* model=[[AppChatFamilyOptIntoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.familyRole=[dict[@"familyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"familyRole"] intValue];

model.isSquareMute=[dict[@"isSquareMute"] isKindOfClass:[NSNull class]]?0:[dict[@"isSquareMute"] intValue];

model.toFamilyRole=[dict[@"toFamilyRole"] isKindOfClass:[NSNull class]]?0:[dict[@"toFamilyRole"] intValue];

model.isSquareKickPeople=[dict[@"isSquareKickPeople"] isKindOfClass:[NSNull class]]?0:[dict[@"isSquareKickPeople"] intValue];

model.muteStatus=[dict[@"muteStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"muteStatus"] intValue];


 return model;
}

 +(void)cloneObj:(AppChatFamilyOptIntoVOModel*) source target:(AppChatFamilyOptIntoVOModel*)target
{

target.familyRole=source.familyRole;

target.isSquareMute=source.isSquareMute;

target.toFamilyRole=source.toFamilyRole;

target.isSquareKickPeople=source.isSquareKickPeople;

target.muteStatus=source.muteStatus;

}

@end

