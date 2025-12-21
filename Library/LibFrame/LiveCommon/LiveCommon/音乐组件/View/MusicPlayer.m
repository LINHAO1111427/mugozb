//
//  MusicPlayer.m
//  TCDemo
//
//  Created by CH on 2019/10/23.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MusicPlayer.h"
#import <UIKit/UIKit.h>

#import <LibTools/LibTools.h>

@interface MusicPlayer()

/// 显示选择音乐列表的view
@property(nonatomic,strong) UIView *selectMusicView;

/// 显示播放的音乐view
@property(nonatomic,strong) UIView *playerView;

/// 音乐播放器
@property(nonatomic,strong) UIView *musicPlayer;

/// 音乐选择器
@property(nonatomic,strong) UIView *musicSelecter;

/// 搜索框
@property(nonatomic,strong)UISearchBar *searchView;

/// 弹出播放音乐列表的背景view
@property(nonatomic,strong) UIView *listBgView;


@end

#define kSelectListViewWidth kScreenWidth - 100


@implementation MusicPlayer


// MARK: - Init
- (instancetype)initWithSelectMusicListView:(UIView *)selectMusicView
                         playerView:(UIView *)playerView{
    self = [super init];
    if (self) {
        _playerView = playerView;
        _selectMusicView = selectMusicView;
    }
    return self;

}

// MARK: - Public
// MARK: 显示选择列表view
- (void)showSelectView{
    [self.selectMusicView addSubview:self.listBgView];
}

// MARK: 显示播放器view
- (void)showMusicPlayer{
    
}

// MARK: - Private
// MARK: 关闭播放器
- (void)clickClosePlayer{
    
}


// MARK: - lazy
- (UISearchBar *)searchView{
    if (_searchView == nil) {
        _searchView = [[UISearchBar alloc]initWithFrame:
                       CGRectMake(0, 0, kSelectListViewWidth, 44)];
        _searchView.placeholder = kLocalizationMsg(@"搜索歌曲名称");
        _searchView.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchView;
}

- (UIView *)listBgView{
    if (_listBgView == nil) {
        _listBgView = [[UIView alloc] initWithFrame:_selectMusicView.bounds];
    }
    return _listBgView;
}
@end
