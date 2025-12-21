//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "MeetPostsVOModel.h"




 @implementation MeetPostsVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"multiplayerRule"]=_multiplayerRule;

dict[@"oooSpeedDating"]=_oooSpeedDating;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MeetPostsVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
MeetPostsVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<MeetPostsVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<MeetPostsVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
MeetPostsVOModel* sumMdl=[MeetPostsVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(MeetPostsVOModel*)getFromDict:(NSDictionary*)dict
{
MeetPostsVOModel* model=[[MeetPostsVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.multiplayerRule=[dict[@"multiplayerRule"] isKindOfClass:[NSNull class]]?@"":dict[@"multiplayerRule"];

model.oooSpeedDating=[dict[@"oooSpeedDating"] isKindOfClass:[NSNull class]]?@"":dict[@"oooSpeedDating"];


 return model;
}

 +(void)cloneObj:(MeetPostsVOModel*) source target:(MeetPostsVOModel*)target
{

target.multiplayerRule=source.multiplayerRule;

target.oooSpeedDating=source.oooSpeedDating;

}

@end

