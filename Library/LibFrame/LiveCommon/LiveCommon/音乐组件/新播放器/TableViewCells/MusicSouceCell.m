//
//  MusicSouceCell.m
//  LiveCommon
//
//  Created by klc on 2020/8/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MusicSouceCell.h"
#import <SDWebImage/SDWebImage.h>


@interface MusicSouceCell ()


kStrong(UIImageView, coverImv)


kStrong(UILabel, nameLab)
kStrong(UILabel, authorLab)
kStrong(UIButton, addBtn)

kAssign(BOOL, isAdded)//已添加过的

@end

@implementation MusicSouceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    UIView *contentView = self.contentView;
    
    _coverImv = [Maker Imv:nil layerCorner:4 superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(48, 48));
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(12);
    }];
    
    _nameLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(14) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.equalTo(_coverImv);
        make.left.equalTo(_coverImv.mas_right).offset(12);
        make.right.equalTo(contentView).inset(70);
    }];
    
    _authorLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:kRGB_COLOR(@"#AAAAAA") font:kFont(13) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.bottom.equalTo(_coverImv);
        make.left.equalTo(_coverImv.mas_right).offset(12);
        make.right.equalTo(contentView).inset(70);
    }];
    
    _addBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#8A8DFF") text:kLocalizationMsg(@"添加") textColor:[UIColor whiteColor] font:kFont(13) superView:contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(58, 28));
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView).inset(12);
    }];
    _addBtn.layer.cornerRadius = 4;
    [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(AppMusicDTOModel *)model{
    
    _model = model;
    [_coverImv sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"miniPlayer_music_icon"]];
    _nameLab.text = model.name;
    _authorLab.text = model.author;
    self.isAdded = model.added==1;
}
-(void)addAction:(UIButton *)sender{
    
    if (self.addToListHandler) {
        
        self.addToListHandler(_model);
    }
}
-(void)setIsAdded:(BOOL)isAdded{
    
    _isAdded = isAdded;
    [_addBtn setTitle:isAdded?kLocalizationMsg(@"已添加"):kLocalizationMsg(@"添加") forState:0];
    _addBtn.enabled = !isAdded;
    _addBtn.backgroundColor = isAdded?kRGB_COLOR(@"#F0F0F0"):kRGB_COLOR(@"#8A8DFF");
    [_addBtn setTitleColor:isAdded?[UIColor grayColor]:[UIColor whiteColor] forState: 0];
}
@end
