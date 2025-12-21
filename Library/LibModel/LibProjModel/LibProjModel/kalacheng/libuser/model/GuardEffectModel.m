//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "GuardEffectModel.h"




 @implementation GuardEffectModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"img"]=_img;

dict[@"des"]=_des;

dict[@"isAble"]=@(_isAble);

dict[@"title"]=_title;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardEffectModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
GuardEffectModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<GuardEffectModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<GuardEffectModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
GuardEffectModel* sumMdl=[GuardEffectModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(GuardEffectModel*)getFromDict:(NSDictionary*)dict
{
GuardEffectModel* model=[[GuardEffectModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.img=[dict[@"img"] isKindOfClass:[NSNull class]]?@"":dict[@"img"];

model.des=[dict[@"des"] isKindOfClass:[NSNull class]]?@"":dict[@"des"];

model.isAble=[dict[@"isAble"] isKindOfClass:[NSNull class]]?0:[dict[@"isAble"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];


 return model;
}

 +(void)cloneObj:(GuardEffectModel*) source target:(GuardEffectModel*)target
{

target.img=source.img;

target.des=source.des;

target.isAble=source.isAble;

target.title=source.title;

}

@end

