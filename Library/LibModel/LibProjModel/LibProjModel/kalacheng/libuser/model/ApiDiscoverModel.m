//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiDiscoverModel.h"
#import "AppUserModel.h"
#import "AppVideoTopicModel.h"




 @implementation ApiDiscoverModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"anchor" : [AppUserModel class],@"hotTopics" : [AppVideoTopicModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_anchor;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppUserModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"anchor"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_hotTopics;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppVideoTopicModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"hotTopics"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiDiscoverModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiDiscoverModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiDiscoverModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiDiscoverModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiDiscoverModel* sumMdl=[ApiDiscoverModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiDiscoverModel*)getFromDict:(NSDictionary*)dict
{
ApiDiscoverModel* model=[[ApiDiscoverModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.anchor=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"anchor"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUserModel* sumMdl=[AppUserModel getFromDict:subDic];
[model.anchor addObject:sumMdl];

}
}

}

model.hotTopics=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"hotTopics"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppVideoTopicModel* sumMdl=[AppVideoTopicModel getFromDict:subDic];
[model.hotTopics addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ApiDiscoverModel*) source target:(ApiDiscoverModel*)target
{

        if(source.anchor==nil)
        {
//            target.anchor=nil;
        }else
        {
            target.anchor=[[NSMutableArray alloc] init];
            for(int i=0;i<source.anchor.count;i++)
            {
		  [target.anchor addObject:[[AppUserModel alloc]init]];
            [AppUserModel cloneObj:source.anchor[i] target:target.anchor[i]];
            }
        }


        if(source.hotTopics==nil)
        {
//            target.hotTopics=nil;
        }else
        {
            target.hotTopics=[[NSMutableArray alloc] init];
            for(int i=0;i<source.hotTopics.count;i++)
            {
		  [target.hotTopics addObject:[[AppVideoTopicModel alloc]init]];
            [AppVideoTopicModel cloneObj:source.hotTopics[i] target:target.hotTopics[i]];
            }
        }


}

@end

