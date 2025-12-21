//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <LibProjBase/HttpClient.h>

#import "ApiSimpleMsgRoomModel.h"




 @implementation ApiSimpleMsgRoomModel  


 -(NSDictionary*)modelToJSONObject
{
//modelToJSONObject对象函数
NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

dict[@"serialVersionUID"]=@(_serialVersionUID);

dict[@"type"]=@(_type);

dict[@"userId"]=@(_userId);

dict[@"userName"]=_userName;

dict[@"avatar"]=_avatar;

dict[@"anchorAvatar"]=_anchorAvatar;

dict[@"anchorName"]=_anchorName;

dict[@"content"]=_content;

dict[@"guardType"]=@(_guardType);

dict[@"isFans"]=@(_isFans);

dict[@"goodnum"]=_goodnum;

dict[@"role"]=@(_role);

dict[@"anchorGrade"]=@(_anchorGrade);

dict[@"userGrade"]=@(_userGrade);

dict[@"wealthGrade"]=@(_wealthGrade);

dict[@"nobleGrade"]=@(_nobleGrade);

dict[@"anchorGradeImg"]=_anchorGradeImg;

dict[@"userGradeImg"]=_userGradeImg;

dict[@"wealthGradeImg"]=_wealthGradeImg;

dict[@"nobleGradeImg"]=_nobleGradeImg;

dict[@"nobleName"]=_nobleName;

dict[@"nobleAvatarFrame"]=_nobleAvatarFrame;

dict[@"nobleMedal"]=_nobleMedal;

dict[@"giftId"]=@(_giftId);

dict[@"giftType"]=@(_giftType);

dict[@"giftIcon"]=_giftIcon;

dict[@"giftName"]=_giftName;

dict[@"giftNumber"]=@(_giftNumber);

dict[@"fontDiscoloration"]=@(_fontDiscoloration);

dict[@"roomId"]=@(_roomId);

dict[@"translation"]=_translation;


 return dict;
}

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSimpleMsgRoomModel*>*)list
{
//modelToJSONObject对象数组函数
NSMutableArray *nsList =[[NSMutableArray alloc] init];
if(list==nil)
{return nsList; 
}
for(int i=0;i<list.count;i++)
{
ApiSimpleMsgRoomModel* sumMdl=list[i];
NSDictionary* subDict =[sumMdl modelToJSONObject];
[nsList addObject:subDict];

}
return nsList;

}

 +(NSMutableArray<ApiSimpleMsgRoomModel*>*)getFromArr:(NSArray*)list
{
NSMutableArray<ApiSimpleMsgRoomModel*>* mdlArr=[[NSMutableArray alloc] init];
if (list == nil || [list isKindOfClass:[NSNull class]]) {
        return mdlArr;
    }
{
//getFromArr对象数组转换
for(int i=0;i<list.count;i++)
{
NSDictionary *subDic = list[i];
ApiSimpleMsgRoomModel* sumMdl=[ApiSimpleMsgRoomModel getFromDict:subDic];
[mdlArr addObject:sumMdl];

}
return mdlArr;

}
}

 +(ApiSimpleMsgRoomModel*)getFromDict:(NSDictionary*)dict
{
ApiSimpleMsgRoomModel* model=[[ApiSimpleMsgRoomModel alloc]init];

if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return model;
    }
model.serialVersionUID=[dict[@"serialVersionUID"] isKindOfClass:[NSNull class]]?0:[dict[@"serialVersionUID"] longLongValue];

model.type=[dict[@"type"] isKindOfClass:[NSNull class]]?0:[dict[@"type"] intValue];

model.userId=[dict[@"userId"] isKindOfClass:[NSNull class]]?0:[dict[@"userId"] longLongValue];

model.userName=[dict[@"userName"] isKindOfClass:[NSNull class]]?@"":dict[@"userName"];

model.avatar=[dict[@"avatar"] isKindOfClass:[NSNull class]]?@"":dict[@"avatar"];

