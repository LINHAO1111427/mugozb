//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <TXImKit/TXImKit.h>
#import "ApiElasticFrameModel.h"
NS_ASSUME_NONNULL_BEGIN



/**
等级特权相关的socket
 */
@interface IMRcvGradeRightMsgSender: NSObject<IMReceiver>


-(NSString*)getMsgType;

-(void) onMsg:(NSString*)subType content:(NSDictionary*)content;

-(void) onOtherMsg:(NSDictionary*)content;


/**
 获得勋章提示弹窗
 @param elasticFrame null
 */
-(void) onElasticFrameMedal:(ApiElasticFrameModel* )elasticFrame ;


/**
 升级提示弹窗
 @param elasticFrame null
 */
-(void) onElasticFrameUpgrade:(ApiElasticFrameModel* )elasticFrame ;


/**
 完成任务弹框
 @param elasticFrame null
 */
-(void) onElasticFrameFinshTask:(ApiElasticFrameModel* )elasticFrame ;

@end

NS_ASSUME_NONNULL_END
