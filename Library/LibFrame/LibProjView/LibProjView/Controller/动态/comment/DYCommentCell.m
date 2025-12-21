//
//  SVCommentCell.m
//  ShortVideo
//
//  Created by ssssssss on 2020/6/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DYCommentCell.h"
#import <Masonry/Masonry.h>
#import <LibProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
@interface DYCommentCell()

@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UIImageView *headerImageView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation DYCommentCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        UIView *bgView = [[UIView alloc] init];
//        bgView.backgroundColor = kRGB_COLOR(@"#eeeeee");
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView).inset(0);
        }];
        ///头像
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.layer.cornerRadius = 18;
        headerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:headerImageView];
        headerImageView.userInteractionEnabled = YES;
        _headerImageView = headerImageView;
        kWeakSelf(self);
        [headerImageView klc_whenTapped:^{
            if (weakself.userInfo) {
                weakself.userInfo(weakself.model.uid);
            }
        }];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.width.equalTo(@(36));
            make.height.equalTo(@(36));
            make.left.equalTo(@(16));
        }];
        
        ///名称
        UILabel *nameLabel = [UILabel new];
        nameLabel.numberOfLines = 0;
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = kRGB_COLOR(@"#8035C2");
        nameLabel.userInteractionEnabled = YES;
        [nameLabel klc_whenTapped:^{
            if (weakself.userInfo) {
                weakself.userInfo(weakself.model.uid);
            }
        }];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImageView);
            make.left.equalTo(headerImageView.mas_right).offset(8);
        }];
        
        ///时间
        UILabel *timeLabel = [UILabel new];
        timeLabel.numberOfLines = 0;
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textColor = kRGB_COLOR(@"#666666");
        timeLabel.textAlignment = NSTextAlignmentRight;
        [timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.right.equalTo(self.contentView).offset(-8 -8);
            make.height.equalTo(@(20));
            make.left.equalTo(nameLabel.mas_right);
        }];
        
        ///评论
        UILabel *commentLabel = [UILabel new];
        commentLabel.numberOfLines = 0;
        commentLabel.font = [UIFont systemFontOfSize:14];
        commentLabel.textColor =kRGB_COLOR(@"#666666");
        [self.contentView addSubview:commentLabel];
        _commentLabel = commentLabel;
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(5);
            make.bottom.equalTo(self.contentView).offset(-12);
            make.right.equalTo(timeLabel);
            make.left.equalTo(nameLabel);
        }];
        
        /*长按事件
         UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPressSuperLable:)];
         gesture.minimumPressDuration = 0.5;
         [self.commentLabel addGestureRecognizer:gesture];
         */
    }
    return _bgView;
}

- (void)setModel:(ApiUsersVideoCommentsModel *)model{
    
    _model = model;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    self.timeLabel.text = model.addtimeStr;
    self.nameLabel.text = model.userName;
    
    NSString *text = nil;
    if (model.commentType > 1) {
        text = [NSString stringWithFormat:kLocalizationMsg(@"回复%@: %@"),_model.toUserName, _model.content];
        self.commentLabel.text = text;
    }else{
        text = _model.content;
        self.commentLabel.text = text;
    }
    
    //解析表情
    NSString *contentStr = text;
    NSMutableAttributedString *attstr = [[contentStr changeTextForCostomEmojiAndBounds:CGRectMake(0, -2, 15, 15)] mutableCopy];
    
    //设置颜色
    NSRange boldRange1 = NSMakeRange(2, [_model.toUserName length]);
    
    if (_model.commentType > 1) {
        [attstr addAttribute:NSForegroundColorAttributeName value:kRGB_COLOR(@"#8035C2") range:boldRange1];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2.0; // 设置行间距
//    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attstr.length)];
    
    self.commentLabel.attributedText = attstr;
    
    //添加点击事件
    __weak typeof(self) weakSelf = self;
    NSMutableArray *strArr = [NSMutableArray arrayWithCapacity:1];
    if (![model.toUserName isEmpty] && model.commentType == 2) {
        [strArr addObject:model.toUserName];
    }
    
    [self.commentLabel yb_addAttributeTapActionWithStrings:strArr tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
//        NSString * message = [NSString stringWithFormat:kLocalizationMsg(@"点击了\")%@\"字符\nrange:%@\n在数组中是第%zi个",string,NSStringFromRange(range),index];
        if (weakSelf.userInfo) {
            if (index == 0) {
                weakSelf.userInfo(model.toUid);
            }
        }
    }];
    [self layoutIfNeeded];
}
@end
