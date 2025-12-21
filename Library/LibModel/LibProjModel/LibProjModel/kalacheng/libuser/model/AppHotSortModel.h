//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
首页热门分类
 */
@interface AppHotSortModel : NSObject 


	/**
图片
 */
@property (nonatomic, copy) NSString * image;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
排序
 */
@property (nonatomic, assign) int sort;

	/**
是否启用  0:不启用  1：启用
 */
@property (nonatomic, assign) int isTip;

	/**
参数
 */
@property (nonatomic, copy) NSString * params;

	/**
类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int type;

	/**
安卓用
 */
@property (nonatomic, assign) int isChecked;

	/**
前端是否显示 1:显示 0:不显示
 */
@property (nonatomic, assign) int isShow;

	/**
数量
 */
@property (nonatomic, assign) int number;

	/**
路径
 */
@property (nonatomic, copy) NSString * path;

	/**
菜单名称
 */
@property (nonatomic, copy) NSString * name;

	/**
展示分类 0:启动图 1:直播 2:推荐 3:附近 4:听音 5...
 */
@property (nonatomic, assign) int showType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

 +(NSMutableArray<AppHotSortModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppHotSortModel*>*)list;

 +(AppHotSortModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppHotSortModel*) source target:(AppHotSortModel*)target;

@end

NS_ASSUME_NONNULL_END
