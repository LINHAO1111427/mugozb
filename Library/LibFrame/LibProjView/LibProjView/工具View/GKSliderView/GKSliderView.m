//
//  GKSliderView.m
//  GKSliderView
//
//  Created by QuintGao on 2017/9/6.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKSliderView.h"

/** 滑块的大小 */
#define kSliderBtnWH  19.0
/** 间距 */
#define kProgressMargin 10.0
/** 进度的宽度 */
#define kProgressW    self.frame.size.width - kProgressMargin * 2
/** 进度的高度 */
#define kProgressH    3.0

@interface GKSliderView()

/** 进度背景 */
@property (nonatomic, strong) UIImageView *bgProgressView;
/** 缓存进度 */
@property (nonatomic, strong) UIImageView *bufferProgressView;
/** 滑动进度 */
@property (nonatomic, strong) UIImageView *sliderProgressView;

/** 滑块 */
@property (nonatomic, strong) GKSliderButton *sliderBtn;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation GKSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.allowTapped = YES;
        
        [self addSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.allowTapped = YES;
    
    [self addSubViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.value = _value;

}

/**
 添加子视图
 */
- (void)addSubViews {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.bgProgressView];
    [self addSubview:self.bufferProgressView];
    [self addSubview:self.sliderProgressView];
    [self addSubview:self.sliderBtn];
    
    // 初始化frame
    [self.bgProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(kProgressMargin);
        make.height.mas_equalTo(kProgressH);
        make.centerY.equalTo(self);
    }];
    [self.bufferProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.bgProgressView);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(kProgressH);
    }];
    
    [self.sliderProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.bgProgressView);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(kProgressH);
    }];
    
    [self.sliderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kSliderBtnWH,kSliderBtnWH));
        make.left.equalTo(self.sliderProgressView.mas_right).offset(-kSliderBtnWH/2.0);
        make.centerY.equalTo(self.sliderProgressView);
    }];
    
    // 添加点击手势
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGesture];
}

#pragma mark - Setter
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _maximumTrackTintColor = maximumTrackTintColor;
    
    self.bgProgressView.backgroundColor = maximumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    _minimumTrackTintColor = minimumTrackTintColor;
    
    self.sliderProgressView.backgroundColor = minimumTrackTintColor;
}

- (void)setBufferTrackTintColor:(UIColor *)bufferTrackTintColor {
    _bufferTrackTintColor = bufferTrackTintColor;
    
    self.bufferProgressView.backgroundColor = bufferTrackTintColor;
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    _maximumTrackImage = maximumTrackImage;
    
    self.bgProgressView.image = maximumTrackImage;
    self.maximumTrackTintColor = [UIColor clearColor];
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    _minimumTrackImage = minimumTrackImage;
    
    self.sliderProgressView.image = minimumTrackImage;
    
    self.minimumTrackTintColor = [UIColor clearColor];
}

- (void)setBufferTrackImage:(UIImage *)bufferTrackImage {
    _bufferTrackImage = bufferTrackImage;
    
    self.bufferProgressView.image = bufferTrackImage;
    
    self.bufferTrackTintColor = [UIColor clearColor];
}

- (void)setValue:(float)value {
    _value = value;

    CGFloat finishValue  = self.bgProgressView.width * value;
    [self.sliderProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(finishValue);
    }];
    
}

- (void)setBufferValue:(float)bufferValue {
    _bufferValue = bufferValue;
    
    CGFloat finishValue = self.bgProgressView.width * bufferValue;
    [self.bufferProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(finishValue);
    }];
    
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setBackgroundImage:image forState:state];
    
    [self.sliderBtn sizeToFit];
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    [self.sliderBtn setImage:image forState:state];
    
    [self.sliderBtn sizeToFit];
}


- (void)setAllowTapped:(BOOL)allowTapped {
    _allowTapped = allowTapped;
    
    if (!allowTapped) {
        [self removeGestureRecognizer:self.tapGesture];
    }
}

