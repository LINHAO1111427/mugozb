//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GameUserWinAwardsDTOModel.h"




 @implementation GameUserWinAwardsDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"userId"]=@(_userId);

dict[@"userName"]=_userName;

dict[@"gameName"]=_gameName;

dict[@"awardsName"]=_awardsName;

dict[@"awardsNum"]=@(_awardsNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GameUserWinAwardsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GameUserWinAwardsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GameUserWinAwardsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GameUserWinAwardsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GameUserWinAwardsDTOModel* sumMdl=[GameUserWinAwardsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GameUserWinAwardsDTOModel*)getFromDict:(NSDictionary*)dict
{
GameUserWinAwardsDTOModel* model=[[GameUserWinAwardsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.gameName=[dict[@"gameName"] isKindOfClass:[NSNull class]]?@"":dict[@"gameName"];

model.awardsName=[dict[@"awardsName"] isKindOfClass:[NSNull class]]?@"":dict[@"awardsName"];

model.awardsNum=[dict[@"awardsNum"] isKindOfClass:[NSNull class]]?0:[dict[@"awardsNum"] intValue];


 return model;
}

 +(void)cloneObj:(GameUserWinAwardsDTOModel*) source target:(GameUserWinAwardsDTOModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.userId=source.userId;

target.userName=source.userName;

target.gameName=source.gameName;

target.awardsName=source.awardsName;

target.awardsNum=source.awardsNum;

}

@end

