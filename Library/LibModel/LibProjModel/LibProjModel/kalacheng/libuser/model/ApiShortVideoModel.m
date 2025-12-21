//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShortVideoModel.h"
#import "ApiShortVideoDtoModel.h"
#import "AppHotSortModel.h"
#import "AppAdsModel.h"




 @implementation ApiShortVideoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"weekList" : [ApiShortVideoDtoModel class],@"classifyList" : [AppHotSortModel class],@"adsList" : [AppAdsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_weekList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiShortVideoDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"weekList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_classifyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHotSortModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"classifyList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_adsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppAdsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"adsList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShortVideoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShortVideoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShortVideoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShortVideoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoModel* sumMdl=[ApiShortVideoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShortVideoModel*)getFromDict:(NSDictionary*)dict
{
ApiShortVideoModel* model=[[ApiShortVideoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.weekList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"weekList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoDtoModel* sumMdl=[ApiShortVideoDtoModel getFromDict:subDic];
[model.weekList addObject:sumMdl];

}
}

}

model.classifyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"classifyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHotSortModel* sumMdl=[AppHotSortModel getFromDict:subDic];
[model.classifyList addObject:sumMdl];

}
}

}

model.adsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"adsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppAdsModel* sumMdl=[AppAdsModel getFromDict:subDic];
[model.adsList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ApiShortVideoModel*) source target:(ApiShortVideoModel*)target
{

        if(source.weekList==nil)
        {
//            target.weekList=nil;
        }else
        {
            target.weekList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.weekList.count;i++)
            {
		  [target.weekList addObject:[[ApiShortVideoDtoModel alloc]init]];
            [ApiShortVideoDtoModel cloneObj:source.weekList[i] target:target.weekList[i]];
            }
        }


        if(source.classifyList==nil)
        {
//            target.classifyList=nil;
        }else
        {
            target.classifyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.classifyList.count;i++)
            {
		  [target.classifyList addObject:[[AppHotSortModel alloc]init]];
            [AppHotSortModel cloneObj:source.classifyList[i] target:target.classifyList[i]];
            }
        }


        if(source.adsList==nil)
        {
//            target.adsList=nil;
        }else
        {
            target.adsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.adsList.count;i++)
            {
		  [target.adsList addObject:[[AppAdsModel alloc]init]];
            [AppAdsModel cloneObj:source.adsList[i] target:target.adsList[i]];
            }
        }


}

@end

