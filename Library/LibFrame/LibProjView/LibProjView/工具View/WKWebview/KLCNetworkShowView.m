//
//  KLCNetworkShowView.m
//  LibProjView
//
//  Created by klc_sl on 2020/8/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "KLCNetworkShowView.h"
#import <Masonry/Masonry.h>



@interface KLCNetworkShowView () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
///1 服务器请求的网址（+uid+token）   2 本地HTML    3 完整链接（不需要添加任何）
@property (nonatomic, assign)int requestType;

@property (nonatomic, weak)UIProgressView *weakProgressV;
@property (nonatomic, strong)NSMutableDictionary<NSString *,handlerBlock> *scriptObj;
@property (nonatomic, weak)WKUserContentController *userContentController;

@property (nonatomic, copy) NSString *requestUrl;

@property (nonatomic, copy) NSString *localHTML;

@end


@implementation KLCNetworkShowView


- (NSMutableDictionary *)scriptObj{
    if (!_scriptObj) {
        _scriptObj = [[NSMutableDictionary alloc] init];
    }
    return _scriptObj;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initWebData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWebData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self initWebData];
    }
    return self;
}


- (UIProgressView *)weakProgressV{
    if (!_weakProgressV) {
        ///进度条
        UIProgressView *progressV = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
        progressV.frame = CGRectMake(0, 0, kScreenWidth, 0);
        progressV.clipsToBounds = YES;
        progressV.trackTintColor = [UIColor clearColor];
        [self addSubview:progressV];
        [self bringSubviewToFront:progressV];
        _weakProgressV = progressV;
    }
    return _weakProgressV;
}

- (WKWebViewConfiguration *)getWebConfiguration{
    ///WKWebView
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    [userContentController addScriptMessageHandler:self name:@"recharge"];
    _userContentController = userContentController;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = [WKPreferences new];
    config.preferences.minimumFontSize = 12;
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;

    config.userContentController = userContentController;
    return config;
}

- (void)initWebData{
    if (!_webView) {
        WKWebView *webV = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[self getWebConfiguration]];
        webV.scrollView.bounces = NO;
        webV.navigationDelegate = self;
        webV.UIDelegate = self;
        [webV.scrollView setShowsVerticalScrollIndicator:NO];
        [webV.scrollView setShowsHorizontalScrollIndicator:NO];
        [webV sizeToFit];
        [webV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [webV addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:webV];
        _webView = webV;
        [webV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
    [_webView removeObserver:self forKeyPath:@"title" context:nil];
    if (_scriptObj.count) {
        for (NSString *name in _scriptObj.allKeys) {
            [_userContentController removeScriptMessageHandlerForName:name];
        }
    }
    [_webView removeFromSuperview];
    _webView = nil;
    [_scriptObj removeAllObjects];
    _scriptObj = nil;
}

- (void)loadRequestUrl:(NSString *)url{
    _requestType = 1;
    _requestUrl = url;
    if (url.length == 0) {
       // NSLog(@"过滤文字没有显示的Url地址"));
        return;
    }
    self.weakProgressV.hidden = !_showProgressLine;
    
    NSMutableString *requestUrl = [url mutableCopy];
    if (![requestUrl hasPrefix:@"http://"] && ![requestUrl hasPrefix:@"https://"]) {
        [requestUrl insertString:@"/" atIndex:0];
        [requestUrl insertString:[ProjConfig baseUrl] atIndex:0];
    }
    if (![requestUrl containsString:@"?"]) {
        [requestUrl appendString:@"?"];
    }
    if (![requestUrl containsString:@"_uid_"]) {
        if (![requestUrl hasSuffix:@"?"]) {
            [requestUrl appendString:@"&"];
        }
        [requestUrl appendFormat:@"_uid_=%lld",[ProjConfig userId]];
    }
    if (![requestUrl containsString:@"_token_"]) {
        [requestUrl appendFormat:@"&_token_=%@",[ProjConfig userToken]];
    }
   // NSLog(@"过滤文字请求的接口地址%@"),requestUrl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    [request addValue:[NSString stringWithFormat:@"_uid_=%lld;_token_=%@",[KLCUserInfo getUserId],[KLCUserInfo getUserToken]] forHTTPHeaderField:@"cookie"];
    [self.webView loadRequest:request];
}

- (void)loadLocalHTML:(NSString *)html{
    _requestType = 2;
    _localHTML = html;
    self.weakProgressV.hidden = !_showProgressLine;
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
    [self.webView loadHTMLString:[headerString stringByAppendingString:html] baseURL:nil];
}

- (void)loadCompleteLinks:(NSString *)url{
    _requestType = 3;
    _requestUrl = url;
    [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)reloadData{
    switch (_requestType) {
        case 1:
        {
            [self loadRequestUrl:_requestUrl];
        }
            break;
        case 2:
        {
            [self loadLocalHTML:_localHTML];
        }
            break;
        case 3:
        {
            [self loadCompleteLinks:_requestUrl];
        }
            break;
        default:
            break;
    }
}


- (void)addScriptName:(NSString *)name messageHandler:(handlerBlock)handler {
    [_userContentController addScriptMessageHandler:self name:name];
    [self.scriptObj setObject:handler forKey:name];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            CGFloat progressNum = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            if (self.progressBlock) {
                self.progressBlock(progressNum);
            }
            if (_showProgressLine) {
                self.weakProgressV.alpha = 1.0f;
                [self.weakProgressV setProgress:progressNum animated:YES];
                kWeakSelf(self);
                if (progressNum >= 1.0) {
                    [self.weakProgressV setProgress:1 animated:YES];
                    [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        weakself.weakProgressV.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [weakself.weakProgressV setProgress:0 animated:NO];
                    }];
                }
            }
        }
        if ([keyPath isEqualToString:@"title"]) {
           // NSLog(@"过滤文字~~webview标题~~%@~~~"),self.webView.title);
            if (self.webView.title.length > 0 && _titleBlock) {
                _titleBlock(self.webView.title);
            }
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
  // NSLog(@"过滤文字~~~~~~~~~加载完了~~~~~~~~~~"));
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 允许链接跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    // 获取新页面的URL
    NSString *url = navigationAction.request.URL.absoluteString;
   // NSLog(@"过滤文字url==%@"),url);
    if (![url isEqualToString:@"www."]) {
        //从字符A中分隔成2个元素的数组
        NSArray *array = [url componentsSeparatedByString:@"id="];
       // NSLog(@"过滤文字array:%@"),array);
    }else{
        
    }
}

#pragma mark - WKScriptMessageHandler -
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
   // NSLog(@"过滤文字=====1==========="));
   // NSLog(@"过滤文字message.body%@"),message.body);
   // NSLog(@"过滤文字message.name:%@"),message.name);
    
    handlerBlock handle = self.scriptObj[message.name];
    if (handle) {
        handle(message.body);
    }
}


@end
