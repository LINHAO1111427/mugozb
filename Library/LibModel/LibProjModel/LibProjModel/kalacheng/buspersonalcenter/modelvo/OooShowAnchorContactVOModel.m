//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OooShowAnchorContactVOModel.h"




 @implementation OooShowAnchorContactVOModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"mobile"]=_mobile;

dict[@"mobileCoin"]=@(_mobileCoin);

dict[@"wechatCoin"]=@(_wechatCoin);

dict[@"wechatNo"]=_wechatNo;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooShowAnchorContactVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OooShowAnchorContactVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OooShowAnchorContactVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OooShowAnchorContactVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OooShowAnchorContactVOModel* sumMdl=[OooShowAnchorContactVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OooShowAnchorContactVOModel*)getFromDict:(NSDictionary*)dict
{
OooShowAnchorContactVOModel* model=[[OooShowAnchorContactVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.mobile=[dict[@"mobile"] isKindOfClass:[NSNull class]]?@"":dict[@"mobile"];

model.mobileCoin=[dict[@"mobileCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"mobileCoin"] doubleValue];

model.wechatCoin=[dict[@"wechatCoin"] isKindOfClass:[NSNull class]]?0:[dict[@"wechatCoin"] doubleValue];

model.wechatNo=[dict[@"wechatNo"] isKindOfClass:[NSNull class]]?@"":dict[@"wechatNo"];


 return model;
}

 +(void)cloneObj:(OooShowAnchorContactVOModel*) source target:(OooShowAnchorContactVOModel*)target
{

target.mobile=source.mobile;

target.mobileCoin=source.mobileCoin;

target.wechatCoin=source.wechatCoin;

target.wechatNo=source.wechatNo;

}

@end

