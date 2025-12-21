//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiShortVideoCommentsModel.h"
#import "ApiShortVideoCommentsModel.h"




 @implementation ApiShortVideoCommentsModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"replyList" : [ApiShortVideoCommentsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"addtimeStr"]=_addtimeStr;

dict[@"uid"]=@(_uid);

dict[@"toUid"]=@(_toUid);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"commentType"]=@(_commentType);

dict[@"commentid"]=@(_commentid);

dict[@"toUserName"]=_toUserName;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_replyList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiShortVideoCommentsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"replyList"]=list;
}//end

dict[@"avatar"]=_avatar;

dict[@"userName"]=_userName;

dict[@"content"]=_content;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShortVideoCommentsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiShortVideoCommentsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiShortVideoCommentsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiShortVideoCommentsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoCommentsModel* sumMdl=[ApiShortVideoCommentsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiShortVideoCommentsModel*)getFromDict:(NSDictionary*)dict
{
ApiShortVideoCommentsModel* model=[[ApiShortVideoCommentsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.addtimeStr=[dict[@"addtimeStr"] isKindOfClass:[NSNull class]]?@"":dict[@"addtimeStr"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.toUid=[dict[@"toUid"] isKindOfClass:[NSNull class]]?0:[dict[@"toUid"] longLongValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.commentType=[dict[@"commentType"] isKindOfClass:[NSNull class]]?0:[dict[@"commentType"] intValue];

model.commentid=[dict[@"commentid"] isKindOfClass:[NSNull class]]?0:[dict[@"commentid"] longLongValue];

model.toUserName=[dict[@"toUserName"] isKindOfClass:[NSNull class]]?@"":dict[@"toUserName"];

model.replyList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"replyList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiShortVideoCommentsModel* sumMdl=[ApiShortVideoCommentsModel getFromDict:subDic];
[model.replyList addObject:sumMdl];

}
}

}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];


 return model;
}

 +(void)cloneObj:(ApiShortVideoCommentsModel*) source target:(ApiShortVideoCommentsModel*)target
{

target.addtimeStr=source.addtimeStr;

target.uid=source.uid;

target.toUid=source.toUid;

target.addtime=source.addtime;

target.commentType=source.commentType;

target.commentid=source.commentid;

target.toUserName=source.toUserName;

        if(source.replyList==nil)
        {
//            target.replyList=nil;
        }else
        {
            target.replyList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.replyList.count;i++)
            {
		  [target.replyList addObject:[[ApiShortVideoCommentsModel alloc]init]];
            [ApiShortVideoCommentsModel cloneObj:source.replyList[i] target:target.replyList[i]];
            }
        }


target.avatar=source.avatar;

target.userName=source.userName;

target.content=source.content;

}

@end

