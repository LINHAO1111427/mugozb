//
//  HomeOneByCollectionViewCell.m
//  LibProjView
//
//  Created by KLC on 2020/7/15.
//  Copyright © 2020 . All rights reserved.
//

#import "HomeOneByCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <LibProjModel/AppHomeHallDTOModel.h>
#pragma mark - 一对一
@interface HomeOneByCollectionViewCell()

@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UIView *statusPoint;
@property(nonatomic,strong)UILabel *addressL;

@end

@implementation HomeOneByCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.clipsToBounds = YES;
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 10.0;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView = imgV;
    [self.contentView addSubview:self.bgImageView];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UIImageView *coverV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homepage_live_cover"]];
    [imgV addSubview:coverV];
    [coverV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(imgV);
    }];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(1, 1);
    gradient.endPoint = CGPointMake(1, 0.3);
    gradient.frame = self.bgImageView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) kRGBA_COLOR(@"#696969", 0.5).CGColor,(id) kRGBA_COLOR(@"#696969", 0.0).CGColor,nil];
    [self.bgImageView.layer insertSublayer:gradient atIndex:0];
    
    UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 8, 8)];
    pointView.layer.cornerRadius = 4;
    pointView.clipsToBounds = YES;
    pointView.backgroundColor = [UIColor greenColor];
    self.statusPoint = pointView;
    [imgV addSubview:self.statusPoint];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameL = nameLabel;
    [imgV addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgV).inset(7);
        make.bottom.equalTo(imgV).inset(7);
    }];
    
    UILabel *addressL = [[UILabel alloc] init];
    addressL.textColor = [UIColor whiteColor];
    addressL.textAlignment = NSTextAlignmentRight;
    addressL.font = [UIFont systemFontOfSize:14];
    self.addressL = addressL;
    [imgV addSubview:addressL];
    [addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(imgV).inset(5);
        make.left.equalTo(pointView.mas_right).inset(5);
    }];
    
    
}


- (void)setModel:(AppHomeHallDTOModel *)model{
    if (![model isKindOfClass:[AppHomeHallDTOModel class]]) {
        return;
    }
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.sourceCover] placeholderImage:PlaholderImage];
    self.nameL.text = model.username;
    UIColor *color;
    if (model.sourceState == 0) {
        color = [UIColor darkGrayColor];
    }else if (model.sourceState == 1){
        color = [UIColor redColor];
    }else if (model.sourceState == 2){
        color = [UIColor greenColor];
    }else if (model.sourceState == 3){
        color = [UIColor blueColor];
    }else if (model.sourceState == 4){
        color = [UIColor redColor];
    }else if (model.sourceState == 5){
        color = [UIColor redColor];
    }else if (model.sourceState == 6){
        color = [UIColor blueColor];
    }else{
        color = [UIColor lightGrayColor];
    }
    self.statusPoint.backgroundColor = color;

    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance] && model.whetherEnablePositioningShow == 0) {
        _addressL.hidden = NO;
        ///显示地址
        _addressL.text = (model.city.length > 0)?model.city:nil;
    }else{
        _addressL.hidden = YES;
    }
    
}


@end
