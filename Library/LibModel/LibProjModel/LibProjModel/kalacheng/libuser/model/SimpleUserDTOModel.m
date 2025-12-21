//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SimpleUserDTOModel.h"




 @implementation SimpleUserDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"avatar"]=_avatar;

dict[@"userid"]=@(_userid);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SimpleUserDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SimpleUserDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SimpleUserDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SimpleUserDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SimpleUserDTOModel* sumMdl=[SimpleUserDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SimpleUserDTOModel*)getFromDict:(NSDictionary*)dict
{
SimpleUserDTOModel* model=[[SimpleUserDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(SimpleUserDTOModel*) source target:(SimpleUserDTOModel*)target
{

target.avatar=source.avatar;

target.userid=source.userid;

target.username=source.username;

}

@end

