//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserGroupIdDtoModel.h"
#import "AppIdBOModel.h"




 @implementation UserGroupIdDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"groupIdList" : [AppIdBOModel class],@"userIdList" : [AppIdBOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_groupIdList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppIdBOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"groupIdList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userIdList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppIdBOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userIdList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserGroupIdDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserGroupIdDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserGroupIdDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserGroupIdDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserGroupIdDtoModel* sumMdl=[UserGroupIdDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserGroupIdDtoModel*)getFromDict:(NSDictionary*)dict
{
UserGroupIdDtoModel* model=[[UserGroupIdDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.groupIdList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"groupIdList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppIdBOModel* sumMdl=[AppIdBOModel getFromDict:subDic];
[model.groupIdList addObject:sumMdl];

}
}

}

model.userIdList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userIdList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppIdBOModel* sumMdl=[AppIdBOModel getFromDict:subDic];
[model.userIdList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(UserGroupIdDtoModel*) source target:(UserGroupIdDtoModel*)target
{

        if(source.groupIdList==nil)
        {
//            target.groupIdList=nil;
        }else
        {
            target.groupIdList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.groupIdList.count;i++)
            {
		  [target.groupIdList addObject:[[AppIdBOModel alloc]init]];
            [AppIdBOModel cloneObj:source.groupIdList[i] target:target.groupIdList[i]];
            }
        }


        if(source.userIdList==nil)
        {
//            target.userIdList=nil;
        }else
        {
            target.userIdList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userIdList.count;i++)
            {
		  [target.userIdList addObject:[[AppIdBOModel alloc]init]];
            [AppIdBOModel cloneObj:source.userIdList[i] target:target.userIdList[i]];
            }
        }


}

@end

