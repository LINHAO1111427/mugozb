//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiPushChatDataModel.h"
#import "AppLiveChannelModel.h"
#import "AdminRushToTalkConfigModel.h"




 @implementation ApiPushChatDataModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"appLiveChannelList" : [AppLiveChannelModel class],@"coinList" : [AdminRushToTalkConfigModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_appLiveChannelList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiveChannelModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"appLiveChannelList"]=list;
}//end


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_coinList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AdminRushToTalkConfigModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"coinList"]=list;
}//end

dict[@"oooAskChat"]=_oooAskChat;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPushChatDataModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiPushChatDataModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiPushChatDataModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiPushChatDataModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiPushChatDataModel* sumMdl=[ApiPushChatDataModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiPushChatDataModel*)getFromDict:(NSDictionary*)dict
{
ApiPushChatDataModel* model=[[ApiPushChatDataModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.appLiveChannelList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"appLiveChannelList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveChannelModel* sumMdl=[AppLiveChannelModel getFromDict:subDic];
[model.appLiveChannelList addObject:sumMdl];

}
}

}

model.coinList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"coinList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AdminRushToTalkConfigModel* sumMdl=[AdminRushToTalkConfigModel getFromDict:subDic];
[model.coinList addObject:sumMdl];

}
}

}

model.oooAskChat=[dict[@"oooAskChat"] isKindOfClass:[NSNull class]]?@"":dict[@"oooAskChat"];


 return model;
}

 +(void)cloneObj:(ApiPushChatDataModel*) source target:(ApiPushChatDataModel*)target
{

        if(source.appLiveChannelList==nil)
        {
//            target.appLiveChannelList=nil;
        }else
        {
            target.appLiveChannelList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.appLiveChannelList.count;i++)
            {
		  [target.appLiveChannelList addObject:[[AppLiveChannelModel alloc]init]];
            [AppLiveChannelModel cloneObj:source.appLiveChannelList[i] target:target.appLiveChannelList[i]];
            }
        }


        if(source.coinList==nil)
        {
//            target.coinList=nil;
        }else
        {
            target.coinList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.coinList.count;i++)
            {
		  [target.coinList addObject:[[AdminRushToTalkConfigModel alloc]init]];
            [AdminRushToTalkConfigModel cloneObj:source.coinList[i] target:target.coinList[i]];
            }
        }


target.oooAskChat=source.oooAskChat;

}

@end

