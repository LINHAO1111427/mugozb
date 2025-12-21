//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGiftSenderModel.h"
#import "ApiUserBasicInfoModel.h"




 @implementation ApiGiftSenderModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userList" : [ApiUserBasicInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifticon"]=_gifticon;

dict[@"msg"]=_msg;

dict[@"code"]=@(_code);

dict[@"giftName"]=_giftName;

dict[@"userAvatar"]=_userAvatar;

dict[@"backpackCoinSum"]=@(_backpackCoinSum);

dict[@"type"]=@(_type);

dict[@"anchorName"]=_anchorName;

dict[@"roomId"]=@(_roomId);

dict[@"continuousNumber"]=@(_continuousNumber);

dict[@"giftId"]=@(_giftId);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserBasicInfoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userList"]=list;
}//end

dict[@"swftime"]=@(_swftime);

dict[@"anchorAvatar"]=_anchorAvatar;

dict[@"userCoin"]=@(_userCoin);

dict[@"anchorId"]=@(_anchorId);

dict[@"userName"]=_userName;

dict[@"userId"]=@(_userId);

dict[@"winCoin"]=@(_winCoin);

dict[@"giftswf"]=_giftswf;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"sendGiftPrivilege"]=@(_sendGiftPrivilege);

dict[@"userOverScore"]=@(_userOverScore);

dict[@"votes"]=@(_votes);

dict[@"sendGiftType"]=@(_sendGiftType);

dict[@"giftNumber"]=@(_giftNumber);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGiftSenderModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGiftSenderModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGiftSenderModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGiftSenderModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGiftSenderModel* sumMdl=[ApiGiftSenderModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGiftSenderModel*)getFromDict:(NSDictionary*)dict
{
ApiGiftSenderModel* model=[[ApiGiftSenderModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifticon=[dict[@"gifticon"] isKindOfClass:[NSNull class]]?@"":dict[@"gifticon"];

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.giftName=[dict[@"giftName"] isKindOfClass:[NSNull class]]?@"":dict[@"giftName"];

model.userAvatar=[dict[@"userAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"userAvatar"];

model.backpackCoinSum=[dict[@"backpackCoinSum"] isKindOfClass:[NSNull class]]?0:[dict[@"backpackCoinSum"] doubleValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.continuousNumber=[dict[@"continuousNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"continuousNumber"] intValue];

model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.userList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserBasicInfoModel* sumMdl=[ApiUserBasicInfoModel getFromDict:subDic];
[model.userList addObject:sumMdl];

}
}

}

model.swftime=[dict[@"swftime"] isKindOfClass:[NSNull class]]?0:[dict[@"swftime"] floatValue];

model.anchorAvatar=[dict[@"anchorAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAvatar"];

model.userCoin=[dict[@"userCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"userCoin"] doubleValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.winCoin=[dict[@"winCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"winCoin"] doubleValue];

model.giftswf=[dict[@"giftswf"] isKindOfClass:[NSNull class]]?@"":dict[@"giftswf"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.sendGiftPrivilege=[dict[@"sendGiftPrivilege"] isKindOfClass:[NSNull class]]?0:[dict[@"sendGiftPrivilege"] intValue];

model.userOverScore=[dict[@"userOverScore"] isKindOfClass:[NSNull class]]?0:[dict[@"userOverScore"] doubleValue];

model.votes=[dict[@"votes"] isKindOfClass:[NSNull class]]?0:[dict[@"votes"] doubleValue];

model.sendGiftType=[dict[@"sendGiftType"] isKindOfClass:[NSNull class]]?0:[dict[@"sendGiftType"] intValue];

model.giftNumber=[dict[@"giftNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"giftNumber"] intValue];


 return model;
}

 +(void)cloneObj:(ApiGiftSenderModel*) source target:(ApiGiftSenderModel*)target
{

target.gifticon=source.gifticon;

target.msg=source.msg;

target.code=source.code;

target.giftName=source.giftName;

target.userAvatar=source.userAvatar;

target.backpackCoinSum=source.backpackCoinSum;

target.type=source.type;

target.anchorName=source.anchorName;

target.roomId=source.roomId;

target.continuousNumber=source.continuousNumber;

target.giftId=source.giftId;

        if(source.userList==nil)
        {
//            target.userList=nil;
        }else
        {
            target.userList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userList.count;i++)
            {
		  [target.userList addObject:[[ApiUserBasicInfoModel alloc]init]];
            [ApiUserBasicInfoModel cloneObj:source.userList[i] target:target.userList[i]];
            }
        }


target.swftime=source.swftime;

target.anchorAvatar=source.anchorAvatar;

target.userCoin=source.userCoin;

target.anchorId=source.anchorId;

target.userName=source.userName;

target.userId=source.userId;

target.winCoin=source.winCoin;

target.giftswf=source.giftswf;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.sendGiftPrivilege=source.sendGiftPrivilege;

target.userOverScore=source.userOverScore;

target.votes=source.votes;

target.sendGiftType=source.sendGiftType;

target.giftNumber=source.giftNumber;

}

@end

