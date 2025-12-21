//
//  StoreHomeHeaderView.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreHomeHeaderView.h"
#import "StoreDetailInfoView.h"
#import "StoreLiveInfoView.h"
#import <LibProjModel/ShopBusinessDTOModel.h>

@interface StoreHomeHeaderView()

@property (nonatomic, strong)StoreDetailInfoView *detailInfoView;
@property (nonatomic, strong)StoreLiveInfoView *liveInfoView;
@end

@implementation StoreHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self createUI];
        
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self addSubview:self.detailInfoView];
    [self addSubview:self.liveInfoView];
    self.height = self.detailInfoView.maxY;
}

- (void)setDtoModel:(ShopBusinessDTOModel *)dtoModel {
    _dtoModel = dtoModel;
    
    CGFloat viewH = self.detailInfoView.height;
    if (dtoModel.status) {
        viewH += 10;
        viewH += self.liveInfoView.height;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.height = viewH;
    });
    
    self.detailInfoView.business = dtoModel.business;
    self.liveInfoView.liveRoomId = dtoModel.roomId;
    self.liveInfoView.liveDetailDTO = dtoModel.liveDetailDTO;
}


#pragma mark - lazy load
- (StoreDetailInfoView *)detailInfoView{
    if (!_detailInfoView) {
        _detailInfoView = [[StoreDetailInfoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 115)];
    }
    return _detailInfoView;
}

- (StoreLiveInfoView *)liveInfoView{
    if (!_liveInfoView) {
        CGFloat scale = 126/360.0;
        _liveInfoView = [[StoreLiveInfoView alloc]initWithFrame:CGRectMake(0, _detailInfoView.maxY+10, kScreenWidth, scale*kScreenWidth+42)];
    }
    return _liveInfoView;
}

- (CGFloat)viewHeight{
    return self.height;
}

@end
