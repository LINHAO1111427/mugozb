//
//  MessageDyListCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import "MessageDyListCell.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiCommentsMsgModel.h>
#import <LibProjView/SWHTapImageView.h>

@interface MessageDyListCell ()
@property(nonatomic,strong)UIImageView *headerImageV;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *commentLab;
@property(nonatomic,strong)UILabel *desLabel;

@property(nonatomic,strong)UIImageView *picImageV;
@property(nonatomic,strong)UIImageView *playImv;
@property(nonatomic,strong)SWHTapImageView *roleImageView;

kStrong(UIButton, respondBtn)
kStrong(UIButton, deleteBtn)
@end
@implementation MessageDyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.backgroundColor = [ProjConfig projBgColor];
          [self creatSubView];
          self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

-(void)creatSubView{
    
    UIView *contenView = self.contentView;
    _headerImageV = [Maker Imv:nil layerCorner:24 superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(48);
        make.left.equalTo(contenView).offset(12);
        make.top.equalTo(contenView).offset(20);
    }];
    
    _nameLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:kRGB_COLOR(@"#9AA3B3") font:kFont(14) superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_headerImageV);
        make.left.equalTo(_headerImageV.mas_right).offset(12);
    }];
    _roleImageView = [[SWHTapImageView alloc]init];
    _roleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [contenView addSubview:_roleImageView];
    [_roleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLab.mas_right);
            make.centerY.equalTo(_nameLab);
            make.width.height.mas_equalTo(20);
        }];
    
    
    _commentLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(13) superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(_nameLab);
        make.top.equalTo(_nameLab.mas_bottom).offset(5);
    }];
    
    _desLabel = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:kRGB_COLOR(@"#AAAAAA") font:kFont(12) superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
    
        make.left.equalTo(_commentLab);
        make.top.equalTo(_commentLab.mas_bottom).offset(5);
    }];
    
    
    _picImageV = [Maker Imv:nil layerCorner:4 superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_headerImageV);
        make.right.equalTo(contenView).inset(15);
        make.size.mas_equalTo(66);
    }];
    
    _playImv = [Maker Imv:ImgNamed(@"message_play") layerCorner:0 superView:_picImageV constraints:^(MASConstraintMaker * _Nonnull make) {

        make.center.equalTo(_picImageV);
    }];
    _playImv.backgroundColor = [UIColor clearColor];
    
    _respondBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#F3F3F3") text:kLocalizationMsg(@"回复") textColor:kRGB_COLOR(@"#9AA3B3") font:kFont(12) superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.left.equalTo(_desLabel);
        make.top.equalTo(_desLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(SIZE(52, 26));
    }];
    _respondBtn.layer.cornerRadius = 13;
    [_respondBtn addTarget:self action:@selector(respondClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#F3F3F3") text:kLocalizationMsg(@"删除") textColor:kRGB_COLOR(@"#FF4A43") font:kFont(12) superView:contenView constraints:^(MASConstraintMaker * _Nonnull make) {

        make.size.centerY.equalTo(_respondBtn);
        make.left.equalTo(_respondBtn.mas_right).offset(18);
    }];
    _deleteBtn.layer.cornerRadius = 13;
    [_deleteBtn addTarget:self action:@selector(deleteClickAction:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)setModel:(ApiCommentsMsgModel *)model{
    _model = model;
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    
    _nameLab.text = model.userName;
    _commentLab.textColor = model.isRead?kRGB_COLOR(@"#9AA3B3"):kRGB_COLOR(@"#AAAAAA");
    _commentLab.text = model.content;
    
    NSString *actionString = model.type == 2?kLocalizationMsg(@"赞"):kLocalizationMsg(@"评论");
    _desLabel.text = kStringFormat(kLocalizationMsg(@"%@ %@了你"),[model.addtime timeStringWithDateFormat:@"MM-dd hh:mm"],actionString);
    
    
    [_picImageV sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[ProjConfig getDefaultImage]];
    _deleteBtn.hidden = model.type==2;
    
    _playImv.hidden = model.sourceType!=1;
    
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:-1 age:-1 role:model.role];
    if (image) {
        self.roleImageView.image = image;
        self.roleImageView.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:model.role];
        };
    }else{
        [self.roleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
}

-(void)respondClickAction:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(respondUserComment:)]) {
        
        [self.delegate respondUserComment:_model];;
    }
}
-(void)deleteClickAction:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteUserComment:)]) {
        
        [self.delegate deleteUserComment:_model];
    }
}


@end
