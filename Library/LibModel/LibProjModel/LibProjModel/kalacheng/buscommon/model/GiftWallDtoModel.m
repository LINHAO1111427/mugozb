//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GiftWallDtoModel.h"




 @implementation GiftWallDtoModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"gifticon"]=_gifticon;

dict[@"giftname"]=_giftname;

dict[@"giftId"]=@(_giftId);

dict[@"needScore"]=@(_needScore);

dict[@"totalNum"]=@(_totalNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GiftWallDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GiftWallDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GiftWallDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GiftWallDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GiftWallDtoModel* sumMdl=[GiftWallDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GiftWallDtoModel*)getFromDict:(NSDictionary*)dict
{
GiftWallDtoModel* model=[[GiftWallDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.gifticon=[dict[@"gifticon"] isKindOfClass:[NSNull class]]?@"":dict[@"gifticon"];

model.giftname=[dict[@"giftname"] isKindOfClass:[NSNull class]]?@"":dict[@"giftname"];

model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.needScore=[dict[@"needScore"] isKindOfClass:[NSNull class]]?0:[dict[@"needScore"] doubleValue];

model.totalNum=[dict[@"totalNum"] isKindOfClass:[NSNull class]]?0:[dict[@"totalNum"] intValue];


 return model;
}

 +(void)cloneObj:(GiftWallDtoModel*) source target:(GiftWallDtoModel*)target
{

target.gifticon=source.gifticon;

target.giftname=source.giftname;

target.giftId=source.giftId;

target.needScore=source.needScore;

target.totalNum=source.totalNum;

}

@end

