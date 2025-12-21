//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveRoomTypeDTOModel.h"




 @implementation LiveRoomTypeDTOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"roomTypeVal"]=_roomTypeVal;

dict[@"id"]=@(_id_field);

dict[@"roomName"]=_roomName;

dict[@"roomType"]=@(_roomType);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRoomTypeDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveRoomTypeDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveRoomTypeDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveRoomTypeDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRoomTypeDTOModel* sumMdl=[LiveRoomTypeDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveRoomTypeDTOModel*)getFromDict:(NSDictionary*)dict
{
LiveRoomTypeDTOModel* model=[[LiveRoomTypeDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.roomTypeVal=[dict[@"roomTypeVal"] isKindOfClass:[NSNull class]]?@"":dict[@"roomTypeVal"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.roomName=[dict[@"roomName"] isKindOfClass:[NSNull class]]?@"":dict[@"roomName"];

model.roomType=[dict[@"roomType"] isKindOfClass:[NSNull class]]?0:[dict[@"roomType"] intValue];


 return model;
}

 +(void)cloneObj:(LiveRoomTypeDTOModel*) source target:(LiveRoomTypeDTOModel*)target
{

target.roomTypeVal=source.roomTypeVal;

target.id_field=source.id_field;

target.roomName=source.roomName;

target.roomType=source.roomType;

}

@end

