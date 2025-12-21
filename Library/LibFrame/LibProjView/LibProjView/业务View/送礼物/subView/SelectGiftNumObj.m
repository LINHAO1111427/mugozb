//
//  SelectGiftNumObj.m
//  youMengLive
//
//  Created by admin on 2019/8/6.
//  Copyright © 2019 cat. All rights reserved.
//

#import "SelectGiftNumObj.h"
#import <LibTools/LibTools.h>
#import <objc/runtime.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/HttpApiNobLiveGift.h>
#import <LibProjModel/GiftAmountSettingModel.h>
#import <Masonry/Masonry.h>

@interface SelectGiftNumObj ()

@property (nonatomic, copy)NSArray<GiftAmountSettingModel *>  *countArray;

@property (nonatomic, weak)UIView *contentV;

@property (nonatomic, weak)UIView *bgView;

@end

@implementation SelectGiftNumObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadGiftNumberList];
    }
    return self;
}

- (void)loadGiftNumberList{
    kWeakSelf(self);
    [HttpApiNobLiveGift getGiftAmountSetting:^(int code, NSString *strMsg, NSArray<GiftAmountSettingModel *> *arr) {
        if (code == 1) {
            weakself.countArray = arr;
        }
    }];
}

- (void)show{
    if (!_bgView) {
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgV.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideGiftCountView)];
        [bgV addGestureRecognizer:tap];
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:bgV];
        _bgView = bgV;
    }
    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.contentV.size);
        make.bottom.equalTo(self.bgView).mas_offset(-(kSafeAreaBottom+50));
        make.right.equalTo(self.bgView).mas_offset(-30);
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    if (_countArray.count > selectIndex && _selectBlock) {
        GiftAmountSettingModel *amountModel = _countArray[selectIndex];
        _selectBlock([NSString stringWithFormat:@"%d",amountModel.numberOfGifts]);
    }
}

- (UIView *)contentV{
    ///内容
    if (!_contentV) {
        UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30*_countArray.count+10)];
        [_bgView addSubview:contentV];
        _contentV = contentV;
        
        UIView *detailV = [[UIView alloc] initWithFrame:contentV.bounds];
        detailV.backgroundColor = [UIColor whiteColor];
        detailV.layer.masksToBounds = YES;
        detailV.layer.cornerRadius = 5;
        [contentV addSubview:detailV];
        UIImageView *arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(14, contentV.maxY, 13, 6)];
        arrowView.image = [UIImage imageNamed:@"gift_nums_arrow"];
        [contentV addSubview:arrowView];
        
        for (int i = 0; i < _countArray.count; i ++) {
            GiftAmountSettingModel *amountModel = _countArray[i];
            UIButton *btn = [UIButton buttonWithType:0];
            btn.tag = 558876+i;
            btn.frame = CGRectMake(0, 5+i*30, detailV.width, 30);
            [btn setTitleColor:[ProjConfig normalColors] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(selectGiftNum:) forControlEvents:UIControlEventTouchUpInside];
            [detailV addSubview:btn];
            
            UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 30, btn.height)];
            numL.text = [NSString stringWithFormat:@"%d",amountModel.numberOfGifts];
            numL.textColor = [ProjConfig normalColors];
            numL.tag = btn.tag+100;
            numL.font = [UIFont systemFontOfSize:12];
            [btn addSubview:numL];
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(numL.maxX+3, 0, btn.width-(numL.maxX+3), btn.height)];
            nameL.text = amountModel.numberDescription;
            nameL.textColor = kRGBA_COLOR(@"#666666", 1.0);
            nameL.font = [UIFont systemFontOfSize:12];
            [btn addSubview:nameL];
        }
    }
    return _contentV;
}

- (void)hideGiftCountView{
    if (_cancelBlock) {
        _cancelBlock();
    }
    [_bgView removeFromSuperview];
}

- (void)selectGiftNum:(UIButton *)sender{
    if (_selectBlock) {
        for (UIView *subV in sender.subviews) {
            if (subV.tag == (sender.tag+100)) {
                UILabel *numL = (UILabel *)subV;
                _selectBlock(numL.text);
            }
        }
    }
    [_bgView removeFromSuperview];
}



@end
