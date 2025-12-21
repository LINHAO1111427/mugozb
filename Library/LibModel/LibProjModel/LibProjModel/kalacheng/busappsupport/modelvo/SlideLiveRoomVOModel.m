//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SlideLiveRoomVOModel.h"
#import "SlideLiveRoomInfoModel.h"




 @implementation SlideLiveRoomVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"slideLiveRoomInfoList" : [SlideLiveRoomInfoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_slideLiveRoomInfoList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
SlideLiveRoomInfoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"slideLiveRoomInfoList"]=list;
}//end

dict[@"mySerialNumber"]=@(_mySerialNumber);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SlideLiveRoomVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SlideLiveRoomVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SlideLiveRoomVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SlideLiveRoomVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SlideLiveRoomVOModel* sumMdl=[SlideLiveRoomVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SlideLiveRoomVOModel*)getFromDict:(NSDictionary*)dict
{
SlideLiveRoomVOModel* model=[[SlideLiveRoomVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.slideLiveRoomInfoList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"slideLiveRoomInfoList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SlideLiveRoomInfoModel* sumMdl=[SlideLiveRoomInfoModel getFromDict:subDic];
[model.slideLiveRoomInfoList addObject:sumMdl];

}
}

}

model.mySerialNumber=[dict[@"mySerialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"mySerialNumber"] intValue];


 return model;
}

 +(void)cloneObj:(SlideLiveRoomVOModel*) source target:(SlideLiveRoomVOModel*)target
{

        if(source.slideLiveRoomInfoList==nil)
        {
//            target.slideLiveRoomInfoList=nil;
        }else
        {
            target.slideLiveRoomInfoList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.slideLiveRoomInfoList.count;i++)
            {
		  [target.slideLiveRoomInfoList addObject:[[SlideLiveRoomInfoModel alloc]init]];
            [SlideLiveRoomInfoModel cloneObj:source.slideLiveRoomInfoList[i] target:target.slideLiveRoomInfoList[i]];
            }
        }


target.mySerialNumber=source.mySerialNumber;

}

@end

