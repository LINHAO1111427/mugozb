//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "HomeDtoModel.h"
#import "KeyValueDtoModel.h"
#import "AppHomeHallDTOModel.h"
#import "AppLiveChannelModel.h"
#import "AppHotSortModel.h"




 @implementation HomeDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"headerTypes" : [KeyValueDtoModel class],@"hotAnchors" : [AppHomeHallDTOModel class],@"liveChannels" : [AppLiveChannelModel class],@"hotSorts" : [AppHotSortModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_headerTypes;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
KeyValueDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"headerTypes"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_hotAnchors;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHomeHallDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"hotAnchors"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_liveChannels;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiveChannelModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"liveChannels"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_hotSorts;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppHotSortModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"hotSorts"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<HomeDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
HomeDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<HomeDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<HomeDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
HomeDtoModel* sumMdl=[HomeDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(HomeDtoModel*)getFromDict:(NSDictionary*)dict
{
HomeDtoModel* model=[[HomeDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.headerTypes=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"headerTypes"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
KeyValueDtoModel* sumMdl=[KeyValueDtoModel getFromDict:subDic];
[model.headerTypes addObject:sumMdl];

}
}

}

model.hotAnchors=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"hotAnchors"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHomeHallDTOModel* sumMdl=[AppHomeHallDTOModel getFromDict:subDic];
[model.hotAnchors addObject:sumMdl];

}
}

}

model.liveChannels=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"liveChannels"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveChannelModel* sumMdl=[AppLiveChannelModel getFromDict:subDic];
[model.liveChannels addObject:sumMdl];

}
}

}

model.hotSorts=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"hotSorts"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppHotSortModel* sumMdl=[AppHotSortModel getFromDict:subDic];
[model.hotSorts addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(HomeDtoModel*) source target:(HomeDtoModel*)target
{

        if(source.headerTypes==nil)
        {
//            target.headerTypes=nil;
        }else
        {
            target.headerTypes=[[NSMutableArray alloc] init];
            for(int i=0;i<source.headerTypes.count;i++)
            {
		  [target.headerTypes addObject:[[KeyValueDtoModel alloc]init]];
            [KeyValueDtoModel cloneObj:source.headerTypes[i] target:target.headerTypes[i]];
            }
        }


        if(source.hotAnchors==nil)
        {
//            target.hotAnchors=nil;
        }else
        {
            target.hotAnchors=[[NSMutableArray alloc] init];
            for(int i=0;i<source.hotAnchors.count;i++)
            {
		  [target.hotAnchors addObject:[[AppHomeHallDTOModel alloc]init]];
            [AppHomeHallDTOModel cloneObj:source.hotAnchors[i] target:target.hotAnchors[i]];
            }
        }


        if(source.liveChannels==nil)
        {
//            target.liveChannels=nil;
        }else
        {
            target.liveChannels=[[NSMutableArray alloc] init];
            for(int i=0;i<source.liveChannels.count;i++)
            {
		  [target.liveChannels addObject:[[AppLiveChannelModel alloc]init]];
            [AppLiveChannelModel cloneObj:source.liveChannels[i] target:target.liveChannels[i]];
            }
        }


        if(source.hotSorts==nil)
        {
//            target.hotSorts=nil;
        }else
        {
            target.hotSorts=[[NSMutableArray alloc] init];
            for(int i=0;i<source.hotSorts.count;i++)
            {
		  [target.hotSorts addObject:[[AppHotSortModel alloc]init]];
            [AppHotSortModel cloneObj:source.hotSorts[i] target:target.hotSorts[i]];
            }
        }


}

@end

