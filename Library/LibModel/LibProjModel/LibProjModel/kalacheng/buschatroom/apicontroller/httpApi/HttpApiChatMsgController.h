//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppBookShowInfoVOModel.h"

#import "ImExtraInfoModel.h"

#import "ChatTopRecordVOModel.h"

#import "AppAddressBookNumberVOModel.h"

#import "HttpNoneModel.h"

#import "UserGroupIdDtoModel.h"
typedef void (^CallBackChatMsgController_AppBookShowInfoVOArr)(int code,NSString *strMsg,NSArray<AppBookShowInfoVOModel*>* arr);
typedef void (^CallBackChatMsgController_ImExtraInfoArr)(int code,NSString *strMsg,NSArray<ImExtraInfoModel*>* arr);
typedef void (^CallBackChatMsgController_ChatTopRecordVOArr)(int code,NSString *strMsg,NSArray<ChatTopRecordVOModel*>* arr);
typedef void (^CallBackChatMsgController_AppAddressBookNumberVO)(int code,NSString *strMsg,AppAddressBookNumberVOModel* model);
typedef void (^CallBackChatMsgController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
聊天信息相关
 */
@interface HttpApiChatMsgController: NSObject



/**
 根据类型查询聊天通讯录的信息
 @param findType 查询类型 1:密友(相互关注的人) 2:备注(我备注过的人) 3:粉丝(关注我的人) 4:我关注的人 5:我的群组(加入的粉丝团+加入的家族)
 */
+(void) getAppBookShowInfoList:(int)findType  callback:(CallBackChatMsgController_AppBookShowInfoVOArr)callback;


/**
 获取用户的名称，头像
 @param listUGID listUGID
 */
+(void) getImExtraInfo:(NSMutableArray<NSNumber *>* )listUGID  callback:(CallBackChatMsgController_ImExtraInfoArr)callback;


/**
 删除消息置顶
 @param chatTopRecordId 置顶的id
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 */
+(void) delChatTopRecord:(int64_t)chatTopRecordId topPosition:(int)topPosition  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback;


/**
 获取聊天中的置顶消息
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 */
+(void) getChatTopRecordList:(int)topPosition  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback;


/**
 获取通讯录中用户和群组的数量
 */
+(void) getAddressBookNumber:(CallBackChatMsgController_AppAddressBookNumberVO)callback;


/**
 发送聊天室置顶消息
 @param familyId 家族id
 @param topMsgContent 消息内容
 */
+(void) sendFamilyTopMsg:(int64_t)familyId topMsgContent:(NSString *)topMsgContent  callback:(CallBackChatMsgController_HttpNone)callback;


/**
 获取用户的名称，头像
 @param userIdLists userIdLists
 */
+(void) getImExtraInfo1:(UserGroupIdDtoModel* )userIdLists  callback:(CallBackChatMsgController_ImExtraInfoArr)callback;


/**
 添加通讯录置顶
 @param topPosition 置顶类型 1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组 6:聊天消息
 @param topType  置顶的类型(当前聊天信息接收方是哪种类型) 1:用户 2:家族 3:粉丝团
 @param topUGID 计算后的ugid
 @param topUserOrGorupId 真实用户或群组id
 */
+(void) addChatTopRecord:(int)topPosition topType:(int)topType topUGID:(int64_t)topUGID topUserOrGorupId:(int64_t)topUserOrGorupId  callback:(CallBackChatMsgController_ChatTopRecordVOArr)callback;

@end

NS_ASSUME_NONNULL_END
