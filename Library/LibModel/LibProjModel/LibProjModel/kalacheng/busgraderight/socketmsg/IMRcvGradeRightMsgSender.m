//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibTools/NSDictionary+Json.h>
#import "IMRcvGradeRightMsgSender.h"


/**
等级特权相关的socket
 */
@implementation IMRcvGradeRightMsgSender

-(NSString*) getMsgType
{
    return @"GradeRightMsgSender";
}
-(void) onMsg:(NSString*)subType content:(NSDictionary*)content
{
   if([subType isEqualToString:@"onElasticFrameMedal"])
{
        [self onElasticFrameMedal:[ApiElasticFrameModel getFromDict:content[@"elasticFrame"]] ];
}else    if([subType isEqualToString:@"onElasticFrameUpgrade"])
{
        [self onElasticFrameUpgrade:[ApiElasticFrameModel getFromDict:content[@"elasticFrame"]] ];
}else    if([subType isEqualToString:@"onElasticFrameFinshTask"])
{
        [self onElasticFrameFinshTask:[ApiElasticFrameModel getFromDict:content[@"elasticFrame"]] ];
}
}
-(void) onOtherMsg:(NSDictionary*)content
{
}
/**
 获得勋章提示弹窗
 @param elasticFrame null
 */
-(void) onElasticFrameMedal:(ApiElasticFrameModel* )elasticFrame {  }
/**
 升级提示弹窗
 @param elasticFrame null
 */
-(void) onElasticFrameUpgrade:(ApiElasticFrameModel* )elasticFrame {  }
/**
 完成任务弹框
 @param elasticFrame null
 */
-(void) onElasticFrameFinshTask:(ApiElasticFrameModel* )elasticFrame {  }

@end


