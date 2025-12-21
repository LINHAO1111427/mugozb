//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShortVideoDtoModel.h"
#import "ShortVideoAdsVOModel.h"




 @implementation ApiShortVideoDtoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"adsBannerList" : [ShortVideoAdsVOModel class],@"avatarAdsList" : [ShortVideoAdsVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"longVideoClassifyOne"]=@(_longVideoClassifyOne);

dict[@"isRecommend"]=@(_isRecommend);

dict[@"fees"]=@(_fees);

dict[@"isEnableTemplate"]=@(_isEnableTemplate);

dict[@"classifyId"]=_classifyId;

dict[@"isLongVideo"]=@(_isLongVideo);

dict[@"type"]=@(_type);

dict[@"shareNum"]=@(_shareNum);

dict[@"productName"]=_productName;

dict[@"internalRecommended"]=@(_internalRecommended);

dict[@"number"]=@(_number);

dict[@"looks"]=@(_looks);

dict[@"isWeek"]=@(_isWeek);

dict[@"id"]=@(_id_field);

dict[@"videoTime"]=@(_videoTime);

dict[@"classifyName"]=_classifyName;

dict[@"lat"]=@(_lat);

dict[@"height"]=@(_height);

dict[@"likes"]=@(_likes);

dict[@"adsText"]=_adsText;

dict[@"randomOrder"]=@(_randomOrder);

dict[@"privilegesLowestName"]=_privilegesLowestName;

dict[@"images"]=_images;

dict[@"adsUrl"]=_adsUrl;

dict[@"isEnableMonitoring"]=@(_isEnableMonitoring);

dict[@"lng"]=@(_lng);

dict[@"productId"]=@(_productId);

dict[@"longVideoClassifyTwo"]=@(_longVideoClassifyTwo);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_adsBannerList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShortVideoAdsVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"adsBannerList"]=list;
}//end

dict[@"isAttention"]=@(_isAttention);

dict[@"shortVideoTrialTime"]=@(_shortVideoTrialTime);

dict[@"coin"]=@(_coin);

dict[@"status"]=@(_status);

dict[@"virtualOrNot"]=@(_virtualOrNot);

dict[@"role"]=@(_role);

dict[@"isLike"]=@(_isLike);

dict[@"city"]=_city;

dict[@"thumb"]=_thumb;

dict[@"adsTitle"]=_adsTitle;

dict[@"isPrivate"]=@(_isPrivate);

dict[@"content"]=_content;

dict[@"adsTemplateId"]=@(_adsTemplateId);

dict[@"videoUrl"]=_videoUrl;

dict[@"avatarAdsId1"]=@(_avatarAdsId1);

dict[@"adsType"]=@(_adsType);

dict[@"importTemplateId"]=@(_importTemplateId);

dict[@"isdel"]=@(_isdel);

dict[@"image5"]=_image5;

dict[@"image6"]=_image6;

dict[@"isEnableAdsTemplate"]=@(_isEnableAdsTemplate);

dict[@"image3"]=_image3;

dict[@"address"]=_address;

dict[@"comments"]=@(_comments);

dict[@"image4"]=_image4;

dict[@"isPay"]=@(_isPay);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_avatarAdsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ShortVideoAdsVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"avatarAdsList"]=list;
}//end

dict[@"avatarAdsId2"]=@(_avatarAdsId2);

dict[@"bannerAdsId3"]=@(_bannerAdsId3);

dict[@"avatar"]=_avatar;

dict[@"avatarAdsId3"]=@(_avatarAdsId3);

dict[@"bannerAdsId1"]=@(_bannerAdsId1);

dict[@"image1"]=_image1;

dict[@"bannerAdsId2"]=@(_bannerAdsId2);

dict[@"image2"]=_image2;

