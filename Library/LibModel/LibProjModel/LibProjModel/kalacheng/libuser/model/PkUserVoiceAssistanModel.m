//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "PkUserVoiceAssistanModel.h"
#import "ApiUsersVoiceAssistanModel.h"




 @implementation PkUserVoiceAssistanModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"usersVoiceAssistan" : [ApiUsersVoiceAssistanModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"usersVoiceAssistan"]=[_usersVoiceAssistan modelToJSONObject];

dict[@"giftVotes"]=@(_giftVotes);

dict[@"pkNo"]=@(_pkNo);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<PkUserVoiceAssistanModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
PkUserVoiceAssistanModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<PkUserVoiceAssistanModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<PkUserVoiceAssistanModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
PkUserVoiceAssistanModel* sumMdl=[PkUserVoiceAssistanModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(PkUserVoiceAssistanModel*)getFromDict:(NSDictionary*)dict
{
PkUserVoiceAssistanModel* model=[[PkUserVoiceAssistanModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

//getFromDict对象转换  
model.usersVoiceAssistan=[ApiUsersVoiceAssistanModel getFromDict:dict[@"usersVoiceAssistan"]];

model.giftVotes=[dict[@"giftVotes"] isKindOfClass:[NSNull class]]?0:[dict[@"giftVotes"] doubleValue];

model.pkNo=[dict[@"pkNo"] isKindOfClass:[NSNull class]]?0:[dict[@"pkNo"] intValue];


 return model;
}

 +(void)cloneObj:(PkUserVoiceAssistanModel*) source target:(PkUserVoiceAssistanModel*)target
{
        if(source.usersVoiceAssistan==nil)
        {
//            target.usersVoiceAssistan=nil;
        }else
        {
            [ApiUsersVoiceAssistanModel cloneObj:source.usersVoiceAssistan target:target.usersVoiceAssistan];
        }

target.giftVotes=source.giftVotes;

target.pkNo=source.pkNo;

}

@end

