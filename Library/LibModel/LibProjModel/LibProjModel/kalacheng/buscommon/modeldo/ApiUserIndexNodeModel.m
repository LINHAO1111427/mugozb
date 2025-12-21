//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiUserIndexNodeModel.h"
#import "ApiUserIndexNodeModel.h"




 @implementation ApiUserIndexNodeModel  

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_field":@"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"userIndexNodeList" : [ApiUserIndexNodeModel class]};
}

 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"app_type"]=_app_type;

dict[@"app_url"]=_app_url;

dict[@"icon"]=_icon;

dict[@"name"]=_name;

dict[@"remark"]=_remark;

dict[@"id"]=@(_id_field);

dict[@"type"]=@(_type);


{//start
//modelToJSONObject字段数组Model
NSArray* objList=_userIndexNodeList;
NSMutableArray *list =[[NSMutableArray alloc] init];
for(int i=0;i<objList.count;i++)
{
ApiUserIndexNodeModel* sumMdl=objList[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[list addObject:subDict];

}
dict[@"userIndexNodeList"]=list;
}//end


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserIndexNodeModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiUserIndexNodeModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiUserIndexNodeModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiUserIndexNodeModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexNodeModel* sumMdl=[ApiUserIndexNodeModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiUserIndexNodeModel*)getFromDict:(NSDictionary*)dict
{
ApiUserIndexNodeModel* model=[[ApiUserIndexNodeModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.app_type=[dict[@"app_type"] isKindOfClass:[NSNull class]]?@"":dict[@"app_type"];

model.app_url=[dict[@"app_url"] isKindOfClass:[NSNull class]]?@"":dict[@"app_url"];

model.icon=[dict[@"icon"] isKindOfClass:[NSNull class]]?@"":dict[@"icon"];

model.name=[dict[@"name"] isKindOfClass:[NSNull class]]?@"":dict[@"name"];

model.remark=[dict[@"remark"] isKindOfClass:[NSNull class]]?@"":dict[@"remark"];

model.id_field=[dict[@"id"] isKindOfClass:[NSNull class]]?0:[dict[@"id"] intValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userIndexNodeList=[[NSMutableArray alloc] init];
{
//getFromDict对象数组转换
NSArray *list = dict[@"userIndexNodeList"];
if ( ![list isKindOfClass:[NSNull class]] && list.count > 0 ) 
{
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiUserIndexNodeModel* sumMdl=[ApiUserIndexNodeModel getFromDict:subDic];
[model.userIndexNodeList addObject:sumMdl];

}
}

}


 return model;
}

 +(void)cloneObj:(ApiUserIndexNodeModel*) source target:(ApiUserIndexNodeModel*)target
{

target.app_type=source.app_type;

target.app_url=source.app_url;

target.icon=source.icon;

target.name=source.name;

target.remark=source.remark;

target.id_field=source.id_field;

target.type=source.type;

        if(source.userIndexNodeList==nil)
        {
//            target.userIndexNodeList=nil;
        }else
        {
            target.userIndexNodeList=[[NSMutableArray alloc] init];
            for(int i=0;i<source.userIndexNodeList.count;i++)
            {
		  [target.userIndexNodeList addObject:[[ApiUserIndexNodeModel alloc]init]];
            [ApiUserIndexNodeModel cloneObj:source.userIndexNodeList[i] target:target.userIndexNodeList[i]];
            }
        }


}

@end

