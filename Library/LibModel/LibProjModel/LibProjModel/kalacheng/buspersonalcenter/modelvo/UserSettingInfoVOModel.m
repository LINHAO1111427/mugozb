//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserSettingInfoVOModel.h"




 @implementation UserSettingInfoVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"giftGlobalBroadcast"]=@(_giftGlobalBroadcast);

dict[@"whetherEnablePositioningShow"]=@(_whetherEnablePositioningShow);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserSettingInfoVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserSettingInfoVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserSettingInfoVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserSettingInfoVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserSettingInfoVOModel* sumMdl=[UserSettingInfoVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserSettingInfoVOModel*)getFromDict:(NSDictionary*)dict
{
UserSettingInfoVOModel* model=[[UserSettingInfoVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.giftGlobalBroadcast=[dict[@"giftGlobalBroadcast"] isKindOfClass:[NSNull class]]?0:[dict[@"giftGlobalBroadcast"] intValue];

model.whetherEnablePositioningShow=[dict[@"whetherEnablePositioningShow"] isKindOfClass:[NSNull class]]?0:[dict[@"whetherEnablePositioningShow"] intValue];


 return model;
}

 +(void)cloneObj:(UserSettingInfoVOModel*) source target:(UserSettingInfoVOModel*)target
{

target.giftGlobalBroadcast=source.giftGlobalBroadcast;

target.whetherEnablePositioningShow=source.whetherEnablePositioningShow;

}

@end

