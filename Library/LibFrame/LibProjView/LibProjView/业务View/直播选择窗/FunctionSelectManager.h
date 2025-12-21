//
//  FunctionSelectManager.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, MainFunctionItemType) {
    ///多人视频直播
    MainFunctionForMPVideo,
    ///多人语音直播
    MainFunctionForMPAudio,
    ///发动态（图片+视频）
    MainFunctionForDynamic,
    ///发动态图片
    MainFunctionForDynamicPic,
    ///发动态视频
    MainFunctionForDynamicVideo,
    ///发短视频（图片+视频）
    MainFunctionForShortAll,
    ///拍短视频照片
    MainFunctionForShortPhoto,
    ///发布短视频
    MainFunctionForShortVideo,
};

@class MainFunctionModel;


@interface FunctionSelectManager : NSObject


+ (void)showFunction:(NSArray<MainFunctionModel *> *)function;


///跳转到某一个页面
+ (void)pushViewControllerForType:(MainFunctionItemType)type;
 
@end




@interface MainFunctionModel : NSObject

@property (nonatomic, assign)MainFunctionItemType type;

@property (nonatomic, copy)NSString *title;

///可传可不传
@property (nonatomic, copy,)UIImage *icon;

- (instancetype)initWithType:(MainFunctionItemType)type title:(NSString *_Nullable)title icon:(UIImage *_Nullable)icon;


@end





NS_ASSUME_NONNULL_END
