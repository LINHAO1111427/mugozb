//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppUsersCashAccountModel.h"




 @implementation AppUsersCashAccountModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"accountBank"]=_accountBank;

dict[@"uid"]=@(_uid);

dict[@"isDefault"]=@(_isDefault);

dict[@"addtime"]=[HttpClient stringFromDate:_addtime];

dict[@"name"]=_name;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);

dict[@"branch"]=_branch;

dict[@"account"]=_account;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersCashAccountModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppUsersCashAccountModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppUsersCashAccountModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppUsersCashAccountModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppUsersCashAccountModel* sumMdl=[AppUsersCashAccountModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppUsersCashAccountModel*)getFromDict:(NSDictionary*)dict
{
AppUsersCashAccountModel* model=[[AppUsersCashAccountModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.accountBank=[dict[@"accountBank"] isKindOfClass:[NSNull class]]?@"":dict[@"accountBank"];

model.uid=[dict[@"uid"] isKindOfClass:[NSNull class]]?0:[dict[@"uid"] longLongValue];

model.isDefault=[dict[@"isDefault"] isKindOfClass:[NSNull class]]?0:[dict[@"isDefault"] intValue];


{
NSString *strDate= dict[@"addtime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addtime=date;
    }
}

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.branch=[dict[@"branch"] isKindOfClass:[NSNull class]]?@"":dict[@"branch"];

model.account=[dict[@"account"] isKindOfClass:[NSNull class]]?@"":dict[@"account"];


 return model;
}

 +(void)cloneObj:(AppUsersCashAccountModel*) source target:(AppUsersCashAccountModel*)target
{

target.accountBank=source.accountBank;

target.uid=source.uid;

target.isDefault=source.isDefault;

target.addtime=source.addtime;

target.name=source.name;

target.id_field=source.id_field;

target.type=source.type;

target.branch=source.branch;

target.account=source.account;

}

@end

