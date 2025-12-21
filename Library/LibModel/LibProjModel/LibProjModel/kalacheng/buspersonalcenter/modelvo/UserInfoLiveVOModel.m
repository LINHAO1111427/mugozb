//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInfoLiveVOModel.h"
#import "ApiUserInfoModel.h"
#import "GiftWallDtoModel.h"




 @implementation UserInfoLiveVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userInfo" : [ApiUserInfoModel class],@"giftWall" : [GiftWallDtoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userInfo"]=[_userInfo modelToJSONObject];

dict[@"isAttentionUser"]=@(_isAttentionUser);

dict[@"fansNum"]=@(_fansNum);

dict[@"followNum"]=@(_followNum);

dict[@"isShutUp"]=@(_isShutUp);

dict[@"totalIncomeVotesStr"]=_totalIncomeVotesStr;

dict[@"toRelation"]=@(_toRelation);

dict[@"isPullBlack"]=@(_isPullBlack);

dict[@"totalConsumeCoinStr"]=_totalConsumeCoinStr;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_giftWall;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
GiftWallDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"giftWall"]=list;
}//end

dict[@"inAssistant"]=@(_inAssistant);

dict[@"relation"]=@(_relation);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoLiveVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInfoLiveVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInfoLiveVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInfoLiveVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInfoLiveVOModel* sumMdl=[UserInfoLiveVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInfoLiveVOModel*)getFromDict:(NSDictionary*)dict
{
UserInfoLiveVOModel* model=[[UserInfoLiveVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.userInfo=[ApiUserInfoModel getFromDict:dict[@"userInfo"]];

model.isAttentionUser=[dict[@"isAttentionUser"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttentionUser"] intValue];

model.fansNum=[dict[@"fansNum"] isKindOfClass:[NSNull class]]?0:[dict[@"fansNum"] intValue];

model.followNum=[dict[@"followNum"] isKindOfClass:[NSNull class]]?0:[dict[@"followNum"] intValue];

model.isShutUp=[dict[@"isShutUp"] isKindOfClass:[NSNull class]]?0:[dict[@"isShutUp"] intValue];

model.totalIncomeVotesStr=[dict[@"totalIncomeVotesStr"] isKindOfClass:[NSNull class]]?@"":dict[@"totalIncomeVotesStr"];

model.toRelation=[dict[@"toRelation"] isKindOfClass:[NSNull class]]?0:[dict[@"toRelation"] intValue];

model.isPullBlack=[dict[@"isPullBlack"] isKindOfClass:[NSNull class]]?0:[dict[@"isPullBlack"] intValue];

model.totalConsumeCoinStr=[dict[@"totalConsumeCoinStr"] isKindOfClass:[NSNull class]]?@"":dict[@"totalConsumeCoinStr"];

model.giftWall=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"giftWall"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftWallDtoModel* sumMdl=[GiftWallDtoModel getFromDict:subDic];
[model.giftWall addObject:sumMdl];

}
}

}

model.inAssistant=[dict[@"inAssistant"] isKindOfClass:[NSNull class]]?0:[dict[@"inAssistant"] intValue];

model.relation=[dict[@"relation"] isKindOfClass:[NSNull class]]?0:[dict[@"relation"] intValue];


 return model;
}

 +(void)cloneObj:(UserInfoLiveVOModel*) source target:(UserInfoLiveVOModel*)target
{
        if(source.userInfo==nil)
        {
//            target.userInfo=nil;
        }else
        {
            [ApiUserInfoModel cloneObj:source.userInfo target:target.userInfo];
        }

target.isAttentionUser=source.isAttentionUser;

target.fansNum=source.fansNum;

target.followNum=source.followNum;

target.isShutUp=source.isShutUp;

target.totalIncomeVotesStr=source.totalIncomeVotesStr;

target.toRelation=source.toRelation;

target.isPullBlack=source.isPullBlack;

target.totalConsumeCoinStr=source.totalConsumeCoinStr;

        if(source.giftWall==nil)
        {
//            target.giftWall=nil;
        }else
        {
            target.giftWall=[[NSMutableArray alloc] init];
            for(int i=0;i<source.giftWall.count;i++)
            {
		  [target.giftWall addObject:[[GiftWallDtoModel alloc]init]];
            [GiftWallDtoModel cloneObj:source.giftWall[i] target:target.giftWall[i]];
            }
        }


target.inAssistant=source.inAssistant;

target.relation=source.relation;

}

@end

