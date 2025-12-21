//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "PrivilegeShowInfoModel.h"




 @implementation PrivilegeShowInfoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"stealthPrivileges"]=@(_stealthPrivileges);

dict[@"totalStation"]=@(_totalStation);

dict[@"broadCast"]=@(_broadCast);

dict[@"chargeShow"]=@(_chargeShow);

dict[@"stationLowesGradeName"]=_stationLowesGradeName;

dict[@"joinRoomShow"]=@(_joinRoomShow);

dict[@"stealthLowesGradeName"]=_stealthLowesGradeName;

dict[@"devoteShow"]=@(_devoteShow);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PrivilegeShowInfoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
PrivilegeShowInfoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<PrivilegeShowInfoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<PrivilegeShowInfoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PrivilegeShowInfoModel* sumMdl=[PrivilegeShowInfoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(PrivilegeShowInfoModel*)getFromDict:(NSDictionary*)dict
{
PrivilegeShowInfoModel* model=[[PrivilegeShowInfoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.stealthPrivileges=[dict[@"stealthPrivileges"] isKindOfClass:[NSNull class]]?0:[dict[@"stealthPrivileges"] intValue];

model.totalStation=[dict[@"totalStation"] isKindOfClass:[NSNull class]]?0:[dict[@"totalStation"] intValue];

model.broadCast=[dict[@"broadCast"] isKindOfClass:[NSNull class]]?0:[dict[@"broadCast"] intValue];

model.chargeShow=[dict[@"chargeShow"] isKindOfClass:[NSNull class]]?0:[dict[@"chargeShow"] intValue];

model.stationLowesGradeName=[dict[@"stationLowesGradeName"] isKindOfClass:[NSNull class]]?@"":dict[@"stationLowesGradeName"];

model.joinRoomShow=[dict[@"joinRoomShow"] isKindOfClass:[NSNull class]]?0:[dict[@"joinRoomShow"] intValue];

model.stealthLowesGradeName=[dict[@"stealthLowesGradeName"] isKindOfClass:[NSNull class]]?@"":dict[@"stealthLowesGradeName"];

model.devoteShow=[dict[@"devoteShow"] isKindOfClass:[NSNull class]]?0:[dict[@"devoteShow"] intValue];


 return model;
}

 +(void)cloneObj:(PrivilegeShowInfoModel*) source target:(PrivilegeShowInfoModel*)target
{

target.stealthPrivileges=source.stealthPrivileges;

target.totalStation=source.totalStation;

target.broadCast=source.broadCast;

target.chargeShow=source.chargeShow;

target.stationLowesGradeName=source.stationLowesGradeName;

target.joinRoomShow=source.joinRoomShow;

target.stealthLowesGradeName=source.stealthLowesGradeName;

target.devoteShow=source.devoteShow;

}

@end

