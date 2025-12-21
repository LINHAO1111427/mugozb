//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OooLiveConfigVOModel.h"




 @implementation OooLiveConfigVOModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"isComment"]=@(_isComment);

dict[@"takeAnchorContact"]=@(_takeAnchorContact);

dict[@"chatRoomAnchorContact"]=@(_chatRoomAnchorContact);

dict[@"homePageSwitch"]=@(_homePageSwitch);

dict[@"id"]=@(_id_field);

dict[@"homeAnchorContact"]=@(_homeAnchorContact);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooLiveConfigVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OooLiveConfigVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OooLiveConfigVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OooLiveConfigVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OooLiveConfigVOModel* sumMdl=[OooLiveConfigVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OooLiveConfigVOModel*)getFromDict:(NSDictionary*)dict
{
OooLiveConfigVOModel* model=[[OooLiveConfigVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.isComment=[dict[@"isComment"] isKindOfClass:[NSNull class]]?0:[dict[@"isComment"] intValue];

model.takeAnchorContact=[dict[@"takeAnchorContact"] isKindOfClass:[NSNull class]]?0:[dict[@"takeAnchorContact"] intValue];

model.chatRoomAnchorContact=[dict[@"chatRoomAnchorContact"] isKindOfClass:[NSNull class]]?0:[dict[@"chatRoomAnchorContact"] intValue];

model.homePageSwitch=[dict[@"homePageSwitch"] isKindOfClass:[NSNull class]]?0:[dict[@"homePageSwitch"] intValue];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.homeAnchorContact=[dict[@"homeAnchorContact"] isKindOfClass:[NSNull class]]?0:[dict[@"homeAnchorContact"] intValue];


 return model;
}

 +(void)cloneObj:(OooLiveConfigVOModel*) source target:(OooLiveConfigVOModel*)target
{

target.isComment=source.isComment;

target.takeAnchorContact=source.takeAnchorContact;

target.chatRoomAnchorContact=source.chatRoomAnchorContact;

target.homePageSwitch=source.homePageSwitch;

target.id_field=source.id_field;

target.homeAnchorContact=source.homeAnchorContact;

}

@end

