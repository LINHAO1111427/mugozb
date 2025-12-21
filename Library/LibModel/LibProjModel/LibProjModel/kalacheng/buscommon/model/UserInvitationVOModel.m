//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "UserInvitationVOModel.h"




 @implementation UserInvitationVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"totalAmount"]=@(_totalAmount);

dict[@"totalCharge"]=@(_totalCharge);

dict[@"createTime"]=[HttpClient stringFromDate:_createTime];

dict[@"avatar"]=_avatar;

dict[@"totalTicket"]=@(_totalTicket);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInvitationVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
UserInvitationVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<UserInvitationVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<UserInvitationVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
UserInvitationVOModel* sumMdl=[UserInvitationVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(UserInvitationVOModel*)getFromDict:(NSDictionary*)dict
{
UserInvitationVOModel* model=[[UserInvitationVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.totalAmount=[dict[@"totalAmount"] isKindOfClass:[NSNull class]]?0:[dict[@"totalAmount"] doubleValue];

model.totalCharge=[dict[@"totalCharge"] isKindOfClass:[NSNull class]]?0:[dict[@"totalCharge"] doubleValue];


{
NSString *strDate= dict[@"createTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createTime=date;
    }
}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.totalTicket=[dict[@"totalTicket"] isKindOfClass:[NSNull class]]?0:[dict[@"totalTicket"] doubleValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(UserInvitationVOModel*) source target:(UserInvitationVOModel*)target
{

target.totalAmount=source.totalAmount;

target.totalCharge=source.totalCharge;

target.createTime=source.createTime;

target.avatar=source.avatar;

target.totalTicket=source.totalTicket;

target.username=source.username;

}

@end

