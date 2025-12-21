//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserVideoModel.h"
#import "ApiUsersVideoCommentsModel.h"




 @implementation ApiUserVideoModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"commentList" : [ApiUsersVideoCommentsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_commentList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUsersVideoCommentsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"commentList"]=list;
}//end

dict[@"msg"]=_msg;

dict[@"code"]=@(_code);

dict[@"role"]=@(_role);

dict[@"distance"]=@(_distance);

dict[@"isLike"]=@(_isLike);

dict[@"city"]=_city;

dict[@"thumb"]=_thumb;

dict[@"collectNum"]=@(_collectNum);

dict[@"hidePublishingAddress"]=@(_hidePublishingAddress);

dict[@"isPrivate"]=@(_isPrivate);

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"content"]=_content;

dict[@"personalTop"]=@(_personalTop);

dict[@"addtimeStr"]=_addtimeStr;

dict[@"shares"]=@(_shares);

dict[@"uid"]=@(_uid);

dict[@"musicId"]=@(_musicId);

dict[@"href"]=_href;

dict[@"id"]=@(_id_field);

dict[@"videoTime"]=_videoTime;

dict[@"views"]=@(_views);

dict[@"height"]=@(_height);

dict[@"likes"]=@(_likes);

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"images"]=_images;

dict[@"address"]=_address;

dict[@"comments"]=@(_comments);

dict[@"sex"]=@(_sex);

dict[@"isCollect"]=@(_isCollect);

dict[@"avatar"]=_avatar;

dict[@"isAtt"]=@(_isAtt);

dict[@"userName"]=_userName;

dict[@"steps"]=@(_steps);

dict[@"isVip"]=@(_isVip);

dict[@"isShares"]=@(_isShares);

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"topicId"]=@(_topicId);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"width"]=@(_width);

dict[@"gradeImg"]=_gradeImg;

dict[@"topicName"]=_topicName;

dict[@"poster"]=_poster;

dict[@"age"]=@(_age);

dict[@"coin"]=@(_coin);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserVideoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserVideoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserVideoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserVideoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserVideoModel* sumMdl=[ApiUserVideoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserVideoModel*)getFromDict:(NSDictionary*)dict
{
ApiUserVideoModel* model=[[ApiUserVideoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.commentList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"commentList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUsersVideoCommentsModel* sumMdl=[ApiUsersVideoCommentsModel getFromDict:subDic];
[model.commentList addObject:sumMdl];

}
}

}