model.anchorAvatar=[dict[@"anchorAvatar"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorAvatar"];

model.anchorName=[dict[@"anchorName"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorName"];

model.content=[dict[@"content"] isKindOfClass:[NSNull class]]?@"":dict[@"content"];

model.guardType=[dict[@"guardType"] isKindOfClass:[NSNull class]]?0:[dict[@"guardType"] intValue];

model.isFans=[dict[@"isFans"] isKindOfClass:[NSNull class]]?0:[dict[@"isFans"] intValue];

model.goodnum=[dict[@"goodnum"] isKindOfClass:[NSNull class]]?@"":dict[@"goodnum"];

model.role=[dict[@"role"] isKindOfClass:[NSNull class]]?0:[dict[@"role"] intValue];

model.anchorGrade=[dict[@"anchorGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"anchorGrade"] intValue];

model.userGrade=[dict[@"userGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"userGrade"] intValue];

model.wealthGrade=[dict[@"wealthGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"wealthGrade"] intValue];

model.nobleGrade=[dict[@"nobleGrade"] isKindOfClass:[NSNull class]]?0:[dict[@"nobleGrade"] intValue];

model.anchorGradeImg=[dict[@"anchorGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"anchorGradeImg"];

model.userGradeImg=[dict[@"userGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"userGradeImg"];

model.wealthGradeImg=[dict[@"wealthGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"wealthGradeImg"];

model.nobleGradeImg=[dict[@"nobleGradeImg"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleGradeImg"];

model.nobleName=[dict[@"nobleName"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleName"];

model.nobleAvatarFrame=[dict[@"nobleAvatarFrame"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleAvatarFrame"];

model.nobleMedal=[dict[@"nobleMedal"] isKindOfClass:[NSNull class]]?@"":dict[@"nobleMedal"];

model.giftId=[dict[@"giftId"] isKindOfClass:[NSNull class]]?0:[dict[@"giftId"] longLongValue];

model.giftType=[dict[@"giftType"] isKindOfClass:[NSNull class]]?0:[dict[@"giftType"] intValue];

model.giftIcon=[dict[@"giftIcon"] isKindOfClass:[NSNull class]]?@"":dict[@"giftIcon"];

model.giftName=[dict[@"giftName"] isKindOfClass:[NSNull class]]?@"":dict[@"giftName"];

model.giftNumber=[dict[@"giftNumber"] isKindOfClass:[NSNull class]]?0:[dict[@"giftNumber"] intValue];

model.fontDiscoloration=[dict[@"fontDiscoloration"] isKindOfClass:[NSNull class]]?0:[dict[@"fontDiscoloration"] intValue];

model.roomId=[dict[@"roomId"] isKindOfClass:[NSNull class]]?0:[dict[@"roomId"] longLongValue];

model.translation=[dict[@"translation"] isKindOfClass:[NSNull class]]?@"":dict[@"translation"];


 return model;
}

 +(void)cloneObj:(ApiSimpleMsgRoomModel*) source target:(ApiSimpleMsgRoomModel*)target
{

target.serialVersionUID=source.serialVersionUID;

target.type=source.type;

target.userId=source.userId;

target.userName=source.userName;

target.avatar=source.avatar;

target.anchorAvatar=source.anchorAvatar;

target.anchorName=source.anchorName;

target.content=source.content;

target.guardType=source.guardType;

target.isFans=source.isFans;

target.goodnum=source.goodnum;

target.role=source.role;

target.anchorGrade=source.anchorGrade;

target.userGrade=source.userGrade;

target.wealthGrade=source.wealthGrade;

target.nobleGrade=source.nobleGrade;

target.anchorGradeImg=source.anchorGradeImg;

target.userGradeImg=source.userGradeImg;

target.wealthGradeImg=source.wealthGradeImg;

target.nobleGradeImg=source.nobleGradeImg;

target.nobleName=source.nobleName;

target.nobleAvatarFrame=source.nobleAvatarFrame;

target.nobleMedal=source.nobleMedal;

target.giftId=source.giftId;

target.giftType=source.giftType;

target.giftIcon=source.giftIcon;

target.giftName=source.giftName;

target.giftNumber=source.giftNumber;

target.fontDiscoloration=source.fontDiscoloration;

target.roomId=source.roomId;

target.translation=source.translation;

}

@end

