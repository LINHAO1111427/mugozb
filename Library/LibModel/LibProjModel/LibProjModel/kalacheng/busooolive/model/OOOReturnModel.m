//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOReturnModel.h"
#import "OTMAssisRetModel.h"




 @implementation OOOReturnModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"otmAssisRetList" : [OTMAssisRetModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"anchorShowAddr"]=_anchorShowAddr;

dict[@"freeCallMsg"]=_freeCallMsg;

dict[@"noticeMsg"]=_noticeMsg;


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

dict[@"hostId"]=@(_hostId);

dict[@"isVideo"]=@(_isVideo);

dict[@"sessionID"]=@(_sessionID);

dict[@"type"]=@(_type);

dict[@"feeId"]=@(_feeId);

dict[@"roomId"]=@(_roomId);

dict[@"showid"]=_showid;

dict[@"freeCallDuration"]=@(_freeCallDuration);

dict[@"whetherToPay"]=@(_whetherToPay);

dict[@"m_type"]=@(_m_type);

dict[@"anchorShowCity"]=_anchorShowCity;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOReturnModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOReturnModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOReturnModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOReturnModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOReturnModel* sumMdl=[OOOReturnModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOReturnModel*)getFromDict:(NSDictionary*)dict
{
OOOReturnModel* model=[[OOOReturnModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.anchorShowAddr=[dict[@"anchorShowAddr"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorShowAddr"];

model.freeCallMsg=[dict[@"freeCallMsg"] isKindOfClass:[NSNull class]]?@"":dict[@"freeCallMsg"];

model.noticeMsg=[dict[@"noticeMsg"] isKindOfClass:[NSNull class]]?@"":dict[@"noticeMsg"];

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

model.hostId=[dict[@"hostId"] isKindOfClass:[NSNull class]]?0:[dict[@"hostId"] longLongValue];

model.isVideo=[dict[@"isVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isVideo"] intValue];

model.sessionID=[dict[@"sessionID"] isKindOfClass:[NSNull class]]?0:[dict[@"sessionID"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.feeId=[dict[@"feeId"] isKindOfClass:[NSNull class]]?0:[dict[@"feeId"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.showid=[dict[@"showid"] isKindOfClass:[NSNull class]]?@"":dict[@"showid"];

model.freeCallDuration=[dict[@"freeCallDuration"] isKindOfClass:[NSNull class]]?0:[dict[@"freeCallDuration"] intValue];

model.whetherToPay=[dict[@"whetherToPay"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherToPay"] intValue];

model.m_type=[dict[@"m_type"] isKindOfClass:[NSNull class]]?0:[dict[@"m_type"] intValue];

model.anchorShowCity=[dict[@"anchorShowCity"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorShowCity"];


 return model;
}

 +(void)cloneObj:(OOOReturnModel*) source target:(OOOReturnModel*)target
{

target.anchorShowAddr=source.anchorShowAddr;

target.freeCallMsg=source.freeCallMsg;

target.noticeMsg=source.noticeMsg;

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


target.hostId=source.hostId;

target.isVideo=source.isVideo;

target.sessionID=source.sessionID;

target.type=source.type;

target.feeId=source.feeId;

target.roomId=source.roomId;

target.showid=source.showid;

target.freeCallDuration=source.freeCallDuration;

target.whetherToPay=source.whetherToPay;

target.m_type=source.m_type;

target.anchorShowCity=source.anchorShowCity;

}

@end

