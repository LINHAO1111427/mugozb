//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserIndexRespModel.h"
#import "ApiUserIndexNodeModel.h"




 @implementation ApiUserIndexRespModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userlist" : [ApiUserIndexNodeModel class],@"setList" : [ApiUserIndexNodeModel class],@"infoList" : [ApiUserIndexNodeModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"birthday"]=_birthday;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userlist;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserIndexNodeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userlist"]=list;
}//end

dict[@"address"]=_address;

dict[@"signature"]=_signature;

dict[@"user_name"]=_user_name;

dict[@"sex"]=@(_sex);

dict[@"avatar"]=_avatar;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_setList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserIndexNodeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"setList"]=list;
}//end

dict[@"userId"]=@(_userId);

dict[@"anchor_level"]=_anchor_level;

dict[@"user_level"]=_user_level;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_infoList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserIndexNodeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"infoList"]=list;
}//end

dict[@"live_thumb"]=_live_thumb;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserIndexRespModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserIndexRespModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserIndexRespModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserIndexRespModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexRespModel* sumMdl=[ApiUserIndexRespModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserIndexRespModel*)getFromDict:(NSDictionary*)dict
{
ApiUserIndexRespModel* model=[[ApiUserIndexRespModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.birthday=[dict[@"birthday"] isKindOfClass:[NSNull class]]?@"":dict[@"birthday"];

model.userlist=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userlist"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexNodeModel* sumMdl=[ApiUserIndexNodeModel getFromDict:subDic];
[model.userlist addObject:sumMdl];

}
}

}

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.signature=[dict[@"signature"] isKindOfClass:[NSNull class]]?@"":dict[@"signature"];

model.user_name=[dict[@"user_name"] isKindOfClass:[NSNull class]]?@"":dict[@"user_name"];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.setList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"setList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexNodeModel* sumMdl=[ApiUserIndexNodeModel getFromDict:subDic];
[model.setList addObject:sumMdl];

}
}

}

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.anchor_level=[dict[@"anchor_level"] isKindOfClass:[NSNull class]]?@"":dict[@"anchor_level"];

model.user_level=[dict[@"user_level"] isKindOfClass:[NSNull class]]?@"":dict[@"user_level"];

model.infoList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"infoList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexNodeModel* sumMdl=[ApiUserIndexNodeModel getFromDict:subDic];
[model.infoList addObject:sumMdl];

}
}

}

model.live_thumb=[dict[@"live_thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"live_thumb"];


 return model;
}

 +(void)cloneObj:(ApiUserIndexRespModel*) source target:(ApiUserIndexRespModel*)target
{

target.birthday=source.birthday;

        if(source.userlist==nil)
        {
//            target.userlist=nil;
        }else
        {
            target.userlist=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userlist.count;i++)
            {
		  [target.userlist addObject:[[ApiUserIndexNodeModel alloc]init]];
            [ApiUserIndexNodeModel cloneObj:source.userlist[i] target:target.userlist[i]];
            }
        }


target.address=source.address;

target.signature=source.signature;

target.user_name=source.user_name;

target.sex=source.sex;

target.avatar=source.avatar;

        if(source.setList==nil)
        {
//            target.setList=nil;
        }else
        {
            target.setList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.setList.count;i++)
            {
		  [target.setList addObject:[[ApiUserIndexNodeModel alloc]init]];
            [ApiUserIndexNodeModel cloneObj:source.setList[i] target:target.setList[i]];
            }
        }


target.userId=source.userId;

target.anchor_level=source.anchor_level;

target.user_level=source.user_level;

        if(source.infoList==nil)
        {
//            target.infoList=nil;
        }else
        {
            target.infoList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.infoList.count;i++)
            {
		  [target.infoList addObject:[[ApiUserIndexNodeModel alloc]init]];
            [ApiUserIndexNodeModel cloneObj:source.infoList[i] target:target.infoList[i]];
            }
        }


target.live_thumb=source.live_thumb;

}

@end

