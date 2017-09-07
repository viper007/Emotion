//
//  LvMagnifierWindow.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/6.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "LvMagnifierWindow.h"
#import "LvEmotionButton.h"
@interface LvMagnifierWindow ()
@property (nonatomic ,strong) UIButton *infoButton;
@end

@implementation LvMagnifierWindow

+ (instancetype)magnifierView {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, 64, 92)];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 64 , 64);
        btn.titleLabel.font = [UIFont systemFontOfSize:32];
        [self addSubview:btn];
        self.infoButton = btn;
    }
    return self;
}

- (void)showEmotion:(LvEmotionButton *)emotionView {
    
     UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
     [window addSubview:self];
    
     if (emotionView.emotion.code) {
        [self.infoButton setTitle:emotionView.emotion.emoj forState:UIControlStateNormal];
        [self.infoButton setImage:nil forState:UIControlStateNormal];
      }else {
        [self.infoButton setTitle:nil forState:UIControlStateNormal];
        [self.infoButton setImage:[UIImage imageNamed:emotionView.emotion.png] forState:UIControlStateNormal];
      }
        CGFloat centerX = emotionView.center.x;
        CGFloat centerY = emotionView.center.y - self.frame.size.height * 0.5;
        CGPoint center = CGPointMake(centerX, centerY);
        self.center = [window convertPoint:center fromView:emotionView.superview];
}

- (void)dismiss {
    [self removeFromSuperview];
}
@end