model.msg=[dict[@"msg"] isKindOfClass:[NSNull class]]?@"":dict[@"msg"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?0:[dict[@"code"] intValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.distance=[dict[@"distance"] isKindOfClass:[NSNull class]]?0:[dict[@"distance"] doubleValue];

model.isLike=[dict[@"isLike"] isKindOfClass:[NSNull class]]?0:[dict[@"isLike"] intValue];

model.city=[dict[@"city"] isKindOfClass:[NSNull class]]?@"":dict[@"city"];

model.thumb=[dict[@"thumb"] isKindOfClass:[NSNull class]]?@"":dict[@"thumb"];

model.collectNum=[dict[@"collectNum"] isKindOfClass:[NSNull class]]?0:[dict[@"collectNum"] intValue];

model.hidePublishingAddress=[dict[@"hidePublishingAddress"] isKindOfClass:[NSNull class]]?0:[dict[@"hidePublishingAddress"] intValue];

model.isPrivate=[dict[@"isPrivate"] isKindOfClass:[NSNull class]]?0:[dict[@"isPrivate"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.personalTop=[dict[@"personalTop"] isKindOfClass:[NSNull class]]?0:[dict[@"personalTop"] intValue];

model.addtimeStr=[dict[@"addtimeStr"] isKindOfClass:[NSNull class]]?@"":dict[@"addtimeStr"];

model.shares=[dict[@"shares"] isKindOfClass:[NSNull class]]?0:[dict[@"shares"] intValue];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.musicId=[dict[@"musicId"] isKindOfClass:[NSNull class]]?0:[dict[@"musicId"] intValue];

model.href=[dict[@"href"] isKindOfClass:[NSNull class]]?@"":dict[@"href"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] intValue];

model.videoTime=[dict[@"videoTime"] isKindOfClass:[NSNull class]]?@"":dict[@"videoTime"];

model.views=[dict[@"views"] isKindOfClass:[NSNull class]]?0:[dict[@"views"] intValue];

model.height=[dict[@"height"] isKindOfClass:[NSNull class]]?0:[dict[@"height"] intValue];

model.likes=[dict[@"likes"] isKindOfClass:[NSNull class]]?0:[dict[@"likes"] intValue];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.images=[dict[@"images"] isKindOfClass:[NSNull class]]?@"":dict[@"images"];

model.address=[dict[@"address"] isKindOfClass:[NSNull class]]?@"":dict[@"address"];

model.comments=[dict[@"comments"] isKindOfClass:[NSNull class]]?0:[dict[@"comments"] intValue];

model.sex=[dict[@"sex"] isKindOfClass:[NSNull class]]?0:[dict[@"sex"] intValue];

model.isCollect=[dict[@"isCollect"] isKindOfClass:[NSNull class]]?0:[dict[@"isCollect"] intValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.isAtt=[dict[@"isAtt"] isKindOfClass:[NSNull class]]?0:[dict[@"isAtt"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.steps=[dict[@"steps"] isKindOfClass:[NSNull class]]?0:[dict[@"steps"] intValue];

model.isVip=[dict[@"isVip"] isKindOfClass:[NSNull class]]?0:[dict[@"isVip"] intValue];

model.isShares=[dict[@"isShares"] isKindOfClass:[NSNull class]]?0:[dict[@"isShares"] intValue];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.topicId=[dict[@"topicId"] isKindOfClass:[NSNull class]]?0:[dict[@"topicId"] longLongValue];


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

model.gradeImg=[dict[@"gradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"gradeImg"];

model.topicName=[dict[@"topicName"] isKindOfClass:[NSNull class]]?@"":dict[@"topicName"];

model.poster=[dict[@"poster"] isKindOfClass:[NSNull class]]?@"":dict[@"poster"];

model.age=[dict[@"age"] isKindOfClass:[NSNull class]]?0:[dict[@"age"] intValue];

model.coin=[dict[@"coin"] isKindOfClass:[NSNull class]]?0:[dict[@"coin"] doubleValue];


 return model;
}

 +(void)cloneObj:(ApiUserVideoModel*) source target:(ApiUserVideoModel*)target
{

        if(source.commentList==nil)
        {
//            target.commentList=nil;
        }else
        {
            target.commentList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.commentList.count;i++)
            {
		  [target.commentList addObject:[[ApiUsersVideoCommentsModel alloc]init]];
            [ApiUsersVideoCommentsModel cloneObj:source.commentList[i] target:target.commentList[i]];
            }
        }


target.msg=source.msg;

target.code=source.code;

target.role=source.role;

target.distance=source.distance;

target.isLike=source.isLike;

target.city=source.city;

target.thumb=source.thumb;

target.collectNum=source.collectNum;

target.hidePublishingAddress=source.hidePublishingAddress;

target.isPrivate=source.isPrivate;

target.title=source.title;

target.type=source.type;

target.nobleGradeImg=source.nobleGradeImg;

target.content=source.content;

target.personalTop=source.personalTop;

target.addtimeStr=source.addtimeStr;

target.shares=source.shares;

target.uid=source.uid;

target.musicId=source.musicId;

target.href=source.href;

target.id_field=source.id_field;

target.videoTime=source.videoTime;

target.views=source.views;

target.height=source.height;

target.likes=source.likes;

target.wealthGradeImg=source.wealthGradeImg;

target.images=source.images;

target.address=source.address;

target.comments=source.comments;

target.sex=source.sex;

target.isCollect=source.isCollect;

target.avatar=source.avatar;

target.isAtt=source.isAtt;

target.userName=source.userName;

target.steps=source.steps;

target.isVip=source.isVip;

target.isShares=source.isShares;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.topicId=source.topicId;

target.addtime=source.addtime;

target.width=source.width;

target.gradeImg=source.gradeImg;

target.topicName=source.topicName;

target.poster=source.poster;

target.age=source.age;

target.coin=source.coin;

}

@end

