//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserBuyDTOModel.h"




 @implementation UserBuyDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"avatar"]=_avatar;

dict[@"username"]=_username;

dict[@"goodsName"]=_goodsName;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserBuyDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserBuyDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserBuyDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserBuyDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserBuyDTOModel* sumMdl=[UserBuyDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserBuyDTOModel*)getFromDict:(NSDictionary*)dict
{
UserBuyDTOModel* model=[[UserBuyDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];

model.goodsName=[dict[@"goodsName"] isKindOfClass:[NSNull class]]?@"":dict[@"goodsName"];


 return model;
}

 +(void)cloneObj:(UserBuyDTOModel*) source target:(UserBuyDTOModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.avatar=source.avatar;

target.username=source.username;

target.goodsName=source.goodsName;

}

@end

