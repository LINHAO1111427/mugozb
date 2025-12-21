//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class BlindBoxLabelVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
盲盒用户保存信息
 */
@interface BlindBoxUserInfoVOModel : NSObject 


	/**
用户性别
 */
@property (nonatomic, assign) int gender;

	/**
标签Id,字符串拼接
 */
@property (nonatomic, copy) NSString * labIds;

	/**
用户图片,字符串拼接
 */
@property (nonatomic, copy) NSString * realPic;

	/**
自我介绍
 */
@property (nonatomic, copy) NSString * introduce;

	/**
被抽取盲盒的次数
 */
@property (nonatomic, assign) int drawNum;

	/**
当前抽取信息消费的金额
 */
@property (nonatomic, assign) double currDrawCoin;

	/**
用户手机号
 */
@property (nonatomic, copy) NSString * mobile;

	/**
剩余次数
 */
@property (nonatomic, assign) int lastCount;

	/**
审核备注
 */
@property (nonatomic, assign) int remark;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
下架类型 1:用户自动下架 2:获取次数用完了，3:后台下架
 */
@property (nonatomic, assign) int reasonType;

	/**
当前存入信息消费的金额
 */
@property (nonatomic, assign) double currSaveCoin;

	/**
存储时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
学校名称
 */
@property (nonatomic, copy) NSString * school;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
标签列表
 */
@property (nonatomic, strong) NSMutableArray<BlindBoxLabelVOModel*>* labList;

	/**
存入用户ID
 */
@property (nonatomic, assign) int64_t appUserId;

	/**
用户年龄
 */
@property (nonatomic, assign) int age;

	/**
状态，0待审核  1已上架  -1已下架
 */
@property (nonatomic, assign) int status;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

	/**
用户微信号
 */
@property (nonatomic, copy) NSString * wechatNo;

 +(NSMutableArray<BlindBoxUserInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxUserInfoVOModel*>*)list;

 +(BlindBoxUserInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(BlindBoxUserInfoVOModel*) source target:(BlindBoxUserInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
