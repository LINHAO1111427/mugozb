//
//  LiveShareView.m
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import "LiveShareView.h"
#import <LibProjBase/MobManager.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImageManager.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/AppShareConfigModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjView/FunctionSheetBaseView.h>

@implementation ShareFunctionItem

+ (instancetype)shareIcon:(UIImage *)icon name:(NSString *)name clickBlock:(void (^)(void))clickBlock {
    return [ShareFunctionItem shareFuncId:0 icon:icon name:name clickBlock:clickBlock];
}

+ (instancetype)shareFuncId:(NSUInteger)funcId icon:(UIImage *)icon name:(NSString *)name clickBlock:(void(^)(void))clickBlock{
    ShareFunctionItem *share = [[ShareFunctionItem alloc] init];
    share.clickBlock = clickBlock;
    share.icon = icon;
    share.name = name;
    share.funcId = funcId;
    return share;
}

///获得分享链接的样式
+ (instancetype)getCopyLinkFunction{
    return [ShareFunctionItem shareFuncId:998 icon:[UIImage imageNamed:@"icon_more_copy_link"] name:kLocalizationMsg(@"复制链接") clickBlock:nil];
}


@end





@interface LiveShareView ()

@property (nonatomic, assign)int type;
@property (nonatomic, assign)int64_t shareId;

@end


@implementation LiveShareView

- (void)dealloc
{
   // NSLog(@"过滤文字分享页面销毁%s"),__func__);
}

//type类型 1:动态 2:直播间 3:App 4:短视频
+ (void)showShareViewForType:(int)type shareId:(int64_t)shareId moreFunction:(NSArray<ShareFunctionItem *> *)func {
    LiveShareView *shareV = [[LiveShareView alloc] init];
    shareV.type = type;
    shareV.shareId = shareId;
    [shareV createUI:func];
}

+ (void)shareForType:(int)type shareId:(int64_t)shareId shareType:(NSInteger)shareType {
    LiveShareView *shareV = [[LiveShareView alloc] init];
    shareV.type = type;
    shareV.shareId = shareId;
    [shareV shareDataForType:shareType];
}


- (void)createUI:(NSArray *)funcArr{
    self.frame = CGRectMake(0, 0, kScreenWidth, 1);
    NSArray *shareArr = [self getShareArray];
    
    CGFloat viewH = 10;
    CGFloat lineH = 80;
    
    CGFloat scale = 120/132.0;
    CGFloat itemW = 80*scale;
                
    kWeakSelf(self);
    if (shareArr.count > 0) {
        UIScrollView *shareScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewH, self.width, lineH)];
        shareScroll.contentSize = CGSizeMake(shareArr.count * itemW, 0);
        [self addSubview:shareScroll];
        for (int i = 0; i< shareArr.count; i++) {
            ShareFunctionItem *funcItem = shareArr[i];
            UIButton *upBtn = [self createBtn:CGRectMake(itemW*i, 0, itemW, lineH) imageName:funcItem.icon title:funcItem.name];
            [shareScroll addSubview:upBtn];
            [upBtn klc_whenTapped:^{
                if (funcItem.clickBlock) {
                    funcItem.clickBlock();
                }
            }];
        }
        viewH += lineH;
    }
    
    if (funcArr.count == 0) {
        funcArr = @[[ShareFunctionItem getCopyLinkFunction]];
    }
    if (funcArr.count > 0) {
        UIScrollView *funcScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewH, self.width, lineH)];
        funcScroll.contentSize = CGSizeMake(funcArr.count * itemW, 0);
        [self addSubview:funcScroll];
        for (int i = 0; i< funcArr.count; i++) {
            ShareFunctionItem *funcItem = funcArr[i];
            UIButton *upBtn = [self createBtn:CGRectMake(itemW*i, 0, itemW, lineH) imageName:funcItem.icon title:funcItem.name];
            [funcScroll addSubview:upBtn];
            [upBtn klc_whenTapped:^{
                if (funcItem.funcId == 998) {
                    [weakself shareDataForType:0];
                }else{
                    if (![ProjConfig isUserLogin]) {
                        [RouteManager routeForName:RN_login_ShowLoginVC currentC:[ProjConfig currentVC]];
                        return;
                    }else{
                        if (funcItem.clickBlock) {
                            funcItem.clickBlock();
                        }
                    }
                    [weakself dismissView];
                }
            }];
        }
        if(viewH > lineH){
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, funcScroll.y, funcScroll.width-30, 0.5)];
            line.backgroundColor = kRGBA_COLOR(@"#999999", 0.5);
            [self addSubview:line];
        }
        viewH += lineH;
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    cancelBtn.frame = CGRectMake(0, viewH, self.width, 50);
    [cancelBtn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    [cancelBtn klc_whenTapped:^{
        [weakself dismissView];
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cancelBtn.width, 0.5)];
    line.backgroundColor = kRGBA_COLOR(@"#999999", 0.5);
    [cancelBtn addSubview:line];
    
    self.height = viewH+cancelBtn.height;
    [FunctionSheetBaseView showView:self cover:YES];
}

- (void)dismissView{
    [FunctionSheetBaseView deletePopView:self];
}

- (UIButton *)createBtn:(CGRect)rect imageName:(UIImage *)image title:(NSString *)title{
    
    UIButton *upBtn = [UIButton buttonWithType:0];
    upBtn.frame = rect;
    UIView *centerV = [[UIView alloc] init];
    centerV.userInteractionEnabled = NO;
    [upBtn addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(upBtn);
    }];
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = image;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [upBtn addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = upBtn.width/5.0*3.0;
        make.size.mas_equalTo(CGSizeMake(width, width));
        make.top.left.right.equalTo(centerV);
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = kRGBA_COLOR(@"333333", 1.0);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.text = title;
    [upBtn addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.top.equalTo(imgV.mas_bottom).mas_offset(5);
        make.bottom.equalTo(centerV);
        make.centerX.equalTo(imgV);
    }];
    
    return upBtn;
}


- (NSArray *)getShareArray{
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [KLCAppConfig shareArray]) {
        kWeakSelf(self);
        ShareFunctionItem *share = [ShareFunctionItem shareIcon:[UIImage imageNamed:dic[@"image"]] name:dic[@"title"] clickBlock:^{
            [weakself shareDataForType:[dic[@"shareType"] integerValue]];
        }];
        [muArr addObject:share];
    }
    return muArr;
}

- (void)shareDataForType:(NSInteger)shareType{
    kWeakSelf(self);
    self.userInteractionEnabled = NO;
    [HttpApiUserController share:self.shareId type:self.type callback:^(int code, NSString *strMsg, ApiShareConfigModel *model) {
        weakself.userInteractionEnabled = YES;
        if (shareType) {
            [MobManager shareType:shareType title:model.shareTitle content:model.shareDes image:model.logo url:model.url shareResult:^(BOOL success) {
                if (success) {
                    [weakself shareCallback];
                }
            }];
        }else{
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = model.url;
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"复制成功")];
        }
        [weakself dismissView];
    }];
}

- (void)shareCallback{
    [HttpApiUserController shareCallback:self.shareId type:self.type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
    }];
}



@end


