//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天广场显示VO
 */
@interface AppHomeChatPlazaVOModel : NSObject 


	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
最后一条信息的json
 */
@property (nonatomic, copy) NSString * lastMsgJson;

	/**
家族名称
 */
@property (nonatomic, copy) NSString * familyName;

	/**
家族人数 
 */
@property (nonatomic, assign) int familyNumber;

	/**
家族等级
 */
@property (nonatomic, assign) int familyGrade;

	/**
实时人数 
 */
@property (nonatomic, assign) int64_t realTimeNumber;

	/**
家族图标
 */
@property (nonatomic, copy) NSString * familyIcon;

	/**
家族描述
 */
@property (nonatomic, copy) NSString * familyDescription;

	/**
家族等级图标
 */
@property (nonatomic, copy) NSString * familyGradeIcon;

 +(NSMutableArray<AppHomeChatPlazaVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHomeChatPlazaVOModel*>*)list;

 +(AppHomeChatPlazaVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHomeChatPlazaVOModel*) source target:(AppHomeChatPlazaVOModel*)target;

@end

NS_ASSUME_NONNULL_END
