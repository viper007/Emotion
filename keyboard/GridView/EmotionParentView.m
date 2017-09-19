//
//  EmotionParentView.m
//  keyboard
//
//  Created by 满艺网 on 2017/8/15.
//  Copyright © 2017年 满艺网. All rights reserved.
//



#import "EmotionParentView.h"
#import "LvChatToolBar.h"
#import "LoadEmojTool.h"
#import "EmotionListView.h"
@interface EmotionParentView () <LvChatToolBarDelegate>


@property (nonatomic ,weak) LvChatToolBar  *toolbar;


@property (nonatomic ,strong) EmotionListView *listView;

@end

@implementation EmotionParentView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    EmotionListView *listView = [[EmotionListView alloc] init];
    [self addSubview:listView];
    self.listView = listView;
    
    LvChatToolBar *toolBar = [LvChatToolBar toolbar];
    toolBar.delegate = self;
    [self addSubview:toolBar];
    self.toolbar = toolBar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    CGFloat height = 44;
    CGFloat y = self.frame.size.height - height;
    self.toolbar.frame = CGRectMake(0, y, self.frame.size.width, height);
    self.listView.frame = CGRectMake(0, 0, self.frame.size.width, y);
}

#pragma mark - Outside Method

#pragma mark - toolbar delegate
- (void)chatToolBar:(LvChatToolBar *)toolBar clickButtonType:(EmotionType)emotionType {
    switch (emotionType) {
        case EmotionTypeDefault:
        {
            self.listView.emotions = [LoadEmojTool loadDefaultEmotions];
        }
            break;
        case EmotionTypeEmoji:
        {
            self.listView.emotions = [LoadEmojTool loadEmojEmotions];
        }
            break;
        case EmotionTypeLxh:
        {
            self.listView.emotions = [LoadEmojTool loadLxhEmotions];
        }
            break;
        default:
            break;
    }
}
@end
