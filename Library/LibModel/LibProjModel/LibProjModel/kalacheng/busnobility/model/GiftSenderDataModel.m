//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GiftSenderDataModel.h"




 @implementation GiftSenderDataModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"showId"]=_showId;

dict[@"taggerUserId"]=@(_taggerUserId);

dict[@"anchorId"]=@(_anchorId);

dict[@"roomId"]=@(_roomId);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftSenderDataModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GiftSenderDataModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GiftSenderDataModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GiftSenderDataModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftSenderDataModel* sumMdl=[GiftSenderDataModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GiftSenderDataModel*)getFromDict:(NSDictionary*)dict
{
GiftSenderDataModel* model=[[GiftSenderDataModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.showId=[dict[@"showId"] isKindOfClass:[NSNull class]]?@"":dict[@"showId"];

model.taggerUserId=[dict[@"taggerUserId"] isKindOfClass:[NSNull class]]?0:[dict[@"taggerUserId"] longLongValue];

model.anchorId=[dict[@"anchorId"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorId"] longLongValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];


 return model;
}

 +(void)cloneObj:(GiftSenderDataModel*) source target:(GiftSenderDataModel*)target
{

target.showId=source.showId;

target.taggerUserId=source.taggerUserId;

target.anchorId=source.anchorId;

target.roomId=source.roomId;

}

@end

