//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveRoomAdsListVOModel.h"
#import "LiveRoomAdsModel.h"




 @implementation LiveRoomAdsListVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"twoLiveRoomAdsList" : [LiveRoomAdsModel class],@"liveRoomAds" : [LiveRoomAdsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_twoLiveRoomAdsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
LiveRoomAdsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"twoLiveRoomAdsList"]=list;
}//end

dict[@"liveRoomAds"]=[_liveRoomAds modelToJSONObject];


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomAdsListVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveRoomAdsListVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveRoomAdsListVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveRoomAdsListVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomAdsListVOModel* sumMdl=[LiveRoomAdsListVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveRoomAdsListVOModel*)getFromDict:(NSDictionary*)dict
{
LiveRoomAdsListVOModel* model=[[LiveRoomAdsListVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.twoLiveRoomAdsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"twoLiveRoomAdsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomAdsModel* sumMdl=[LiveRoomAdsModel getFromDict:subDic];
[model.twoLiveRoomAdsList addObject:sumMdl];

}
}

}


//getFromDict对象转换  
model.liveRoomAds=[LiveRoomAdsModel getFromDict:dict[@"liveRoomAds"]];


 return model;
}

 +(void)cloneObj:(LiveRoomAdsListVOModel*) source target:(LiveRoomAdsListVOModel*)target
{

        if(source.twoLiveRoomAdsList==nil)
        {
//            target.twoLiveRoomAdsList=nil;
        }else
        {
            target.twoLiveRoomAdsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.twoLiveRoomAdsList.count;i++)
            {
		  [target.twoLiveRoomAdsList addObject:[[LiveRoomAdsModel alloc]init]];
            [LiveRoomAdsModel cloneObj:source.twoLiveRoomAdsList[i] target:target.twoLiveRoomAdsList[i]];
            }
        }

        if(source.liveRoomAds==nil)
        {
//            target.liveRoomAds=nil;
        }else
        {
            [LiveRoomAdsModel cloneObj:source.liveRoomAds target:target.liveRoomAds];
        }

}

@end

