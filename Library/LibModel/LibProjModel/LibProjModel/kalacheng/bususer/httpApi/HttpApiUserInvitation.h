//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "UserInvitationVOModel.h"

typedef void (^CallBackUserInvitation_UserInvitationVOArr)(int code,NSString *strMsg,NSArray<UserInvitationVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
邀请赚钱
 */
@interface HttpApiUserInvitation: NSObject



/**
 null
 @param pageIndex 页码
 @param pageSize 每页显示条数
 */
+(void) userInvitationList:(int)pageIndex pageSize:(int)pageSize  callback:(CallBackUserInvitation_UserInvitationVOArr)callback;

@end

NS_ASSUME_NONNULL_END
