//
//  ShowMsgPictureView.m
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import "ShowMsgPictureView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/PopupTool.h>
#import <SDWebImage/SDWebImage.h>



@interface ShowMsgPictureView()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) int timeDown;
@property (nonatomic, strong) UILabel *timeL;

@end

@implementation ShowMsgPictureView
 
+ (void)showOncePic:(UIView *)origin isOwner:(BOOL)isOwner picUrl:(NSString *)picUrl showBlock:(void (^)(BOOL))block {
    UIView *picView = [PopupTool getPopupViewForClass:self];
    if (!picView) {
        ShowMsgPictureView *picV = [[ShowMsgPictureView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [[PopupTool share] createPopupViewWithLinkView:picV allowTapOutside:NO];
        picV.showBlock = block;
        [picV createUI:picUrl isOwner:isOwner originView:origin];
    }
}


- (void)createUI:(NSString *)picUrl isOwner:(BOOL)isOwner originView:(UIView *)originView{
    
    self.alpha = 0;
    self.backgroundColor = [UIColor blackColor];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _oldframe = [originView convertRect:originView.bounds toView:window];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imgV];
    imgV.clipsToBounds = YES;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [imgV sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    
    self.imgV = imgV;
    
    if (isOwner) {
        
        self.animationV = imgV;
        
    }else{
        
        imgV.hidden = YES;
        
        UIView *coverV = [[UIView alloc] initWithFrame:self.bounds];
        coverV.clipsToBounds = YES;
        coverV.backgroundColor = [UIColor whiteColor];
        [self addSubview:coverV];
        _coverV = coverV;
        
        self.animationV = coverV;
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight+60, coverV.width, 30+60+120+30+50)];
        [_coverV addSubview:tempView];
        _tempTransformV = tempView;
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tempView.width, 30)];
        titleL.text = kLocalizationMsg(@"阅后即焚");
        titleL.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor = kRGB_COLOR(@"666666");
        [tempView addSubview:titleL];
        
        UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake((tempView.width-120)/2.0, titleL.maxY+60, 120, 120)];
        iconV.image = [UIImage imageNamed:@"message_oncePic_show"];
        iconV.contentMode = UIViewContentModeScaleAspectFit;
        [tempView addSubview:iconV];
        
        UILabel *detailL = [[UILabel alloc] initWithFrame:CGRectMake(0, iconV.maxY+30, tempView.width, 50)];
        detailL.text = kLocalizationMsg(@"按住屏幕查看\n只能查看一次");
        detailL.numberOfLines = 0;
        detailL.font = [UIFont systemFontOfSize:17];
        detailL.textAlignment = NSTextAlignmentCenter;
        detailL.textColor = kRGB_COLOR(@"666666");
        [tempView addSubview:detailL];
        
        UILabel *timeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-75, kNavBarHeight-30, 56, 30)];
        timeL.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
        timeL.textColor  = [UIColor whiteColor];
        timeL.textAlignment = NSTextAlignmentCenter;
        timeL.font = [UIFont systemFontOfSize:16];
        timeL.hidden = YES;
        timeL.text = @"8s";
        self.timeL = timeL;
        [self addSubview:timeL];
    }
    
    {
        
        kWeakSelf(self);
        //        ///先缩小
        //        self.animationV.transform = CGAffineTransformMakeScale(self.oldframe.size.width/self.animationV.width, self.oldframe.size.height/self.animationV.height);
        //        ///再位移
        //        self.animationV.transform  = CGAffineTransformTranslate(self.animationV.transform, self.oldframe.origin.x-self.animationV.x, self.oldframe.origin.y-self.animationV.y);
        //        [UIView animateWithDuration:0.2 animations:^{
        //            weakself.alpha = 1;
        //            weakself.animationV.transform = CGAffineTransformIdentity;
        //        } completion:^(BOOL finished) {
        //            [weakself addPG];
        //        }];
        
        /// show
        self.animationV.frame = self.oldframe;
        self.tempTransformV.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        [UIView animateWithDuration:0.2 animations:^{
            weakself.alpha = 1;
            weakself.animationV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            weakself.tempTransformV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [weakself addPG];
        }];
    }
}

- (void)addPG{
    self.timeDown = 8;
    UILongPressGestureRecognizer *longPG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showPicLongPG:)];
    [self addGestureRecognizer:longPG];
    
    UITapGestureRecognizer *tapPG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCloseView:)];
    [self addGestureRecognizer:tapPG];
    
}

///长按
- (void)showPicLongPG:(UILongPressGestureRecognizer *)longPG{
     
    if (longPG.state == UIGestureRecognizerStateBegan) {
        self.imgV.hidden = NO;
        self.animationV = self.imgV;
        [self.coverV removeFromSuperview];
        self.coverV = nil;
        self.tempTransformV = nil;
        self.timeDown = 8;
        self.timeL.hidden = NO;
        if (self.timer) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
        dispatch_queue_t queue = dispatch_get_main_queue();
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
            dispatch_source_set_timer(self.timer, start, interval, 0);
            //回调
            dispatch_source_set_event_handler(self.timer, ^{
                self.timeDown--;
                if (self.timeDown == 0) {
                    self.showBlock?self.showBlock(YES):nil;
                    [self dismissView];
                }else{
                    self.timeL.text = [NSString stringWithFormat:@"%ds",self.timeDown];
                }
            });
            // 启动定时器
            dispatch_resume(self.timer);
    }
    
    if (longPG.state == UIGestureRecognizerStateEnded) {
        self.showBlock?self.showBlock(YES):nil;
        [self dismissView];
    }
}

///点按
- (void)tapCloseView:(UITapGestureRecognizer *)tap{
    self.showBlock?self.showBlock(NO):nil;
    [self dismissView];
   
}

///销毁
- (void)dismissView{
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timeL.hidden = YES;
        self.timer = nil;
    }
    
    kWeakSelf(self);
    [UIView animateWithDuration:0.2 animations:^{
        weakself.tempTransformV.transform = CGAffineTransformMakeScale(0.01, 0.01);
        weakself.animationV.frame = weakself.oldframe;
        //        ///先缩小
        //        weakself.animationV.transform = CGAffineTransformMakeScale(self.oldframe.size.width/self.animationV.width, self.oldframe.size.height/self.animationV.height);
        //        ///再位移
        //        weakself.animationV.transform  = CGAffineTransformTranslate(self.animationV.transform, self.oldframe.origin.x-self.animationV.x, self.oldframe.origin.y-self.animationV.y);
        
        weakself.alpha = 0;
    } completion:^(BOOL finished) {
        [[PopupTool share] closePopupView:weakself];
    }];
}



+ (void)showImage:(UIView *)origin picUrl:(NSString *)picUrl {
    [ShowMsgPictureView showOncePic:origin isOwner:YES picUrl:picUrl showBlock:nil];
}


@end
