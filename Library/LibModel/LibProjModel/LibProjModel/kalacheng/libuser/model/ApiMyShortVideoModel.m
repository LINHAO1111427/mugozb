//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiMyShortVideoModel.h"
#import "ApiShortVideoDtoModel.h"




 @implementation ApiMyShortVideoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"buyList" : [ApiShortVideoDtoModel class],@"likeList" : [ApiShortVideoDtoModel class],@"myList" : [ApiShortVideoDtoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_buyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiShortVideoDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"buyList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_likeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiShortVideoDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"likeList"]=list;
}//end

dict[@"buyNumber"]=@(_buyNumber);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_myList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiShortVideoDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"myList"]=list;
}//end

dict[@"myNumber"]=@(_myNumber);

dict[@"likeNumber"]=@(_likeNumber);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiMyShortVideoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiMyShortVideoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiMyShortVideoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiMyShortVideoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiMyShortVideoModel* sumMdl=[ApiMyShortVideoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiMyShortVideoModel*)getFromDict:(NSDictionary*)dict
{
ApiMyShortVideoModel* model=[[ApiMyShortVideoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.buyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"buyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoDtoModel* sumMdl=[ApiShortVideoDtoModel getFromDict:subDic];
[model.buyList addObject:sumMdl];

}
}

}

model.likeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"likeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoDtoModel* sumMdl=[ApiShortVideoDtoModel getFromDict:subDic];
[model.likeList addObject:sumMdl];

}
}

}

model.buyNumber=[dict[@"buyNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"buyNumber"] intValue];

model.myList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"myList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoDtoModel* sumMdl=[ApiShortVideoDtoModel getFromDict:subDic];
[model.myList addObject:sumMdl];

}
}

}

model.myNumber=[dict[@"myNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"myNumber"] intValue];

model.likeNumber=[dict[@"likeNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"likeNumber"] intValue];


 return model;
}

 +(void)cloneObj:(ApiMyShortVideoModel*) source target:(ApiMyShortVideoModel*)target
{

        if(source.buyList==nil)
        {
//            target.buyList=nil;
        }else
        {
            target.buyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.buyList.count;i++)
            {
		  [target.buyList addObject:[[ApiShortVideoDtoModel alloc]init]];
            [ApiShortVideoDtoModel cloneObj:source.buyList[i] target:target.buyList[i]];
            }
        }


        if(source.likeList==nil)
        {
//            target.likeList=nil;
        }else
        {
            target.likeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.likeList.count;i++)
            {
		  [target.likeList addObject:[[ApiShortVideoDtoModel alloc]init]];
            [ApiShortVideoDtoModel cloneObj:source.likeList[i] target:target.likeList[i]];
            }
        }


target.buyNumber=source.buyNumber;

        if(source.myList==nil)
        {
//            target.myList=nil;
        }else
        {
            target.myList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.myList.count;i++)
            {
		  [target.myList addObject:[[ApiShortVideoDtoModel alloc]init]];
            [ApiShortVideoDtoModel cloneObj:source.myList[i] target:target.myList[i]];
            }
        }


target.myNumber=source.myNumber;

target.likeNumber=source.likeNumber;

}

@end

