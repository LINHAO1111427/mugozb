//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "AppLiveChannelModel.h"
#import "OooTwoClassifyVOModel.h"




 @implementation AppLiveChannelModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"oooTwoClassifyVOList" : [OooTwoClassifyVOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"image"]=_image;

dict[@"addTime"]=[HttpClient stringFromDate:_addTime];

dict[@"num"]=@(_num);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_oooTwoClassifyVOList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
OooTwoClassifyVOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"oooTwoClassifyVOList"]=list;
}//end

dict[@"id"]=@(_id_field);

dict[@"sort"]=@(_sort);

dict[@"isTip"]=@(_isTip);

dict[@"title"]=_title;

dict[@"type"]=@(_type);

dict[@"isChecked"]=@(_isChecked);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveChannelModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
AppLiveChannelModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<AppLiveChannelModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<AppLiveChannelModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppLiveChannelModel* sumMdl=[AppLiveChannelModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(AppLiveChannelModel*)getFromDict:(NSDictionary*)dict
{
AppLiveChannelModel* model=[[AppLiveChannelModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.image=[dict[@"image"] isKindOfClass:[NSNull class]]?@"":dict[@"image"];


{
NSString *strDate= dict[@"addTime"];
if (![strDate isKindOfClass:[NSNull class]] && strDate.length > 0) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [format dateFromString:strDate];
model.addTime=date;
    }
}

model.num=[dict[@"num"] isKindOfClass:[NSNull class]]?0:[dict[@"num"] intValue];

model.oooTwoClassifyVOList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"oooTwoClassifyVOList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
OooTwoClassifyVOModel* sumMdl=[OooTwoClassifyVOModel getFromDict:subDic];
[model.oooTwoClassifyVOList addObject:sumMdl];

}
}

}

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] longLongValue];

model.sort=[dict[@"sort"] isKindOfClass:[NSNull class]]?0:[dict[@"sort"] intValue];

model.isTip=[dict[@"isTip"] isKindOfClass:[NSNull class]]?0:[dict[@"isTip"] intValue];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.isChecked=[dict[@"isChecked"] isKindOfClass:[NSNull class]]?0:[dict[@"isChecked"] intValue];


 return model;
}

 +(void)cloneObj:(AppLiveChannelModel*) source target:(AppLiveChannelModel*)target
{

target.image=source.image;

target.addTime=source.addTime;

target.num=source.num;

        if(source.oooTwoClassifyVOList==nil)
        {
//            target.oooTwoClassifyVOList=nil;
        }else
        {
            target.oooTwoClassifyVOList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.oooTwoClassifyVOList.count;i++)
            {
		  [target.oooTwoClassifyVOList addObject:[[OooTwoClassifyVOModel alloc]init]];
            [OooTwoClassifyVOModel cloneObj:source.oooTwoClassifyVOList[i] target:target.oooTwoClassifyVOList[i]];
            }
        }


target.id_field=source.id_field;

target.sort=source.sort;

target.isTip=source.isTip;

target.title=source.title;

target.type=source.type;

target.isChecked=source.isChecked;

}

@end

