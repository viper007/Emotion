//
//  LvChatToolBar.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/5.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "LvChatToolBar.h"

@interface LvChatToolBar ()

@property (nonatomic ,strong) UIButton *preButton;

@end

@implementation LvChatToolBar

+ (instancetype)toolbar {
    return [[self alloc] init];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.preButton = [self setupButton:@"默认" backImage:@"compose_emotion_table_left_normal" selectedImage:@"compose_emotion_table_left_selected" target:self select:@selector(clickDefalt:)];
        [self setupButton:@"emoji" backImage:@"compose_emotion_table_mid_normal" selectedImage:@"compose_emotion_table_mid_selected"  target:self select:@selector(clickEmoji:)];
        [self setupButton:@"浪小花" backImage:@"compose_emotion_table_right_normal" selectedImage:@"compose_emotion_table_right_selected"  target:self select:@selector(clickLxh:)];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.subviews.count;
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame = CGRectMake(idx * width, 0, width, 44);
    }];
}

#pragma mark - Inner Method
- (UIButton *)setupButton:(NSString *)title backImage:(NSString *)backImage selectedImage:(NSString *)highImage target:(id)target select:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    //[btn setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateSelected];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

#pragma mark - Action
- (void)clickDefalt:(UIButton *)sender {
    self.preButton.selected = NO;
    sender.selected = YES;
    self.preButton = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBar:clickButtonType:)]) {
        [self.delegate chatToolBar:self clickButtonType:EmotionTypeDefault];
    }
}
- (void)clickEmoji:(UIButton *)sender {
    self.preButton.selected = NO;
    sender.selected = YES;
    self.preButton = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBar:clickButtonType:)]) {
        [self.delegate chatToolBar:self clickButtonType:EmotionTypeEmoji];
    }
}
- (void)clickLxh:(UIButton *)sender {
    self.preButton.selected = NO;
    sender.selected = YES;
    self.preButton = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBar:clickButtonType:)]) {
        [self.delegate chatToolBar:self clickButtonType:EmotionTypeLxh];
    }
}

#pragma mark - setter Delegate
- (void)setDelegate:(id<LvChatToolBarDelegate>)delegate {
    _delegate = delegate;
    //默认选中对应的按钮
    [self clickDefalt:self.preButton];
}
@end
