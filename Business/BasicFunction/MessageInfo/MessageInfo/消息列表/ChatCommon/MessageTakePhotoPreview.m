//
//  MessageBurnDownAfterReadPreview.m
//  MessageInfo
//
//  Created by SWH05 on 2022/3/22.
//

#import "MessageTakePhotoPreview.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface MessageTakePhotoPreview()
@property(nonatomic,copy)TakePhotoPreviewCallBack callBack;
@property(nonatomic,strong)UIImage *image;
kAssign(BOOL, isBronDownAfterRead)
@end

@implementation MessageTakePhotoPreview

+ (void)showImageWith:(UIImage *)image callBack:(TakePhotoPreviewCallBack)callBack{
    
    MessageTakePhotoPreview *showView = [[MessageTakePhotoPreview alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    showView.backgroundColor = [UIColor blackColor];
    showView.callBack = callBack;
    showView.image = image;
    [[UIApplication sharedApplication].keyWindow addSubview:showView] ;
    [showView createUI];
    [UIView animateWithDuration:0.3 animations:^{
        showView.y -= kScreenHeight;
    } completion:^(BOOL finished) {
         
    }];
}
- (void)createUI{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
    imageV.backgroundColor = [UIColor clearColor];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.userInteractionEnabled = YES;
    imageV.image = self.image;
    [self addSubview:imageV];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, kNavBarHeight-40, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:backBtn];
    
    //阅后即焚
    UIButton *allowBtn = [UIButton buttonWithType:0];
    allowBtn.frame = CGRectMake(12, kScreenHeight-kTabBarHeight, 100, kTabBarHeight-kSafeAreaBottom);
    [allowBtn setImage:[UIImage imageNamed:@"launch_agree_normal"] forState:UIControlStateNormal];
    [allowBtn setImage:[UIImage imageNamed:@"launch_agree_selected"] forState:UIControlStateSelected];
    [allowBtn setTitle:kLocalizationMsg(@" 阅后即焚") forState:UIControlStateNormal];
    [allowBtn addTarget:self action:@selector(OnceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    allowBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [allowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:allowBtn];
     
    //发送按钮
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-12-50, 0, 50, 30)];
    sendBtn.centerY = allowBtn.centerY;
    sendBtn.layer.cornerRadius = 15;
    sendBtn.clipsToBounds = YES;
    sendBtn.backgroundColor = [ProjConfig normalColors];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitle:kLocalizationMsg(@"发送") forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:sendBtn];
}
- (void)OnceBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.isBronDownAfterRead = btn.selected;
}
                      
- (void)backBtnCLick{
    [UIView animateWithDuration:0.3 animations:^{
        self.y += kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeAllSubViews];
        if (self.callBack) {
            self.callBack(self, self.isBronDownAfterRead, self.image, NO);
        }
    }];
}
- (void)sendBtnClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.y += kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeAllSubViews];
        if (self.callBack) {
            self.callBack(self, self.isBronDownAfterRead, self.image, YES);
        }
    }];
}
@end
