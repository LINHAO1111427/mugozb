//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOVolumeRetModel.h"
#import "OTMAssisRetModel.h"




 @implementation OOOVolumeRetModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"otmAssisRetList" : [OTMAssisRetModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"operateUid"]=@(_operateUid);

dict[@"operateStatus"]=@(_operateStatus);

dict[@"hostUid"]=@(_hostUid);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_otmAssisRetList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
OTMAssisRetModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"otmAssisRetList"]=list;
}//end

dict[@"feeUid"]=@(_feeUid);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOVolumeRetModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOVolumeRetModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOVolumeRetModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOVolumeRetModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOVolumeRetModel* sumMdl=[OOOVolumeRetModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOVolumeRetModel*)getFromDict:(NSDictionary*)dict
{
OOOVolumeRetModel* model=[[OOOVolumeRetModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.operateUid=[dict[@"operateUid"] isKindOfClass:[NSNull class]]?0:[dict[@"operateUid"] longLongValue];

model.operateStatus=[dict[@"operateStatus"] isKindOfClass:[NSNull class]]?0:[dict[@"operateStatus"] intValue];

model.hostUid=[dict[@"hostUid"] isKindOfClass:[NSNull class]]?0:[dict[@"hostUid"] longLongValue];

model.otmAssisRetList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"otmAssisRetList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OTMAssisRetModel* sumMdl=[OTMAssisRetModel getFromDict:subDic];
[model.otmAssisRetList addObject:sumMdl];

}
}

}

model.feeUid=[dict[@"feeUid"] isKindOfClass:[NSNull class]]?0:[dict[@"feeUid"] longLongValue];


 return model;
}

 +(void)cloneObj:(OOOVolumeRetModel*) source target:(OOOVolumeRetModel*)target
{

target.operateUid=source.operateUid;

target.operateStatus=source.operateStatus;

target.hostUid=source.hostUid;

        if(source.otmAssisRetList==nil)
        {
//            target.otmAssisRetList=nil;
        }else
        {
            target.otmAssisRetList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.otmAssisRetList.count;i++)
            {
		  [target.otmAssisRetList addObject:[[OTMAssisRetModel alloc]init]];
            [OTMAssisRetModel cloneObj:source.otmAssisRetList[i] target:target.otmAssisRetList[i]];
            }
        }


target.feeUid=source.feeUid;

}

@end

