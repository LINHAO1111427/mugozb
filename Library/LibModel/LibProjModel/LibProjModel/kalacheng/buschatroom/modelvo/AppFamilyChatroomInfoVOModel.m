//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppFamilyChatroomInfoVOModel.h"
#import "AppChatFamilyMsgTopVOModel.h"




 @implementation AppFamilyChatroomInfoVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appChatFamilyMsgTopVO" : [AppChatFamilyMsgTopVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isSquareMute"]=@(_isSquareMute);

dict[@"contributionFirstAvatar"]=_contributionFirstAvatar;

dict[@"isShowProclamation"]=@(_isShowProclamation);

dict[@"patriarchNobleAvatarFrame"]=_patriarchNobleAvatarFrame;

dict[@"realTimeNumber"]=@(_realTimeNumber);

dict[@"sendTopMsgCoin"]=@(_sendTopMsgCoin);

dict[@"familyIcon"]=_familyIcon;

dict[@"patriarchAge"]=@(_patriarchAge);

dict[@"patriarchName"]=_patriarchName;

dict[@"familyId"]=@(_familyId);

dict[@"patriarchSex"]=@(_patriarchSex);

dict[@"patriarchGradeImg"]=_patriarchGradeImg;

dict[@"appChatFamilyMsgTopVO"]=[_appChatFamilyMsgTopVO modelToJSONObject];

dict[@"familyName"]=_familyName;

dict[@"familyNumber"]=@(_familyNumber);

dict[@"patriarchAvatar"]=_patriarchAvatar;

dict[@"patriarchId"]=@(_patriarchId);

dict[@"familyGrade"]=@(_familyGrade);

dict[@"familyFrom"]=@(_familyFrom);

dict[@"familyProclamation"]=_familyProclamation;

dict[@"sendTopMsgScore"]=@(_sendTopMsgScore);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppFamilyChatroomInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppFamilyChatroomInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppFamilyChatroomInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppFamilyChatroomInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppFamilyChatroomInfoVOModel* sumMdl=[AppFamilyChatroomInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppFamilyChatroomInfoVOModel*)getFromDict:(NSDictionary*)dict
{
AppFamilyChatroomInfoVOModel* model=[[AppFamilyChatroomInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isSquareMute=[dict[@"isSquareMute"] isKindOfClass:[NSNull class]]?0:[dict[@"isSquareMute"] intValue];

model.contributionFirstAvatar=[dict[@"contributionFirstAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"contributionFirstAvatar"];

model.isShowProclamation=[dict[@"isShowProclamation"] isKindOfClass:[NSNull class]]?0:[dict[@"isShowProclamation"] intValue];

model.patriarchNobleAvatarFrame=[dict[@"patriarchNobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"patriarchNobleAvatarFrame"];

model.realTimeNumber=[dict[@"realTimeNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"realTimeNumber"] longLongValue];

model.sendTopMsgCoin=[dict[@"sendTopMsgCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"sendTopMsgCoin"] doubleValue];

model.familyIcon=[dict[@"familyIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"familyIcon"];

model.patriarchAge=[dict[@"patriarchAge"] isKindOfClass:[NSNull class]]?0:[dict[@"patriarchAge"] intValue];

model.patriarchName=[dict[@"patriarchName"] isKindOfClass:[NSNull class]]?@"":dict[@"patriarchName"];

model.familyId=[dict[@"familyId"] isKindOfClass:[NSNull class]]?0:[dict[@"familyId"] longLongValue];

model.patriarchSex=[dict[@"patriarchSex"] isKindOfClass:[NSNull class]]?0:[dict[@"patriarchSex"] intValue];

model.patriarchGradeImg=[dict[@"patriarchGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"patriarchGradeImg"];


//getFromDict对象转换  
model.appChatFamilyMsgTopVO=[AppChatFamilyMsgTopVOModel getFromDict:dict[@"appChatFamilyMsgTopVO"]];

model.familyName=[dict[@"familyName"] isKindOfClass:[NSNull class]]?@"":dict[@"familyName"];

model.familyNumber=[dict[@"familyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"familyNumber"] intValue];

model.patriarchAvatar=[dict[@"patriarchAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"patriarchAvatar"];

model.patriarchId=[dict[@"patriarchId"] isKindOfClass:[NSNull class]]?0:[dict[@"patriarchId"] longLongValue];

model.familyGrade=[dict[@"familyGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"familyGrade"] intValue];

model.familyFrom=[dict[@"familyFrom"] isKindOfClass:[NSNull class]]?0:[dict[@"familyFrom"] intValue];

model.familyProclamation=[dict[@"familyProclamation"] isKindOfClass:[NSNull class]]?@"":dict[@"familyProclamation"];

model.sendTopMsgScore=[dict[@"sendTopMsgScore"] isKindOfClass:[NSNull class]]?0:[dict[@"sendTopMsgScore"] doubleValue];


 return model;
}

 +(void)cloneObj:(AppFamilyChatroomInfoVOModel*) source target:(AppFamilyChatroomInfoVOModel*)target
{

target.isSquareMute=source.isSquareMute;

target.contributionFirstAvatar=source.contributionFirstAvatar;

target.isShowProclamation=source.isShowProclamation;

target.patriarchNobleAvatarFrame=source.patriarchNobleAvatarFrame;

target.realTimeNumber=source.realTimeNumber;

target.sendTopMsgCoin=source.sendTopMsgCoin;

target.familyIcon=source.familyIcon;

target.patriarchAge=source.patriarchAge;

target.patriarchName=source.patriarchName;

target.familyId=source.familyId;

target.patriarchSex=source.patriarchSex;

target.patriarchGradeImg=source.patriarchGradeImg;
        if(source.appChatFamilyMsgTopVO==nil)
        {
//            target.appChatFamilyMsgTopVO=nil;
        }else
        {
            [AppChatFamilyMsgTopVOModel cloneObj:source.appChatFamilyMsgTopVO target:target.appChatFamilyMsgTopVO];
        }

target.familyName=source.familyName;

target.familyNumber=source.familyNumber;

target.patriarchAvatar=source.patriarchAvatar;

target.patriarchId=source.patriarchId;

target.familyGrade=source.familyGrade;

target.familyFrom=source.familyFrom;

target.familyProclamation=source.familyProclamation;

target.sendTopMsgScore=source.sendTopMsgScore;

}

@end

