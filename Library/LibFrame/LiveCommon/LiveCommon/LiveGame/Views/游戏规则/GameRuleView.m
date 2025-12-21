//
//  GameRuleView.m
//  LibProjView
//
//  Created by klc_sl on 2020/7/16.
//  Copyright © 2020 . All rights reserved.
//

#import "GameRuleView.h"
#import <LibProjModel/HttpApiGame.h>
#import <LibTools/LibTools.h>
#import <LibProjView/FunctionSheetBaseView.h>

@interface GameRuleView ()

@property (nonatomic, weak)UITextView *textV;

@end

@implementation GameRuleView


+ (void)showRule:(int)type title:(nonnull NSString *)title{
    
    GameRuleView *rule = [[GameRuleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3.0/5.0-50)];
    [rule createUI];
    [rule getRule:type];
    [FunctionSheetBaseView showTitle:title detailView:rule cover:NO];
}

- (void)createUI{
    
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 5, self.frame.size.width-24, self.frame.size.height-10)];
    textV.editable = NO;
    textV.selectable = NO;
    textV.font = [UIFont systemFontOfSize:13];
    textV.textColor = kRGB_COLOR(@"#666666");
    textV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:textV];
    _textV = textV;
}


///获得玩法说明数据
- (void)getRule:(int)type{
    kWeakSelf(self);
    [HttpApiGame getGameKind:type callback:^(int code, NSString *strMsg, GameKindModel *model) {
        if (code == 1) {
            [weakself showText:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)showText:(GameKindModel *)gameModel{
    
    NSString *str = gameModel.gameExplain;
    
    if (gameModel.specialNote.length > 0) {
        str = [str stringByAppendingString:kLocalizationMsg(@"\n特别说明\n")];
        str = [str stringByAppendingString:gameModel.specialNote];
        str = [str stringByAppendingString:@"\n\n"];
    }
    
    self.textV.attributedText = [str lineSpace:5.0];
    
}


@end
