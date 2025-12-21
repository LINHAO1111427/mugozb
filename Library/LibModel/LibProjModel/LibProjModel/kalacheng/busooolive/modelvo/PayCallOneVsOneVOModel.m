//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "PayCallOneVsOneVOModel.h"
#import "StarPriceDOModel.h"




 @implementation PayCallOneVsOneVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"videoPriceList" : [StarPriceDOModel class],@"voicePriceList" : [StarPriceDOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"voice"]=_voice;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_videoPriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"videoPriceList"]=list;
}//end

dict[@"videoCoin"]=@(_videoCoin);

dict[@"videoImg"]=_videoImg;

dict[@"voiceCoin"]=@(_voiceCoin);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_voicePriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"voicePriceList"]=list;
}//end

dict[@"id"]=@(_id_field);

dict[@"video"]=_video;

dict[@"poster"]=_poster;

dict[@"userId"]=@(_userId);

dict[@"voiceTime"]=@(_voiceTime);

dict[@"liveState"]=@(_liveState);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PayCallOneVsOneVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
PayCallOneVsOneVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<PayCallOneVsOneVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<PayCallOneVsOneVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PayCallOneVsOneVOModel* sumMdl=[PayCallOneVsOneVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(PayCallOneVsOneVOModel*)getFromDict:(NSDictionary*)dict
{
PayCallOneVsOneVOModel* model=[[PayCallOneVsOneVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.voice=[dict[@"voice"] isKindOfClass:[NSNull class]]?@"":dict[@"voice"];

model.videoPriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"videoPriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.videoPriceList addObject:sumMdl];

}
}

}

model.videoCoin=[dict[@"videoCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"videoCoin"] doubleValue];

model.videoImg=[dict[@"videoImg"] isKindOfClass:[NSNull class]]?@"":dict[@"videoImg"];

model.voiceCoin=[dict[@"voiceCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceCoin"] doubleValue];

model.voicePriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"voicePriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.voicePriceList addObject:sumMdl];

}
}

}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.video=[dict[@"video"] isKindOfClass:[NSNull class]]?@"":dict[@"video"];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.voiceTime=[dict[@"voiceTime"] isKindOfClass:[NSNull class]]?0:[dict[@"voiceTime"] longLongValue];

model.liveState=[dict[@"liveState"] isKindOfClass:[NSNull class]]?0:[dict[@"liveState"] intValue];


 return model;
}

 +(void)cloneObj:(PayCallOneVsOneVOModel*) source target:(PayCallOneVsOneVOModel*)target
{

target.voice=source.voice;

        if(source.videoPriceList==nil)
        {
//            target.videoPriceList=nil;
        }else
        {
            target.videoPriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.videoPriceList.count;i++)
            {
		  [target.videoPriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.videoPriceList[i] target:target.videoPriceList[i]];
            }
        }


target.videoCoin=source.videoCoin;

target.videoImg=source.videoImg;

target.voiceCoin=source.voiceCoin;

        if(source.voicePriceList==nil)
        {
//            target.voicePriceList=nil;
        }else
        {
            target.voicePriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.voicePriceList.count;i++)
            {
		  [target.voicePriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.voicePriceList[i] target:target.voicePriceList[i]];
            }
        }


target.id_field=source.id_field;

target.video=source.video;

target.poster=source.poster;

target.userId=source.userId;

target.voiceTime=source.voiceTime;

target.liveState=source.liveState;

}

@end

