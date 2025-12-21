//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AnchorVotesDTOModel.h"




 @implementation AnchorVotesDTOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"anchorVotes"]=@(_anchorVotes);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorVotesDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AnchorVotesDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AnchorVotesDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AnchorVotesDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AnchorVotesDTOModel* sumMdl=[AnchorVotesDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AnchorVotesDTOModel*)getFromDict:(NSDictionary*)dict
{
AnchorVotesDTOModel* model=[[AnchorVotesDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.anchorVotes=[dict[@"anchorVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorVotes"] doubleValue];


 return model;
}

 +(void)cloneObj:(AnchorVotesDTOModel*) source target:(AnchorVotesDTOModel*)target
{

target.anchorVotes=source.anchorVotes;

}

@end

