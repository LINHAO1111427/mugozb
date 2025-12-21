//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiGradeReListModel.h"




 @implementation ApiGradeReListModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"number"]=@(_number);

dict[@"img"]=_img;

dict[@"title"]=_title;

dict[@"type"]=@(_type);


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiGradeReListModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiGradeReListModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiGradeReListModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiGradeReListModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiGradeReListModel* sumMdl=[ApiGradeReListModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiGradeReListModel*)getFromDict:(NSDictionary*)dict
{
ApiGradeReListModel* model=[[ApiGradeReListModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.number=[dict[@"number"] isKindOfClass:[NSNull class]]?0:[dict[@"number"] intValue];

model.img=[dict[@"img"] isKindOfClass:[NSNull class]]?@"":dict[@"img"];

model.title=[dict[@"title"] isKindOfClass:[NSNull class]]?@"":dict[@"title"];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];


 return model;
}

 +(void)cloneObj:(ApiGradeReListModel*) source target:(ApiGradeReListModel*)target
{

target.number=source.number;

target.img=source.img;

target.title=source.title;

target.type=source.type;

}

@end

