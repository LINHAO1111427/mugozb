//
//  BaseMacroDefinition.h
//  LibTools
//
//  Created by admin on 2019/12/6.
//  Copyright © 2019 . All rights reserved.
//

#ifndef BaseMacroDefinition_h
#define BaseMacroDefinition_h


//#gragma mark - 屏幕宽高

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define kMaxWidth   (kISiPAD?480:kScreenWidth)

//#gragma mark - 手机型号

//6为标准适配的,如果需要其他标准可以修改
//#define kScale_W(w) ((kScreenWidth)/375) * (w)
//#define kScale_H(h) (kScreenHeight/667) * (h)

//字体适配
#define kScaleFont(fontSize) [UIFont systemFontOfSize: fontSize*kScreenWidth/375.0]
//状态栏高度
#define kStatusBarHeight  [UIhelpTools getStatusBarHight]
//底部安全区高度
#define kSafeAreaBottom  [UIhelpTools getTabbarSafeAreaHeight]
//导航栏高度
#define kNavBarHeight (kStatusBarHeight + 44.0)
//标签栏高度
#define kTabBarHeight (49.0 + kSafeAreaBottom)


//#gragma mark - 手机型号

#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kISiPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))
#define kISiPhone5 (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6 (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
//是否为iphoneX以后机型
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)


#define kiOS13  ( [[[UIDevice currentDevice] systemVersion] compare:@"13.0"] != NSOrderedAscending )

#define kiOS11    @available(iOS 11.0, *)
#define kiOS(N)   @available(iOS N, *)



//#gragma mark - 颜色设置
#define kRGB_COLOR(rgbValue) [UIColor colorWithHexStr:rgbValue]

#define kRGBA_COLOR(rgbValue, alphaValue) [UIColor colorWithHexStr:rgbValue alpha:alphaValue]

//RGB格式
#define kRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//RGBA格式
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//随机颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define PlaholderImage [UIImage imageWithColor:kRGB_COLOR(@"#EEEEEE")]

//#gragma mark - 常用宏
#define kWeakSelf(type)  __weak typeof(type) weak##type = type
#define kStrongSelf(type)  __strong typeof(type) type = weak##type
#define kString(str) ([NSString stringWithFormat:@"%@",str])

#define kUnitStr                      [KLCAppConfig unitStr]
#define kPageSize                   30

// 头部title正常字体大小和选中字体大小
#define kTitleViewTitleFont (18)
#define kTitleViewTitleSelectedFont (22)


#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define ImgNamed(x)                 [UIImage imageNamed:x]
///width固定(200) 浮点型，高度等比缩小，生成(200x133)缩略图：
#define kThumbnailUrl(url,width)  [NSString stringWithFormat:@"%@?imageView2/2/w/%0.0lf",url,width]



#define kFont(x)                    [UIFont systemFontOfSize:x]
#define kStringFormat(x,...)        [NSString stringWithFormat:x, __VA_ARGS__]
#define kUserDefalt                 [NSUserDefaults standardUserDefaults]
#define kFileManager                [NSFileManager defaultManager]

//rect
#define SIZE(width,height)          CGSizeMake(width, height)
#define POINT(x,y)                  CGPointMake(x, y)
#define RECT(x,y,width,height)      CGRectMake(x, y, width, height)

//属性
#define kStrong(class,name)         @property(nonatomic,strong)class *name;
#define kCopyStr(name)              @property(nonatomic,copy)NSString *name;
#define kAssign(type,name)          @property(nonatomic,assign)type name;
#define kBlock(name,...)            @property(nonatomic,copy)void (^name)(__VA_ARGS__);

//Hud
#define HudShowString(x)            [SVProgressHUD showInfoWithStatus:x];
#define HudShowError(x)             [SVProgressHUD showErrorWithStatus:x];
#define HudDismiss                  [SVProgressHUD dismiss];
#define HudShowSuccess(x)           [SVProgressHUD showSuccessWithStatus:x];
#define HudShowStatus(x)            [SVProgressHUD showWithStatus:x];


//#gragma mark - 路由分组
#define kRouteFirstScheme     @"kRouteFirstScheme"
#define kRouteSecondScheme    @"kRouteSecondScheme"
#define kRouteThridScheme     @"kRouteThridScheme"
#define kRouteFourthScheme    @"kRouteFourthScheme"
#define kRouteFifthScheme     @"kRouteFifthScheme"
#define kRouteLoginScheme     @"kRouteLoginScheme"



//#gragma mark - 通用的通知
///用户退出登录通知
#define NotificationUserLogout          @"NotificationTokenInvalidOrLogout"
///服务器清除当前房间状态
#define NotificationClearUserState      @"NotificationClearUserState"
///消息已读变更通知
#define NotificationUpdateStatus        @"NotificationUpdateStatus"
///用户信息更新
#define NotificationUserInfoUpdate      @"NotificationUserInfoUpdate"



#endif /* BaseMacroDefinition_h */


#ifndef __OPTIMIZE__
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s] line:%d %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define NSLog(...)
#endif
