//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
盲盒用户
 */
@interface DrawBlindBoxRecordVOModel : NSObject 


	/**
自我介绍
 */
@property (nonatomic, copy) NSString * toIntroduce;

	/**
标签名称,字符串拼接
 */
@property (nonatomic, copy) NSString * toLabStrs;

	/**
用户微信号
 */
@property (nonatomic, copy) NSString * toWechatNo;

	/**
抽取人头像
 */
@property (nonatomic, copy) NSString * drawAvatar;

	/**
用户名
 */
@property (nonatomic, copy) NSString * toUsername;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * toAvatar;

	/**
抽取类型 1.根据性别开启，2.匹配
 */
@property (nonatomic, assign) int drawType;

	/**
抽取的性别
 */
@property (nonatomic, assign) int drawGender;

	/**
学校名称
 */
@property (nonatomic, copy) NSString * toSchool;

	/**
被抽取人
 */
@property (nonatomic, assign) int64_t toUserId;

	/**
用户年龄
 */
@property (nonatomic, assign) int toAge;

	/**
抽取时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
标签id,字符串拼接
 */
@property (nonatomic, copy) NSString * toLabIds;

	/**
用户手机号
 */
@property (nonatomic, copy) NSString * toMobile;

	/**
用户真实照片,字符串拼接
 */
@property (nonatomic, copy) NSString * toRealPic;

	/**
抽取人姓名
 */
@property (nonatomic, copy) NSString * drawUsername;

	/**
抽盲盒消费的金币
 */
@property (nonatomic, assign) double drawCoin;

	/**
用户性别
 */
@property (nonatomic, assign) int toGender;

	/**
抽取人
 */
@property (nonatomic, assign) int64_t drawUserId;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<DrawBlindBoxRecordVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<DrawBlindBoxRecordVOModel*>*)list;

 +(DrawBlindBoxRecordVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(DrawBlindBoxRecordVOModel*) source target:(DrawBlindBoxRecordVOModel*)target;

@end

NS_ASSUME_NONNULL_END
