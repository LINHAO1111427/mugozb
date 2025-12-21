//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUsersAuthModel.h"




 @implementation AppUsersAuthModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"qq"]=_qq;

dict[@"starId"]=@(_starId);

dict[@"other3View"]=_other3View;

dict[@"reason"]=_reason;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"backView"]=_backView;

dict[@"mobile"]=_mobile;

dict[@"pidLevel2"]=@(_pidLevel2);

dict[@"wechat"]=_wechat;

dict[@"pidLevel1"]=@(_pidLevel1);

dict[@"pidLevel4"]=@(_pidLevel4);

dict[@"other1View"]=_other1View;

dict[@"pidLevel3"]=@(_pidLevel3);

dict[@"uptime"]=[HttpClient stringFromDate:_uptime];

dict[@"frontView"]=_frontView;

dict[@"realName"]=_realName;

dict[@"uid"]=@(_uid);

dict[@"cerNo"]=_cerNo;

dict[@"handsetView"]=_handsetView;

dict[@"videoUrl"]=_videoUrl;

dict[@"step"]=@(_step);

dict[@"other2View"]=_other2View;

dict[@"extraInfo"]=_extraInfo;

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersAuthModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUsersAuthModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUsersAuthModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUsersAuthModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersAuthModel* sumMdl=[AppUsersAuthModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUsersAuthModel*)getFromDict:(NSDictionary*)dict
{
AppUsersAuthModel* model=[[AppUsersAuthModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.qq=[dict[@"qq"] isKindOfClass:[NSNull class]]?@"":dict[@"qq"];

model.starId=[dict[@"starId"] isKindOfClass:[NSNull class]]?0:[dict[@"starId"] longLongValue];

model.other3View=[dict[@"other3View"] isKindOfClass:[NSNull class]]?@"":dict[@"other3View"];

model.reason=[dict[@"reason"] isKindOfClass:[NSNull class]]?@"":dict[@"reason"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.backView=[dict[@"backView"] isKindOfClass:[NSNull class]]?@"":dict[@"backView"];

model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.pidLevel2=[dict[@"pidLevel2"] isKindOfClass:[NSNull class]]?0:[dict[@"pidLevel2"] intValue];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.pidLevel1=[dict[@"pidLevel1"] isKindOfClass:[NSNull class]]?0:[dict[@"pidLevel1"] intValue];

model.pidLevel4=[dict[@"pidLevel4"] isKindOfClass:[NSNull class]]?0:[dict[@"pidLevel4"] intValue];

model.other1View=[dict[@"other1View"] isKindOfClass:[NSNull class]]?@"":dict[@"other1View"];

model.pidLevel3=[dict[@"pidLevel3"] isKindOfClass:[NSNull class]]?0:[dict[@"pidLevel3"] intValue];


{
NSString *strDate= dict[@"uptime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.uptime=date;
    }
}

model.frontView=[dict[@"frontView"] isKindOfClass:[NSNull class]]?@"":dict[@"frontView"];

model.realName=[dict[@"realName"] isKindOfClass:[NSNull class]]?@"":dict[@"realName"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.cerNo=[dict[@"cerNo"] isKindOfClass:[NSNull class]]?@"":dict[@"cerNo"];

model.handsetView=[dict[@"handsetView"] isKindOfClass:[NSNull class]]?@"":dict[@"handsetView"];

model.videoUrl=[dict[@"videoUrl"] isKindOfClass:[NSNull class]]?@"":dict[@"videoUrl"];

model.step=[dict[@"step"] isKindOfClass:[NSNull class]]?0:[dict[@"step"] intValue];

model.other2View=[dict[@"other2View"] isKindOfClass:[NSNull class]]?@"":dict[@"other2View"];

model.extraInfo=[dict[@"extraInfo"] isKindOfClass:[NSNull class]]?@"":dict[@"extraInfo"];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppUsersAuthModel*) source target:(AppUsersAuthModel*)target
{

target.qq=source.qq;

target.starId=source.starId;

target.other3View=source.other3View;

target.reason=source.reason;

target.addTime=source.addTime;

target.backView=source.backView;

target.mobile=source.mobile;

target.pidLevel2=source.pidLevel2;

target.wechat=source.wechat;

target.pidLevel1=source.pidLevel1;

target.pidLevel4=source.pidLevel4;

target.other1View=source.other1View;

target.pidLevel3=source.pidLevel3;

target.uptime=source.uptime;

target.frontView=source.frontView;

target.realName=source.realName;

target.uid=source.uid;

target.cerNo=source.cerNo;

target.handsetView=source.handsetView;

target.videoUrl=source.videoUrl;

target.step=source.step;

target.other2View=source.other2View;

target.extraInfo=source.extraInfo;

target.status=source.status;

}

@end

