//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiCommentsMsgModel.h"




 @implementation ApiCommentsMsgModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"uid"]=@(_uid);

dict[@"role"]=@(_role);

dict[@"sourceType"]=@(_sourceType);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"isRead"]=@(_isRead);

dict[@"commentId"]=@(_commentId);

dict[@"videoId"]=@(_videoId);

dict[@"avatar"]=_avatar;

dict[@"type"]=@(_type);

dict[@"userName"]=_userName;

dict[@"content"]=_content;

dict[@"url"]=_url;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCommentsMsgModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiCommentsMsgModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiCommentsMsgModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiCommentsMsgModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiCommentsMsgModel* sumMdl=[ApiCommentsMsgModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiCommentsMsgModel*)getFromDict:(NSDictionary*)dict
{
ApiCommentsMsgModel* model=[[ApiCommentsMsgModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.sourceType=[dict[@"sourceType"] isKindOfClass:[NSNull class]]?0:[dict[@"sourceType"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.isRead=[dict[@"isRead"] isKindOfClass:[NSNull class]]?0:[dict[@"isRead"] intValue];

model.commentId=[dict[@"commentId"] isKindOfClass:[NSNull class]]?0:[dict[@"commentId"] longLongValue];

model.videoId=[dict[@"videoId"] isKindOfClass:[NSNull class]]?0:[dict[@"videoId"] longLongValue];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.url=[dict[@"url"] isKindOfClass:[NSNull class]]?@"":dict[@"url"];


 return model;
}

 +(void)cloneObj:(ApiCommentsMsgModel*) source target:(ApiCommentsMsgModel*)target
{

target.uid=source.uid;

target.role=source.role;

target.sourceType=source.sourceType;

target.addtime=source.addtime;

target.isRead=source.isRead;

target.commentId=source.commentId;

target.videoId=source.videoId;

target.avatar=source.avatar;

target.type=source.type;

target.userName=source.userName;

target.content=source.content;

target.url=source.url;

}

@end

