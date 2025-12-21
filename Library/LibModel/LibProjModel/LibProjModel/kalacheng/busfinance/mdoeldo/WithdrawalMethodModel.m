//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "WithdrawalMethodModel.h"




 @implementation WithdrawalMethodModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"haveAliPay"]=@(_haveAliPay);

dict[@"haveWeiXinPay"]=@(_haveWeiXinPay);

dict[@"haveBankCard"]=@(_haveBankCard);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<WithdrawalMethodModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
WithdrawalMethodModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<WithdrawalMethodModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<WithdrawalMethodModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
WithdrawalMethodModel* sumMdl=[WithdrawalMethodModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(WithdrawalMethodModel*)getFromDict:(NSDictionary*)dict
{
WithdrawalMethodModel* model=[[WithdrawalMethodModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.haveAliPay=[dict[@"haveAliPay"] isKindOfClass:[NSNull class]]?0:[dict[@"haveAliPay"] intValue];

model.haveWeiXinPay=[dict[@"haveWeiXinPay"] isKindOfClass:[NSNull class]]?0:[dict[@"haveWeiXinPay"] intValue];

model.haveBankCard=[dict[@"haveBankCard"] isKindOfClass:[NSNull class]]?0:[dict[@"haveBankCard"] intValue];


 return model;
}

 +(void)cloneObj:(WithdrawalMethodModel*) source target:(WithdrawalMethodModel*)target
{

target.haveAliPay=source.haveAliPay;

target.haveWeiXinPay=source.haveWeiXinPay;

target.haveBankCard=source.haveBankCard;

}

@end