- (void)setSliderHeight:(CGFloat)sliderHeight {
    _sliderHeight = sliderHeight;
    
    [self.bgProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sliderHeight);
    }];
    [self.bufferProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sliderHeight);
    }];
    [self.sliderProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(sliderHeight);
    }];
}

- (void)setIsHideSliderBlock:(BOOL)isHideSliderBlock {
    _isHideSliderBlock = isHideSliderBlock;
    
    // 隐藏滑块，滑杆不可点击
    if (isHideSliderBlock) {
        self.sliderBtn.hidden = YES;
        self.allowTapped = NO;
    }
}

#pragma mark - User Action
- (void)sliderBtnTouchBegin:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(sliderTouchBegan:)]) {
        [self.delegate sliderTouchBegan:self.value];
    }
}

- (void)sliderBtnTouchEnded:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(sliderTouchEnded:)]) {
        [self.delegate sliderTouchEnded:self.value];
    }
}

- (void)sliderBtnDragMoving:(UIButton *)btn event:(UIEvent *)event {
    
    // 点击的位置
    CGPoint point = [event.allTouches.anyObject locationInView:self];
    
    // 获取进度值 由于btn是从 0-(self.width - btn.width)
    float value = (point.x - btn.width * 0.5) / (self.width - btn.width);
    
    // value的值需在0-1之间
    value = value >= 1.0 ? 1.0 : value <= 0.0 ? 0.0 : value;
    
    [self setValue:value];

    if ([self.delegate respondsToSelector:@selector(sliderValueChanged:)]) {
        [self.delegate sliderValueChanged:value];
    }
}

- (void)tapped:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    
    // 获取进度
    float value = (point.x - self.bgProgressView.x) * 1.0 / self.bgProgressView.width;
    value = value >= 1.0 ? 1.0 : value <= 0 ? 0 : value;
    
    [self setValue:value];
    
    if ([self.delegate respondsToSelector:@selector(sliderTapped:)]) {
        [self.delegate sliderTapped:value];
    }
}

#pragma mark - 懒加载
- (UIView *)bgProgressView {
    if (!_bgProgressView) {
        _bgProgressView = [UIImageView new];
        _bgProgressView.backgroundColor = [UIColor grayColor];
        _bgProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _bgProgressView.clipsToBounds = YES;
    }
    return _bgProgressView;
}

- (UIView *)bufferProgressView {
    if (!_bufferProgressView) {
        _bufferProgressView = [UIImageView new];
        _bufferProgressView.backgroundColor = [UIColor whiteColor];
        _bufferProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _bufferProgressView.clipsToBounds = YES;
    }
    return _bufferProgressView;
}

- (UIView *)sliderProgressView {
    if (!_sliderProgressView) {
        _sliderProgressView = [UIImageView new];
        _sliderProgressView.backgroundColor = [UIColor redColor];
        _sliderProgressView.contentMode = UIViewContentModeScaleAspectFill;
        _sliderProgressView.clipsToBounds = YES;
    }
    return _sliderProgressView;
}

- (GKSliderButton *)sliderBtn {
    if (!_sliderBtn) {
        _sliderBtn = [GKSliderButton new];
//        _sliderBtn.backgroundColor = [UIColor whiteColor];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchBegin:) forControlEvents:UIControlEventTouchDown];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchCancel];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
        [_sliderBtn addTarget:self action:@selector(sliderBtnTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
        [_sliderBtn addTarget:self action:@selector(sliderBtnDragMoving:event:) forControlEvents:UIControlEventTouchDragInside];
    }
    return _sliderBtn;
}

@end

@interface GKSliderButton()

@end

@implementation GKSliderButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

// 重写此方法将按钮的点击范围扩大
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    
    // 扩大点击区域
    bounds = CGRectInset(bounds, -20, -20);
    
    // 若点击的点在新的bounds里面。就返回yes
    return CGRectContainsPoint(bounds, point);
}

@end


