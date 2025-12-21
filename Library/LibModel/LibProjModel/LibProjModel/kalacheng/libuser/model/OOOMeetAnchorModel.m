//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OOOMeetAnchorModel.h"
#import "OOOLiveRoomNoAnswerDtoModel.h"
#import "ApiUserInfoOOOReqModel.h"




 @implementation OOOMeetAnchorModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"noAnswerUserList" : [OOOLiveRoomNoAnswerDtoModel class],@"matchingUserList" : [ApiUserInfoOOOReqModel class],@"reqUserList" : [ApiUserInfoOOOReqModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_noAnswerUserList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
OOOLiveRoomNoAnswerDtoModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"noAnswerUserList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_matchingUserList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserInfoOOOReqModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"matchingUserList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_reqUserList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserInfoOOOReqModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"reqUserList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOMeetAnchorModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OOOMeetAnchorModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OOOMeetAnchorModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OOOMeetAnchorModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOMeetAnchorModel* sumMdl=[OOOMeetAnchorModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OOOMeetAnchorModel*)getFromDict:(NSDictionary*)dict
{
OOOMeetAnchorModel* model=[[OOOMeetAnchorModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.noAnswerUserList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"noAnswerUserList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OOOLiveRoomNoAnswerDtoModel* sumMdl=[OOOLiveRoomNoAnswerDtoModel getFromDict:subDic];
[model.noAnswerUserList addObject:sumMdl];

}
}

}

model.matchingUserList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"matchingUserList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoOOOReqModel* sumMdl=[ApiUserInfoOOOReqModel getFromDict:subDic];
[model.matchingUserList addObject:sumMdl];

}
}

}

model.reqUserList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"reqUserList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserInfoOOOReqModel* sumMdl=[ApiUserInfoOOOReqModel getFromDict:subDic];
[model.reqUserList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(OOOMeetAnchorModel*) source target:(OOOMeetAnchorModel*)target
{

        if(source.noAnswerUserList==nil)
        {
//            target.noAnswerUserList=nil;
        }else
        {
            target.noAnswerUserList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.noAnswerUserList.count;i++)
            {
		  [target.noAnswerUserList addObject:[[OOOLiveRoomNoAnswerDtoModel alloc]init]];
            [OOOLiveRoomNoAnswerDtoModel cloneObj:source.noAnswerUserList[i] target:target.noAnswerUserList[i]];
            }
        }


        if(source.matchingUserList==nil)
        {
//            target.matchingUserList=nil;
        }else
        {
            target.matchingUserList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.matchingUserList.count;i++)
            {
		  [target.matchingUserList addObject:[[ApiUserInfoOOOReqModel alloc]init]];
            [ApiUserInfoOOOReqModel cloneObj:source.matchingUserList[i] target:target.matchingUserList[i]];
            }
        }


        if(source.reqUserList==nil)
        {
//            target.reqUserList=nil;
        }else
        {
            target.reqUserList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.reqUserList.count;i++)
            {
		  [target.reqUserList addObject:[[ApiUserInfoOOOReqModel alloc]init]];
            [ApiUserInfoOOOReqModel cloneObj:source.reqUserList[i] target:target.reqUserList[i]];
            }
        }


}

@end