dict[@"userId"]=@(_userId);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"width"]=@(_width);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShortVideoDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShortVideoDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShortVideoDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShortVideoDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoDtoModel* sumMdl=[ApiShortVideoDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShortVideoDtoModel*)getFromDict:(NSDictionary*)dict
{
ApiShortVideoDtoModel* model=[[ApiShortVideoDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.longVideoClassifyOne=[dict[@"longVideoClassifyOne"] isKindOfClass:[NSNull class]]?0:[dict[@"longVideoClassifyOne"] longLongValue];

model.isRecommend=[dict[@"isRecommend"] isKindOfClass:[NSNull class]]?0:[dict[@"isRecommend"] intValue];

model.fees=[dict[@"fees"] isKindOfClass:[NSNull class]]?0:[dict[@"fees"] intValue];

model.isEnableTemplate=[dict[@"isEnableTemplate"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnableTemplate"] intValue];

model.classifyId=[dict[@"classifyId"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyId"];

model.isLongVideo=[dict[@"isLongVideo"] isKindOfClass:[NSNull class]]?0:[dict[@"isLongVideo"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.shareNum=[dict[@"shareNum"] isKindOfClass:[NSNull class]]?0:[dict[@"shareNum"] intValue];

model.productName=[dict[@"productName"] isKindOfClass:[NSNull class]]?@"":dict[@"productName"];

model.internalRecommended=[dict[@"internalRecommended"] isKindOfClass:[NSNull class]]?0:[dict[@"internalRecommended"] intValue];

model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.looks=[dict[@"looks"] isKindOfClass:[NSNull class]]?0:[dict[@"looks"] intValue];

model.isWeek=[dict[@"isWeek"] isKindOfClass:[NSNull class]]?0:[dict[@"isWeek"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.videoTime=[dict[@"videoTime"] isKindOfClass:[NSNull class]]?0:[dict[@"videoTime"] intValue];

model.classifyName=[dict[@"classifyName"] isKindOfClass:[NSNull class]]?@"":dict[@"classifyName"];

model.lat=[dict[@"lat"] isKindOfClass:[NSNull class]]?0:[dict[@"lat"] doubleValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.likes=[dict[@"likes"] isKindOfClass:[NSNull class]]?0:[dict[@"likes"] intValue];

model.adsText=[dict[@"adsText"] isKindOfClass:[NSNull class]]?@"":dict[@"adsText"];

model.randomOrder=[dict[@"randomOrder"] isKindOfClass:[NSNull class]]?0:[dict[@"randomOrder"] longLongValue];

model.privilegesLowestName=[dict[@"privilegesLowestName"] isKindOfClass:[NSNull class]]?@"":dict[@"privilegesLowestName"];

model.images=[dict[@"images"] isKindOfClass:[NSNull class]]?@"":dict[@"images"];

model.adsUrl=[dict[@"adsUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"adsUrl"];

model.isEnableMonitoring=[dict[@"isEnableMonitoring"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnableMonitoring"] intValue];

model.lng=[dict[@"lng"] isKindOfClass:[NSNull class]]?0:[dict[@"lng"] doubleValue];

model.productId=[dict[@"productId"] isKindOfClass:[NSNull class]]?0:[dict[@"productId"] longLongValue];

model.longVideoClassifyTwo=[dict[@"longVideoClassifyTwo"] isKindOfClass:[NSNull class]]?0:[dict[@"longVideoClassifyTwo"] longLongValue];

model.adsBannerList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"adsBannerList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShortVideoAdsVOModel* sumMdl=[ShortVideoAdsVOModel getFromDict:subDic];
[model.adsBannerList addObject:sumMdl];

}
}

}

model.isAttention=[dict[@"isAttention"] isKindOfClass:[NSNull class]]?0:[dict[@"isAttention"] intValue];

model.shortVideoTrialTime=[dict[@"shortVideoTrialTime"] isKindOfClass:[NSNull class]]?0:[dict[@"shortVideoTrialTime"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];

model.virtualOrNot=[dict[@"virtualOrNot"] isKindOfClass:[NSNull class]]?0:[dict[@"virtualOrNot"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.isLike=[dict[@"isLike"] isKindOfClass:[NSNull class]]?0:[dict[@"isLike"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.adsTitle=[dict[@"adsTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"adsTitle"];

model.isPrivate=[dict[@"isPrivate"] isKindOfClass:[NSNull class]]?0:[dict[@"isPrivate"] intValue];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.adsTemplateId=[dict[@"adsTemplateId"] isKindOfClass:[NSNull class]]?0:[dict[@"adsTemplateId"] longLongValue];

model.videoUrl=[dict[@"videoUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"videoUrl"];

model.avatarAdsId1=[dict[@"avatarAdsId1"] isKindOfClass:[NSNull class]]?0:[dict[@"avatarAdsId1"] longLongValue];

model.adsType=[dict[@"adsType"] isKindOfClass:[NSNull class]]?0:[dict[@"adsType"] intValue];

model.importTemplateId=[dict[@"importTemplateId"] isKindOfClass:[NSNull class]]?0:[dict[@"importTemplateId"] longLongValue];

model.isdel=[dict[@"isdel"] isKindOfClass:[NSNull class]]?0:[dict[@"isdel"] intValue];

model.image5=[dict[@"image5"] isKindOfClass:[NSNull class]]?@"":dict[@"image5"];

model.image6=[dict[@"image6"] isKindOfClass:[NSNull class]]?@"":dict[@"image6"];

model.isEnableAdsTemplate=[dict[@"isEnableAdsTemplate"] isKindOfClass:[NSNull class]]?0:[dict[@"isEnableAdsTemplate"] intValue];

model.image3=[dict[@"image3"] isKindOfClass:[NSNull class]]?@"":dict[@"image3"];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.comments=[dict[@"comments"] isKindOfClass:[NSNull class]]?0:[dict[@"comments"] intValue];

model.image4=[dict[@"image4"] isKindOfClass:[NSNull class]]?@"":dict[@"image4"];

model.isPay=[dict[@"isPay"] isKindOfClass:[NSNull class]]?0:[dict[@"isPay"] intValue];

model.avatarAdsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"avatarAdsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ShortVideoAdsVOModel* sumMdl=[ShortVideoAdsVOModel getFromDict:subDic];
[model.avatarAdsList addObject:sumMdl];

}
}

}

model.avatarAdsId2=[dict[@"avatarAdsId2"] isKindOfClass:[NSNull class]]?0:[dict[@"avatarAdsId2"] longLongValue];

model.bannerAdsId3=[dict[@"bannerAdsId3"] isKindOfClass:[NSNull class]]?0:[dict[@"bannerAdsId3"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.avatarAdsId3=[dict[@"avatarAdsId3"] isKindOfClass:[NSNull class]]?0:[dict[@"avatarAdsId3"] longLongValue];

model.bannerAdsId1=[dict[@"bannerAdsId1"] isKindOfClass:[NSNull class]]?0:[dict[@"bannerAdsId1"] longLongValue];

model.image1=[dict[@"image1"] isKindOfClass:[NSNull class]]?@"":dict[@"image1"];

model.bannerAdsId2=[dict[@"bannerAdsId2"] isKindOfClass:[NSNull class]]?0:[dict[@"bannerAdsId2"] longLongValue];

model.image2=[dict[@"image2"] isKindOfClass:[NSNull class]]?@"":dict[@"image2"];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.width=[dict[@"width"] isKindOfClass:[NSNull class]]?0:[dict[@"width"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(ApiShortVideoDtoModel*) source target:(ApiShortVideoDtoModel*)target
{

target.longVideoClassifyOne=source.longVideoClassifyOne;

target.isRecommend=source.isRecommend;

target.fees=source.fees;

target.isEnableTemplate=source.isEnableTemplate;

target.classifyId=source.classifyId;

target.isLongVideo=source.isLongVideo;

target.type=source.type;

target.shareNum=source.shareNum;

target.productName=source.productName;

target.internalRecommended=source.internalRecommended;

target.number=source.number;

target.looks=source.looks;

target.isWeek=source.isWeek;

target.id_field=source.id_field;

target.videoTime=source.videoTime;

target.classifyName=source.classifyName;

target.lat=source.lat;

target.height=source.height;

target.likes=source.likes;

target.adsText=source.adsText;

target.randomOrder=source.randomOrder;

target.privilegesLowestName=source.privilegesLowestName;

target.images=source.images;

target.adsUrl=source.adsUrl;

target.isEnableMonitoring=source.isEnableMonitoring;

target.lng=source.lng;

target.productId=source.productId;

target.longVideoClassifyTwo=source.longVideoClassifyTwo;

        if(source.adsBannerList==nil)
        {
//            target.adsBannerList=nil;
        }else
        {
            target.adsBannerList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.adsBannerList.count;i++)
            {
		  [target.adsBannerList addObject:[[ShortVideoAdsVOModel alloc]init]];
            [ShortVideoAdsVOModel cloneObj:source.adsBannerList[i] target:target.adsBannerList[i]];
            }
        }


target.isAttention=source.isAttention;

target.shortVideoTrialTime=source.shortVideoTrialTime;

target.coin=source.coin;

target.status=source.status;

target.virtualOrNot=source.virtualOrNot;

target.role=source.role;

target.isLike=source.isLike;

target.city=source.city;

target.thumb=source.thumb;

target.adsTitle=source.adsTitle;

target.isPrivate=source.isPrivate;

target.content=source.content;

target.adsTemplateId=source.adsTemplateId;

target.videoUrl=source.videoUrl;

target.avatarAdsId1=source.avatarAdsId1;

target.adsType=source.adsType;

target.importTemplateId=source.importTemplateId;

target.isdel=source.isdel;

target.image5=source.image5;

target.image6=source.image6;

target.isEnableAdsTemplate=source.isEnableAdsTemplate;

target.image3=source.image3;

target.address=source.address;

target.comments=source.comments;

target.image4=source.image4;

target.isPay=source.isPay;

        if(source.avatarAdsList==nil)
        {
//            target.avatarAdsList=nil;
        }else
        {
            target.avatarAdsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.avatarAdsList.count;i++)
            {
		  [target.avatarAdsList addObject:[[ShortVideoAdsVOModel alloc]init]];
            [ShortVideoAdsVOModel cloneObj:source.avatarAdsList[i] target:target.avatarAdsList[i]];
            }
        }


target.avatarAdsId2=source.avatarAdsId2;

target.bannerAdsId3=source.bannerAdsId3;

target.avatar=source.avatar;

target.avatarAdsId3=source.avatarAdsId3;

target.bannerAdsId1=source.bannerAdsId1;

target.image1=source.image1;

target.bannerAdsId2=source.bannerAdsId2;

target.image2=source.image2;

target.userId=source.userId;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.addtime=source.addtime;

target.width=source.width;

target.username=source.username;

}

@end

