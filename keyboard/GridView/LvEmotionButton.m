//
//  LvEmotionButton.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/6.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "LvEmotionButton.h"

@implementation LvEmotionButton

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)setEmotion:(EmotionModel *)emotion {
    _emotion = emotion;
    if (emotion.code) {
        [self setTitle:emotion.emoj forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }else {
        [self setTitle:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
}

@end
