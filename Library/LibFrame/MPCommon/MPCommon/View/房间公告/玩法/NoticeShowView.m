//
//  NoticeShowView.m
//  LiveCommon
//
//  Created by klc on 2020/6/11.
//  Copyright © 2020 . All rights reserved.
//

#import "NoticeShowView.h"
#import <LiveCommon/LiveManager.h>
#import <LibTools/LibTools.h>

@implementation NoticeShowView

+ (void)showNotice{
    NoticeShowView *noticeV = (NoticeShowView *)[PopupTool getPopupViewForClass:self];
    if (!noticeV) {
        NoticeShowView *noticeV = [[NoticeShowView alloc] init];
        [[PopupTool share] createPopupViewWithLinkView:noticeV allowTapOutside:YES];
        [noticeV createUI];
    }
}

- (void)createUI{
    
    self.frame = CGRectMake((kScreenWidth-280)/2.0, (kScreenHeight-346)/2.0, 280, 346);
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = [UIColor whiteColor];
    bgV.layer.masksToBounds = YES;
    bgV.layer.cornerRadius = 8.0;
    [self addSubview:bgV];
    
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.width, 16)];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = kLocalizationMsg(@"房间公告");
    titleL.textColor = [UIColor blackColor];
    [self addSubview:titleL];
    

    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(20, 54, 240, 210)];
    textV.selectable = NO;
    textV.textColor = [UIColor blackColor];
    textV.font = [UIFont systemFontOfSize:12];
    textV.layer.masksToBounds = YES;
    textV.layer.cornerRadius = 4.0;
    textV.layer.borderWidth = 1.0;
    textV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    textV.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textV.editable = NO;
    [self addSubview:textV];
    textV.text = [LiveManager liveInfo].roomModel.notice.length > 0 ?[LiveManager liveInfo].roomModel.notice:kLocalizationMsg(@"暂无");
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake((self.width - 160)/2.0, textV.maxY + 24, 160, 34);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 17;
    [btn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setBackgroundImage:[UIImage imageNamed:@"live_btn_purple"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    ///关闭btn
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(bgV.width-30, -40, 30, 30);
    [cancelBtn setImage:[UIImage imageNamed:@"live_guanbi_circle"] forState:UIControlStateNormal];
    [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
}


- (void)sureBtnClick{
    [[PopupTool share] closePopupView:self];
}

- (void)clickCancelBtn{
    [[PopupTool share] closePopupView:self];
}


+ (void)dismiss{
    UIView *selfV = [PopupTool getPopupViewForClass:self];
    [[PopupTool share] closePopupView:selfV];
}


@end
