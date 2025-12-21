//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "SlideLiveRoomInfoModel.h"




 @implementation SlideLiveRoomInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialNumber"]=@(_serialNumber);

dict[@"distance"]=@(_distance);

dict[@"liveType"]=@(_liveType);

dict[@"liveThumb"]=_liveThumb;

dict[@"roomId"]=@(_roomId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SlideLiveRoomInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
SlideLiveRoomInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<SlideLiveRoomInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<SlideLiveRoomInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
SlideLiveRoomInfoModel* sumMdl=[SlideLiveRoomInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(SlideLiveRoomInfoModel*)getFromDict:(NSDictionary*)dict
{
SlideLiveRoomInfoModel* model=[[SlideLiveRoomInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialNumber=[dict[@"serialNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"serialNumber"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.liveType=[dict[@"liveType"] isKindOfClass:[NSNull class]]?0:[dict[@"liveType"] intValue];

model.liveThumb=[dict[@"liveThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"liveThumb"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];


 return model;
}

 +(void)cloneObj:(SlideLiveRoomInfoModel*) source target:(SlideLiveRoomInfoModel*)target
{

target.serialNumber=source.serialNumber;

target.distance=source.distance;

target.liveType=source.liveType;

target.liveThumb=source.liveThumb;

target.roomId=source.roomId;

}

@end

