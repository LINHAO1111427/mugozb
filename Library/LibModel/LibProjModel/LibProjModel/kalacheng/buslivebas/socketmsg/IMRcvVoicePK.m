//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvVoicePK.h"


/**
多人语音PK相关
 */
@implementation IMRcvVoicePK

-(NSString*) getMsgType
{
    return @"VoicePK";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"tellAuthorMatched"])
{
        [self tellAuthorMatched:[VoicePkVOModel getFromDict:content[@"thisPkVO"]] ];
}else    if([subType isEqualToString:@"quitPK"])
{
        [self quitPK:[ApiUsersVoiceAssistanModel getFromArr:content[@"thisAssistans"]] optUid:[content getInt64:@"optUid"] pkType:[content getInt:@"pkType"] ];
}else    if([subType isEqualToString:@"updatePK"])
{
        [self updatePK:[VoicePkVOModel getFromDict:content[@"thisPkVO"]] optUid:[content getInt64:@"optUid"] optType:[content getInt:@"optType"] ];
}else    if([subType isEqualToString:@"kickedBeforeOpen"])
{
        [self kickedBeforeOpen:[content getInt:@"pkType"] ];
}else    if([subType isEqualToString:@"startPK"])
{
        [self startPK:[VoicePkVOModel getFromDict:content[@"thisPkVO"]] ];
}else    if([subType isEqualToString:@"OpenPKSuccess"])
{
        [self OpenPKSuccess:[VoicePkVOModel getFromDict:content[@"thisPkVO"]] ];
}else    if([subType isEqualToString:@"beforefinishPK"])
{
        [self beforefinishPK:[VoicePkVOModel getFromDict:content[@"thisPkVO"]] ];
}else    if([subType isEqualToString:@"matchPkTimeOut"])
{
        [self matchPkTimeOut:[content getInt:@"pktype"] ];
}else    if([subType isEqualToString:@"sendGiftPk"])
{
        [self sendGiftPk:[PkGiftSenderModel getFromArr:content[@"thisSenders"]] otherSenders:[PkGiftSenderModel getFromArr:content[@"otherSenders"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 通知双方主播PK匹配成功，准备进入PK开始倒计时
 @param thisPkVO null
 */
-(void) tellAuthorMatched:(VoicePkVOModel* )thisPkVO {  }
/**
 主播提前退出PK 两边都发
 @param thisAssistans null
 @param optUid 发起强退方的ID
 @param pkType 所退出的PK类型
 */
-(void) quitPK:(NSMutableArray<ApiUsersVoiceAssistanModel*>* )thisAssistans optUid:(int64_t)optUid pkType:(int)pkType {  }
/**
 中途加入PK人员变动 开关麦 或者 送礼活力值变更  两边都要发
 @param thisPkVO null
 @param optUid 麦位上的涉及方ID 或者火力值更新时的送礼方ID
 @param optType 操作类型  1上麦 2下麦 3开麦 4关麦 5火力值更新 6被踢下麦 7锁麦 8表情包
 */
-(void) updatePK:(VoicePkVOModel* )thisPkVO optUid:(int64_t)optUid optType:(int)optType {  }
/**
 PK进入倒计时前踢出未参与的用户
 @param pkType null
 */
-(void) kickedBeforeOpen:(int)pkType {  }
/**
 倒计时结束后开始PK
 @param thisPkVO null
 */
-(void) startPK:(VoicePkVOModel* )thisPkVO {  }
/**
 开始倒计时 预备进入PK (只向主播发) 
 @param thisPkVO null
 */
-(void) OpenPKSuccess:(VoicePkVOModel* )thisPkVO {  }
/**
 PK结果 惩罚或平局
 @param thisPkVO null
 */
-(void) beforefinishPK:(VoicePkVOModel* )thisPkVO {  }
/**
 主播PK匹配超时
 @param pktype null
 */
-(void) matchPkTimeOut:(int)pktype {  }
/**
 pk更新礼物
 @param thisSenders null
 @param otherSenders null
 */
-(void) sendGiftPk:(NSMutableArray<PkGiftSenderModel*>* )thisSenders otherSenders:(NSMutableArray<PkGiftSenderModel*>* )otherSenders {  }

@end


