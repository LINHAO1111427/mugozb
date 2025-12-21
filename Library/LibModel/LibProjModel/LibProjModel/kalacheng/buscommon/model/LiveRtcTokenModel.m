//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "LiveRtcTokenModel.h"




 @implementation LiveRtcTokenModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"rtcToken"]=_rtcToken;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LiveRtcTokenModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
LiveRtcTokenModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<LiveRtcTokenModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<LiveRtcTokenModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
LiveRtcTokenModel* sumMdl=[LiveRtcTokenModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(LiveRtcTokenModel*)getFromDict:(NSDictionary*)dict
{
LiveRtcTokenModel* model=[[LiveRtcTokenModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.rtcToken=[dict[@"rtcToken"] isKindOfClass:[NSNull class]]?@"":dict[@"rtcToken"];


 return model;
}

 +(void)cloneObj:(LiveRtcTokenModel*) source target:(LiveRtcTokenModel*)target
{

target.rtcToken=source.rtcToken;

}

@end

