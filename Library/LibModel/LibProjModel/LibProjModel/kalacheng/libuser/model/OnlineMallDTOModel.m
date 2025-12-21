//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "OnlineMallDTOModel.h"
#import "AppLiangModel.h"
#import "AppMicSeatBorderVOModel.h"
#import "AppCarModel.h"




 @implementation OnlineMallDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"liangList" : [AppLiangModel class],@"seatList" : [AppMicSeatBorderVOModel class],@"carList" : [AppCarModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_liangList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppLiangModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"liangList"]=list;
}//end

dict[@"coinShow"]=_coinShow;

dict[@"vcUnit"]=_vcUnit;

dict[@"vipType"]=@(_vipType);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_seatList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppMicSeatBorderVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"seatList"]=list;
}//end

dict[@"avatar"]=_avatar;


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_carList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppCarModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"carList"]=list;
}//end

dict[@"haveModuleVoiceLive"]=@(_haveModuleVoiceLive);

dict[@"username"]=_username;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OnlineMallDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
OnlineMallDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<OnlineMallDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<OnlineMallDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OnlineMallDTOModel* sumMdl=[OnlineMallDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(OnlineMallDTOModel*)getFromDict:(NSDictionary*)dict
{
OnlineMallDTOModel* model=[[OnlineMallDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.liangList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"liangList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiangModel* sumMdl=[AppLiangModel getFromDict:subDic];
[model.liangList addObject:sumMdl];

}
}

}

model.coinShow=[dict[@"coinShow"] isKindOfClass:[NSNull class]]?@"":dict[@"coinShow"];

model.vcUnit=[dict[@"vcUnit"] isKindOfClass:[NSNull class]]?@"":dict[@"vcUnit"];

model.vipType=[dict[@"vipType"] isKindOfClass:[NSNull class]]?0:[dict[@"vipType"] intValue];

model.seatList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"seatList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppMicSeatBorderVOModel* sumMdl=[AppMicSeatBorderVOModel getFromDict:subDic];
[model.seatList addObject:sumMdl];

}
}

}

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.carList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"carList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppCarModel* sumMdl=[AppCarModel getFromDict:subDic];
[model.carList addObject:sumMdl];

}
}

}

model.haveModuleVoiceLive=[dict[@"haveModuleVoiceLive"] isKindOfClass:[NSNull class]]?0:[dict[@"haveModuleVoiceLive"] intValue];

model.username=[dict[@"username"] isKindOfClass:[NSNull class]]?@"":dict[@"username"];


 return model;
}

 +(void)cloneObj:(OnlineMallDTOModel*) source target:(OnlineMallDTOModel*)target
{

        if(source.liangList==nil)
        {
//            target.liangList=nil;
        }else
        {
            target.liangList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.liangList.count;i++)
            {
		  [target.liangList addObject:[[AppLiangModel alloc]init]];
            [AppLiangModel cloneObj:source.liangList[i] target:target.liangList[i]];
            }
        }


target.coinShow=source.coinShow;

target.vcUnit=source.vcUnit;

target.vipType=source.vipType;

        if(source.seatList==nil)
        {
//            target.seatList=nil;
        }else
        {
            target.seatList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.seatList.count;i++)
            {
		  [target.seatList addObject:[[AppMicSeatBorderVOModel alloc]init]];
            [AppMicSeatBorderVOModel cloneObj:source.seatList[i] target:target.seatList[i]];
            }
        }


target.avatar=source.avatar;

        if(source.carList==nil)
        {
//            target.carList=nil;
        }else
        {
            target.carList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.carList.count;i++)
            {
		  [target.carList addObject:[[AppCarModel alloc]init]];
            [AppCarModel cloneObj:source.carList[i] target:target.carList[i]];
            }
        }


target.haveModuleVoiceLive=source.haveModuleVoiceLive;

target.username=source.username;

}

@end

