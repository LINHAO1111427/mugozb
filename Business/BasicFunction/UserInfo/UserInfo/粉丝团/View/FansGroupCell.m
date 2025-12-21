//
//  FansGroupCell.m
//  Fans
//
//  Created by klc on 2020/3/18.
//

#import "FansGroupCell.h"
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjBase/LibProjBase.h>
@interface FansGroupCell ()


@property(nonatomic,strong)UIButton *numBtn; ///排名
@property(nonatomic,strong)UIImageView *headerImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *wealthImageV;
@property(nonatomic,strong)UILabel *coinLabel;

@end

@implementation FansGroupCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)creatSubView{
    
    [self.contentView addSubview:self.numBtn];
    [self.contentView addSubview:self.headerImageV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.wealthImageV];
    [self.contentView addSubview:self.coinLabel];
    
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(65);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.right.equalTo(self.headerImageV.mas_left).offset(-3);
        make.height.mas_equalTo(21);
        make.centerY.equalTo(self.headerImageV);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageV).offset(5);
        make.left.equalTo(self.headerImageV.mas_right).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.wealthImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageV).offset(-5);
        make.left.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-30);
    }];
}

- (UIButton *)numBtn{
    if (!_numBtn) {
        _numBtn = [UIButton buttonWithType:0];
        [_numBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        _numBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _numBtn;
}

- (UIImageView *)headerImageV{
    if (!_headerImageV) {
        _headerImageV = [[UIImageView alloc] init];
        _headerImageV.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageV.layer.masksToBounds = YES;
        _headerImageV.layer.cornerRadius = 25.0;
    }
    return _headerImageV;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor =kRGBA_COLOR(@"#666666", 1.0);
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}


- (UIImageView *)wealthImageV{
    if (!_wealthImageV) {
        _wealthImageV = [[UIImageView alloc] init];
        _wealthImageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _wealthImageV;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] init];
        _coinLabel.textColor =kRGBA_COLOR(@"#333333", 1.0);
        _coinLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _coinLabel;
}



- (void)setRanksModel:(RanksDtoModel *)ranksModel{
    _ranksModel = ranksModel;
    
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:ranksModel.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    
    self.nameLabel.text = ranksModel.username;
    
    [self.wealthImageV sd_setImageWithURL:[NSURL URLWithString:ranksModel.wealthGradeImg]];

    self.coinLabel.attributedText = [[NSString stringWithFormat:@"%.0f",ranksModel.delta] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 15, 15) before:NO];
    
    switch (ranksModel.sort) {
        case 1:
        {
            [self.numBtn setImage:[UIImage imageNamed:@"fans_sort_num1"] forState:UIControlStateNormal];
            [self.numBtn setTitle:@"" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [self.numBtn setImage:[UIImage imageNamed:@"fans_sort_num2"] forState:UIControlStateNormal];
            [self.numBtn setTitle:@"" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [self.numBtn setImage:[UIImage imageNamed:@"fans_sort_num3"] forState:UIControlStateNormal];
            [self.numBtn setTitle:@"" forState:UIControlStateNormal];
        }
            break;
        default:
        {
            [self.numBtn setImage:nil forState:UIControlStateNormal];
            [self.numBtn setTitle:[NSString stringWithFormat:@"%d",ranksModel.sort] forState:UIControlStateNormal];
        }
            break;
    }    
}


@end
