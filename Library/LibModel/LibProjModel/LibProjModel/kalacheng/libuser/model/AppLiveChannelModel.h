//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class OooTwoClassifyVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
一级菜单分类
 */
@interface AppLiveChannelModel : NSObject 


	/**
图片
 */
@property (nonatomic, copy) NSString * image;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
直播间数量累计
 */
@property (nonatomic, assign) int num;

	/**
一对一二级分类列表
 */
@property (nonatomic, strong) NSMutableArray<OooTwoClassifyVOModel*>* oooTwoClassifyVOList;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
是否启用  0:不启用  1：启用
 */
@property (nonatomic, assign) int isTip;

	/**
频道名
 */
@property (nonatomic, copy) NSString * title;

	/**
类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int type;

	/**
1:选中 0:未选中
 */
@property (nonatomic, assign) int isChecked;

 +(NSMutableArray<AppLiveChannelModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppLiveChannelModel*>*)list;

 +(AppLiveChannelModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppLiveChannelModel*) source target:(AppLiveChannelModel*)target;

@end

NS_ASSUME_NONNULL_END
