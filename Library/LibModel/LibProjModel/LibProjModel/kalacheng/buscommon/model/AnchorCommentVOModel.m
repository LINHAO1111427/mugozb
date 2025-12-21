//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AnchorCommentVOModel.h"
#import "CommentLableVOModel.h"




 @implementation AnchorCommentVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"commentList" : [CommentLableVOModel class]};
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
CommentLableVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"commentList"]=list;
}//end

dict[@"tableInfoIds"]=_tableInfoIds;

dict[@"avatar"]=_avatar;

dict[@"userid"]=@(_userid);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorCommentVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AnchorCommentVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AnchorCommentVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AnchorCommentVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorCommentVOModel* sumMdl=[AnchorCommentVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AnchorCommentVOModel*)getFromDict:(NSDictionary*)dict
{
AnchorCommentVOModel* model=[[AnchorCommentVOModel alloc]init];

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
CommentLableVOModel* sumMdl=[CommentLableVOModel getFromDict:subDic];
[model.commentList addObject:sumMdl];

}
}

}

model.tableInfoIds=[dict[@"tableInfoIds"] isKindOfClass:[NSNull class]]?@"":dict[@"tableInfoIds"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.userid=[dict[@"userid"] isKindOfClass:[NSNull class]]?0:[dict[@"userid"] longLongValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(AnchorCommentVOModel*) source target:(AnchorCommentVOModel*)target
{

        if(source.commentList==nil)
        {
//            target.commentList=nil;
        }else
        {
            target.commentList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.commentList.count;i++)
            {
		  [target.commentList addObject:[[CommentLableVOModel alloc]init]];
            [CommentLableVOModel cloneObj:source.commentList[i] target:target.commentList[i]];
            }
        }


target.tableInfoIds=source.tableInfoIds;

target.avatar=source.avatar;

target.userid=source.userid;

target.username=source.username;

}

@end

