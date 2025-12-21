//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MsgNotifySwitchVOModel.h"




 @implementation MsgNotifySwitchVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"toneSwitch"]=@(_toneSwitch);

dict[@"userId"]=@(_userId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MsgNotifySwitchVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MsgNotifySwitchVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MsgNotifySwitchVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MsgNotifySwitchVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MsgNotifySwitchVOModel* sumMdl=[MsgNotifySwitchVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MsgNotifySwitchVOModel*)getFromDict:(NSDictionary*)dict
{
MsgNotifySwitchVOModel* model=[[MsgNotifySwitchVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.toneSwitch=[dict[@"toneSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"toneSwitch"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];


 return model;
}

 +(void)cloneObj:(MsgNotifySwitchVOModel*) source target:(MsgNotifySwitchVOModel*)target
{

target.toneSwitch=source.toneSwitch;

target.userId=source.userId;

}

@end

