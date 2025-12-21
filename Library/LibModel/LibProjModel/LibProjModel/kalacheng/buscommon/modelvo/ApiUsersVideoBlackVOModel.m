//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUsersVideoBlackVOModel.h"




 @implementation ApiUsersVideoBlackVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"videoBlack"]=@(_videoBlack);

dict[@"toUId"]=@(_toUId);

dict[@"userBlack"]=@(_userBlack);

dict[@"voiceBlack"]=@(_voiceBlack);

dict[@"textBlack"]=@(_textBlack);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUsersVideoBlackVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUsersVideoBlackVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUsersVideoBlackVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUsersVideoBlackVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersVideoBlackVOModel* sumMdl=[ApiUsersVideoBlackVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUsersVideoBlackVOModel*)getFromDict:(NSDictionary*)dict
{
ApiUsersVideoBlackVOModel* model=[[ApiUsersVideoBlackVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.videoBlack=[dict[@"videoBlack"] isKindOfClass:[NSNull class]]?0:[dict[@"videoBlack"] intValue];

model.toUId=[dict[@"toUId"] isKindOfClass:[NSNull class]]?0:[dict[@"toUId"] longLongValue];

model.userBlack=[dict[@"userBlack"] isKindOfClass:[NSNull class]]?0:[dict[@"userBlack"] intValue];

model.voiceBlack=[dict[@"voiceBlack"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceBlack"] intValue];

model.textBlack=[dict[@"textBlack"] isKindOfClass:[NSNull class]]?0:[dict[@"textBlack"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(ApiUsersVideoBlackVOModel*) source target:(ApiUsersVideoBlackVOModel*)target
{

target.videoBlack=source.videoBlack;

target.toUId=source.toUId;

target.userBlack=source.userBlack;

target.voiceBlack=source.voiceBlack;

target.textBlack=source.textBlack;

target.userId=source.userId;

}

@end

