//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppOpenNobleDTOModel.h"
#import "CfgPayWayDTOModel.h"
#import "NobleCenterVipPriceDTOModel.h"




 @implementation AppOpenNobleDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"payWayList" : [CfgPayWayDTOModel class],@"priceList" : [NobleCenterVipPriceDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"userGrade"]=@(_userGrade);

dict[@"endDay"]=@(_endDay);

dict[@"openNoblePrompt"]=_openNoblePrompt;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_payWayList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
CfgPayWayDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"payWayList"]=list;
}//end

dict[@"avatar"]=_avatar;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"coinUnit"]=_coinUnit;

dict[@"noblePackageName"]=_noblePackageName;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_priceList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
NobleCenterVipPriceDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"priceList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOpenNobleDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppOpenNobleDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppOpenNobleDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppOpenNobleDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppOpenNobleDTOModel* sumMdl=[AppOpenNobleDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppOpenNobleDTOModel*)getFromDict:(NSDictionary*)dict
{
AppOpenNobleDTOModel* model=[[AppOpenNobleDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.endDay=[dict[@"endDay"] isKindOfClass:[NSNull class]]?0:[dict[@"endDay"] intValue];

model.openNoblePrompt=[dict[@"openNoblePrompt"] isKindOfClass:[NSNull class]]?@"":dict[@"openNoblePrompt"];

model.payWayList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"payWayList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CfgPayWayDTOModel* sumMdl=[CfgPayWayDTOModel getFromDict:subDic];
[model.payWayList addObject:sumMdl];

}
}

}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.coinUnit=[dict[@"coinUnit"] isKindOfClass:[NSNull class]]?@"":dict[@"coinUnit"];

model.noblePackageName=[dict[@"noblePackageName"] isKindOfClass:[NSNull class]]?@"":dict[@"noblePackageName"];

model.priceList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"priceList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
NobleCenterVipPriceDTOModel* sumMdl=[NobleCenterVipPriceDTOModel getFromDict:subDic];
[model.priceList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(AppOpenNobleDTOModel*) source target:(AppOpenNobleDTOModel*)target
{

target.userGrade=source.userGrade;

target.endDay=source.endDay;

target.openNoblePrompt=source.openNoblePrompt;

        if(source.payWayList==nil)
        {
//            target.payWayList=nil;
        }else
        {
            target.payWayList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.payWayList.count;i++)
            {
		  [target.payWayList addObject:[[CfgPayWayDTOModel alloc]init]];
            [CfgPayWayDTOModel cloneObj:source.payWayList[i] target:target.payWayList[i]];
            }
        }


target.avatar=source.avatar;

target.nobleGradeImg=source.nobleGradeImg;

target.coinUnit=source.coinUnit;

target.noblePackageName=source.noblePackageName;

        if(source.priceList==nil)
        {
//            target.priceList=nil;
        }else
        {
            target.priceList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.priceList.count;i++)
            {
		  [target.priceList addObject:[[NobleCenterVipPriceDTOModel alloc]init]];
            [NobleCenterVipPriceDTOModel cloneObj:source.priceList[i] target:target.priceList[i]];
            }
        }


}

@end

