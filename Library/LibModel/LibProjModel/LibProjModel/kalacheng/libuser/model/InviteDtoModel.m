//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "InviteDtoModel.h"
#import "AppInviteImgModel.h"
#import "KeyValueDtoModel.h"




 @implementation InviteDtoModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"shareBackgroundImgList" : [AppInviteImgModel class],@"wxInvite" : [KeyValueDtoModel class],@"shareImg" : [KeyValueDtoModel class],@"qqInvite" : [KeyValueDtoModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_shareBackgroundImgList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppInviteImgModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"shareBackgroundImgList"]=list;
}//end

dict[@"amount"]=@(_amount);

dict[@"titleImg"]=_titleImg;

dict[@"code"]=_code;

dict[@"msg1"]=_msg1;

dict[@"wxInvite"]=[_wxInvite modelToJSONObject];

dict[@"inviteRule"]=_inviteRule;

dict[@"shareImg"]=[_shareImg modelToJSONObject];

dict[@"totalAmount"]=@(_totalAmount);

dict[@"backgroundImg"]=_backgroundImg;

dict[@"qqInvite"]=[_qqInvite modelToJSONObject];

dict[@"inviteUrl"]=_inviteUrl;

dict[@"totalCash"]=@(_totalCash);

dict[@"inviteUserNum"]=@(_inviteUserNum);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<InviteDtoModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
InviteDtoModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<InviteDtoModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<InviteDtoModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
InviteDtoModel* sumMdl=[InviteDtoModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(InviteDtoModel*)getFromDict:(NSDictionary*)dict
{
InviteDtoModel* model=[[InviteDtoModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.shareBackgroundImgList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"shareBackgroundImgList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppInviteImgModel* sumMdl=[AppInviteImgModel getFromDict:subDic];
[model.shareBackgroundImgList addObject:sumMdl];

}
}

}

model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.titleImg=[dict[@"titleImg"] isKindOfClass:[NSNull class]]?@"":dict[@"titleImg"];

model.code=[dict[@"code"] isKindOfClass:[NSNull class]]?@"":dict[@"code"];

model.msg1=[dict[@"msg1"] isKindOfClass:[NSNull class]]?@"":dict[@"msg1"];


//getFromDict对象转换  
model.wxInvite=[KeyValueDtoModel getFromDict:dict[@"wxInvite"]];

model.inviteRule=[dict[@"inviteRule"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteRule"];


//getFromDict对象转换  
model.shareImg=[KeyValueDtoModel getFromDict:dict[@"shareImg"]];

model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.backgroundImg=[dict[@"backgroundImg"] isKindOfClass:[NSNull class]]?@"":dict[@"backgroundImg"];


//getFromDict对象转换  
model.qqInvite=[KeyValueDtoModel getFromDict:dict[@"qqInvite"]];

model.inviteUrl=[dict[@"inviteUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"inviteUrl"];

model.totalCash=[dict[@"totalCash"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCash"] doubleValue];

model.inviteUserNum=[dict[@"inviteUserNum"] isKindOfClass:[NSNull class]]?0:[dict[@"inviteUserNum"] intValue];


 return model;
}

 +(void)cloneObj:(InviteDtoModel*) source target:(InviteDtoModel*)target
{

        if(source.shareBackgroundImgList==nil)
        {
//            target.shareBackgroundImgList=nil;
        }else
        {
            target.shareBackgroundImgList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.shareBackgroundImgList.count;i++)
            {
		  [target.shareBackgroundImgList addObject:[[AppInviteImgModel alloc]init]];
            [AppInviteImgModel cloneObj:source.shareBackgroundImgList[i] target:target.shareBackgroundImgList[i]];
            }
        }


target.amount=source.amount;

target.titleImg=source.titleImg;

target.code=source.code;

target.msg1=source.msg1;
        if(source.wxInvite==nil)
        {
//            target.wxInvite=nil;
        }else
        {
            [KeyValueDtoModel cloneObj:source.wxInvite target:target.wxInvite];
        }

target.inviteRule=source.inviteRule;
        if(source.shareImg==nil)
        {
//            target.shareImg=nil;
        }else
        {
            [KeyValueDtoModel cloneObj:source.shareImg target:target.shareImg];
        }

target.totalAmount=source.totalAmount;

target.backgroundImg=source.backgroundImg;
        if(source.qqInvite==nil)
        {
//            target.qqInvite=nil;
        }else
        {
            [KeyValueDtoModel cloneObj:source.qqInvite target:target.qqInvite];
        }

target.inviteUrl=source.inviteUrl;

target.totalCash=source.totalCash;

target.inviteUserNum=source.inviteUserNum;

}

@end

