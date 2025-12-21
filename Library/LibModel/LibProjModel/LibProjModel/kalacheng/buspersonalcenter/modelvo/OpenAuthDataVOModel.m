//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OpenAuthDataVOModel.h"
#import "LiveRoomTypeDTOModel.h"




 @implementation OpenAuthDataVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"liveRoomTypeDTOS" : [LiveRoomTypeDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"address"]=_address;

dict[@"lng"]=@(_lng);

dict[@"city"]=_city;

dict[@"thumb"]=_thumb;

dict[@"roomTypeName"]=_roomTypeName;

dict[@"title"]=_title;

dict[@"roomId"]=@(_roomId);

dict[@"voiceThumb"]=_voiceThumb;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_liveRoomTypeDTOS;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
LiveRoomTypeDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"liveRoomTypeDTOS"]=list;
}//end

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"channelName"]=_channelName;

dict[@"channelId"]=@(_channelId);

dict[@"lat"]=@(_lat);

dict[@"roomType"]=@(_roomType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OpenAuthDataVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OpenAuthDataVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OpenAuthDataVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OpenAuthDataVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OpenAuthDataVOModel* sumMdl=[OpenAuthDataVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OpenAuthDataVOModel*)getFromDict:(NSDictionary*)dict
{
OpenAuthDataVOModel* model=[[OpenAuthDataVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.roomTypeName=[dict[@"roomTypeName"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeName"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.voiceThumb=[dict[@"voiceThumb"] isKindOfClass:[NSNull class]]?@"":dict[@"voiceThumb"];

model.liveRoomTypeDTOS=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"liveRoomTypeDTOS"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomTypeDTOModel* sumMdl=[LiveRoomTypeDTOModel getFromDict:subDic];
[model.liveRoomTypeDTOS addObject:sumMdl];

}
}

}

model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.channelName=[dict[@"channelName"] isKindOfClass:[NSNull class]]?@"":dict[@"channelName"];

model.channelId=[dict[@"channelId"] isKindOfClass:[NSNull class]]?0:[dict[@"channelId"] longLongValue];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];


 return model;
}

 +(void)cloneObj:(OpenAuthDataVOModel*) source target:(OpenAuthDataVOModel*)target
{

target.address=source.address;

target.lng=source.lng;

target.city=source.city;

target.thumb=source.thumb;

target.roomTypeName=source.roomTypeName;

target.title=source.title;

target.roomId=source.roomId;

target.voiceThumb=source.voiceThumb;

        if(source.liveRoomTypeDTOS==nil)
        {
//            target.liveRoomTypeDTOS=nil;
        }else
        {
            target.liveRoomTypeDTOS=[[NSMutableArray alloc] init];
            for(int i=0;i<source.liveRoomTypeDTOS.count;i++)
            {
		  [target.liveRoomTypeDTOS addObject:[[LiveRoomTypeDTOModel alloc]init]];
            [LiveRoomTypeDTOModel cloneObj:source.liveRoomTypeDTOS[i] target:target.liveRoomTypeDTOS[i]];
            }
        }


target.roomTypeVal=source.roomTypeVal;

target.channelName=source.channelName;

target.channelId=source.channelId;

target.lat=source.lat;

target.roomType=source.roomType;

}

@end

