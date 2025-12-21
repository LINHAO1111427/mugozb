//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族公告VO
 */
@interface AppChatFamilyModel : NSObject 


	/**
家族角色 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int familyRole;

	/**
族长id
 */
@property (nonatomic, assign) int64_t patriarchId;

	/**
家族公告（对内）
 */
@property (nonatomic, copy) NSString * familyProclamation;

 +(NSMutableArray<AppChatFamilyModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyModel*>*)list;

 +(AppChatFamilyModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppChatFamilyModel*) source target:(AppChatFamilyModel*)target;

@end

NS_ASSUME_NONNULL_END
