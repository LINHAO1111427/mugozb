//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SearchConditionDtoModel.h"
#import "AppLiveTagModel.h"
#import "AppTabInfoModel.h"
#import "KeyValueDtoModel.h"
#import "AppAreaModel.h"
#import "AppSearchRecordModel.h"




 @implementation SearchConditionDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"liveTagList" : [AppLiveTagModel class],@"allTabInfoList" : [AppTabInfoModel class],@"sexs" : [KeyValueDtoModel class],@"hotCitys" : [AppAreaModel class],@"historyRecords" : [AppSearchRecordModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_liveTagList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiveTagModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"liveTagList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_allTabInfoList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppTabInfoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"allTabInfoList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_sexs;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
KeyValueDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"sexs"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_hotCitys;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppAreaModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"hotCitys"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_historyRecords;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppSearchRecordModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"historyRecords"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SearchConditionDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SearchConditionDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SearchConditionDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SearchConditionDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SearchConditionDtoModel* sumMdl=[SearchConditionDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SearchConditionDtoModel*)getFromDict:(NSDictionary*)dict
{
SearchConditionDtoModel* model=[[SearchConditionDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.liveTagList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"liveTagList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveTagModel* sumMdl=[AppLiveTagModel getFromDict:subDic];
[model.liveTagList addObject:sumMdl];

}
}

}

model.allTabInfoList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"allTabInfoList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppTabInfoModel* sumMdl=[AppTabInfoModel getFromDict:subDic];
[model.allTabInfoList addObject:sumMdl];

}
}

}

model.sexs=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"sexs"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
KeyValueDtoModel* sumMdl=[KeyValueDtoModel getFromDict:subDic];
[model.sexs addObject:sumMdl];

}
}

}

model.hotCitys=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"hotCitys"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppAreaModel* sumMdl=[AppAreaModel getFromDict:subDic];
[model.hotCitys addObject:sumMdl];

}
}

}

model.historyRecords=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"historyRecords"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppSearchRecordModel* sumMdl=[AppSearchRecordModel getFromDict:subDic];
[model.historyRecords addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(SearchConditionDtoModel*) source target:(SearchConditionDtoModel*)target
{

        if(source.liveTagList==nil)
        {
//            target.liveTagList=nil;
        }else
        {
            target.liveTagList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.liveTagList.count;i++)
            {
		  [target.liveTagList addObject:[[AppLiveTagModel alloc]init]];
            [AppLiveTagModel cloneObj:source.liveTagList[i] target:target.liveTagList[i]];
            }
        }


        if(source.allTabInfoList==nil)
        {
//            target.allTabInfoList=nil;
        }else
        {
            target.allTabInfoList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.allTabInfoList.count;i++)
            {
		  [target.allTabInfoList addObject:[[AppTabInfoModel alloc]init]];
            [AppTabInfoModel cloneObj:source.allTabInfoList[i] target:target.allTabInfoList[i]];
            }
        }


        if(source.sexs==nil)
        {
//            target.sexs=nil;
        }else
        {
            target.sexs=[[NSMutableArray alloc] init];
            for(int i=0;i<source.sexs.count;i++)
            {
		  [target.sexs addObject:[[KeyValueDtoModel alloc]init]];
            [KeyValueDtoModel cloneObj:source.sexs[i] target:target.sexs[i]];
            }
        }


        if(source.hotCitys==nil)
        {
//            target.hotCitys=nil;
        }else
        {
            target.hotCitys=[[NSMutableArray alloc] init];
            for(int i=0;i<source.hotCitys.count;i++)
            {
		  [target.hotCitys addObject:[[AppAreaModel alloc]init]];
            [AppAreaModel cloneObj:source.hotCitys[i] target:target.hotCitys[i]];
            }
        }


        if(source.historyRecords==nil)
        {
//            target.historyRecords=nil;
        }else
        {
            target.historyRecords=[[NSMutableArray alloc] init];
            for(int i=0;i<source.historyRecords.count;i++)
            {
		  [target.historyRecords addObject:[[AppSearchRecordModel alloc]init]];
            [AppSearchRecordModel cloneObj:source.historyRecords[i] target:target.historyRecords[i]];
            }
        }


}

@end

