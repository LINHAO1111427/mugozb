//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "CommonTipsDTOModel.h"
#import "AppCommonWordsModel.h"




 @implementation CommonTipsDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"commonWordsList" : [AppCommonWordsModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"privateChatDeductionTips"]=_privateChatDeductionTips;

dict[@"isShowTips"]=@(_isShowTips);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_commonWordsList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
AppCommonWordsModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"commonWordsList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CommonTipsDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
CommonTipsDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<CommonTipsDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<CommonTipsDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
CommonTipsDTOModel* sumMdl=[CommonTipsDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(CommonTipsDTOModel*)getFromDict:(NSDictionary*)dict
{
CommonTipsDTOModel* model=[[CommonTipsDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.privateChatDeductionTips=[dict[@"privateChatDeductionTips"] isKindOfClass:[NSNull class]]?@"":dict[@"privateChatDeductionTips"];

model.isShowTips=[dict[@"isShowTips"] isKindOfClass:[NSNull class]]?0:[dict[@"isShowTips"] intValue];

model.commonWordsList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"commonWordsList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
AppCommonWordsModel* sumMdl=[AppCommonWordsModel getFromDict:subDic];
[model.commonWordsList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(CommonTipsDTOModel*) source target:(CommonTipsDTOModel*)target
{

target.privateChatDeductionTips=source.privateChatDeductionTips;

target.isShowTips=source.isShowTips;

        if(source.commonWordsList==nil)
        {
//            target.commonWordsList=nil;
        }else
        {
            target.commonWordsList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.commonWordsList.count;i++)
            {
		  [target.commonWordsList addObject:[[AppCommonWordsModel alloc]init]];
            [AppCommonWordsModel cloneObj:source.commonWordsList[i] target:target.commonWordsList[i]];
            }
        }


}

@end

