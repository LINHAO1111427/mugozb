//
//  KLCNetworkShowView.h
//  LibProjView
//
//  Created by klc_sl on 2020/8/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^handlerBlock)(id _Nullable messageBody);

@interface KLCNetworkShowView : UIView

@property (nonatomic, weak, readonly)WKWebView *webView;

///显示进度条 （默认不显示）
@property (nonatomic, assign) BOOL showProgressLine;

@property (nonatomic, copy) void(^titleBlock)(NSString *title);

@property (nonatomic, copy) void(^progressBlock)(CGFloat progress);


///重新加载页面
- (void)reloadData;

///添加监听 （可多次添加）
- (void)addScriptName:(NSString *)name messageHandler:(handlerBlock)handler;

///加载服务器的url（自带uid和token）
- (void)loadRequestUrl:(NSString *)url;

///加载本地的html
- (void)loadLocalHTML:(NSString *)html;

///加载完整链接
- (void)loadCompleteLinks:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
