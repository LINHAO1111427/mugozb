//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApplyRefundDTOModel.h"
#import "ApplyRefundReasonDTOModel.h"




 @implementation ApplyRefundDTOModel  

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"reasonList" : [ApplyRefundReasonDTOModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"amount"]=@(_amount);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_reasonList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApplyRefundReasonDTOModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"reasonList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApplyRefundDTOModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApplyRefundDTOModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApplyRefundDTOModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApplyRefundDTOModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApplyRefundDTOModel* sumMdl=[ApplyRefundDTOModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApplyRefundDTOModel*)getFromDict:(NSDictionary*)dict
{
ApplyRefundDTOModel* model=[[ApplyRefundDTOModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.amount=[dict[@"amount"] isKindOfClass:[NSNull class]]?0:[dict[@"amount"] doubleValue];

model.reasonList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"reasonList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApplyRefundReasonDTOModel* sumMdl=[ApplyRefundReasonDTOModel getFromDict:subDic];
[model.reasonList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ApplyRefundDTOModel*) source target:(ApplyRefundDTOModel*)target
{

target.amount=source.amount;

        if(source.reasonList==nil)
        {
//            target.reasonList=nil;
        }else
        {
            target.reasonList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.reasonList.count;i++)
            {
		  [target.reasonList addObject:[[ApplyRefundReasonDTOModel alloc]init]];
            [ApplyRefundReasonDTOModel cloneObj:source.reasonList[i] target:target.reasonList[i]];
            }
        }


}

@end

