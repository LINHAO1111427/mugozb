//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CfgWechatVOModel.h"
#import "StarPriceDOModel.h"




 @implementation CfgWechatVOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"wechatPriceList" : [StarPriceDOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"wechatPrice"]=@(_wechatPrice);

dict[@"wechat"]=_wechat;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_wechatPriceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
StarPriceDOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"wechatPriceList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgWechatVOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CfgWechatVOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CfgWechatVOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CfgWechatVOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgWechatVOModel* sumMdl=[CfgWechatVOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CfgWechatVOModel*)getFromDict:(NSDictionary*)dict
{
CfgWechatVOModel* model=[[CfgWechatVOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.wechatPrice=[dict[@"wechatPrice"] isKindOfClass:[NSNull class]]?0:[dict[@"wechatPrice"] doubleValue];

model.wechat=[dict[@"wechat"] isKindOfClass:[NSNull class]]?@"":dict[@"wechat"];

model.wechatPriceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"wechatPriceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
StarPriceDOModel* sumMdl=[StarPriceDOModel getFromDict:subDic];
[model.wechatPriceList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(CfgWechatVOModel*) source target:(CfgWechatVOModel*)target
{

target.wechatPrice=source.wechatPrice;

target.wechat=source.wechat;

        if(source.wechatPriceList==nil)
        {
//            target.wechatPriceList=nil;
        }else
        {
            target.wechatPriceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.wechatPriceList.count;i++)
            {
		  [target.wechatPriceList addObject:[[StarPriceDOModel alloc]init]];
            [StarPriceDOModel cloneObj:source.wechatPriceList[i] target:target.wechatPriceList[i]];
            }
        }


}

@end

