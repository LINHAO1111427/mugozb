//
//  LocationViewController.h
//  LibProjView
//
//  Created by klc on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^locationResultBack)(BOOL cancel,NSString *city,double lat,double lng,NSString *address);

@interface LocationView : UIView

- (void)showInView:(UIView *)superView callBack:(locationResultBack)callBack;

@end

@interface SelectLocationToMapVC: UIViewController

@property (nonatomic, copy)locationResultBack selectBlock;

@end

NS_ASSUME_NONNULL_END
/**
 备注：关于程序中的定位与地图 -- 2020.5.20
 一、概述：注册新用户的后台城市默认为北京、经纬度皆为-1，详细地址为空
 二、新用户资料填写user_update不进行位置修改的操作
 三、弹出地图并修改位置的几个地方
 1.开播显示位置为既往定位位置，点击位置后将产生新的位置，直到到开播后该位置才会与后台同步
 2.个人中心资料修改
 3.发布动态，同理动态发布后位置才会与后台同步
 四、需要给位置的几个地方：
 1.1v1速配列表
 2.1v1视频播放
 
 
 
 */
