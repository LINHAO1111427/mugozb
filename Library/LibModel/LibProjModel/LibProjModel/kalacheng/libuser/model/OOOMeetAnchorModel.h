//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class OOOLiveRoomNoAnswerDtoModel;
 @class ApiUserInfoOOOReqModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP遇见主播端相应
 */
@interface OOOMeetAnchorModel : NSObject 


	/**
未接听用户列表
 */
@property (nonatomic, strong) NSMutableArray<OOOLiveRoomNoAnswerDtoModel*>* noAnswerUserList;

	/**
匹配中的用户列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUserInfoOOOReqModel*>* matchingUserList;

	/**
邀请通话的用户列表
 */
@property (nonatomic, strong) NSMutableArray<ApiUserInfoOOOReqModel*>* reqUserList;

 +(NSMutableArray<OOOMeetAnchorModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOMeetAnchorModel*>*)list;

 +(OOOMeetAnchorModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOMeetAnchorModel*) source target:(OOOMeetAnchorModel*)target;

@end

NS_ASSUME_NONNULL_END
