//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppPostsModel.h"




 @implementation AppPostsModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"upTime"]=[HttpClient stringFromDate:_upTime];

dict[@"createtime"]=[HttpClient stringFromDate:_createtime];

dict[@"postExcerpt"]=_postExcerpt;

dict[@"postType"]=@(_postType);

dict[@"postTitle"]=_postTitle;

dict[@"id"]=@(_id_field);

dict[@"isUseLicense"]=@(_isUseLicense);

dict[@"status"]=@(_status);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPostsModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppPostsModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppPostsModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppPostsModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppPostsModel* sumMdl=[AppPostsModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppPostsModel*)getFromDict:(NSDictionary*)dict
{
AppPostsModel* model=[[AppPostsModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }

{
NSString *strDate= dict[@"upTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.upTime=date;
    }
}


{
NSString *strDate= dict[@"createtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.createtime=date;
    }
}

model.postExcerpt=[dict[@"postExcerpt"] isKindOfClass:[NSNull class]]?@"":dict[@"postExcerpt"];

model.postType=[dict[@"postType"] isKindOfClass:[NSNull class]]?0:[dict[@"postType"] intValue];

model.postTitle=[dict[@"postTitle"] isKindOfClass:[NSNull class]]?@"":dict[@"postTitle"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.isUseLicense=[dict[@"isUseLicense"] isKindOfClass:[NSNull class]]?0:[dict[@"isUseLicense"] intValue];

model.status=[dict[@"status"] isKindOfClass:[NSNull class]]?0:[dict[@"status"] intValue];


 return model;
}

 +(void)cloneObj:(AppPostsModel*) source target:(AppPostsModel*)target
{

target.upTime=source.upTime;

target.createtime=source.createtime;

target.postExcerpt=source.postExcerpt;

target.postType=source.postType;

target.postTitle=source.postTitle;

target.id_field=source.id_field;

target.isUseLicense=source.isUseLicense;

target.status=source.status;

}

@end

