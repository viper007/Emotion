//
//  LvMagnifierWindow.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/6.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LvEmotionButton;
@interface LvMagnifierWindow : UIView

+ (instancetype)magnifierView;
/**
 *  展示Emotion
 */
- (void)showEmotion:(LvEmotionButton *)emotionView;
/**
 *  dismiss
 */
- (void)dismiss;

@end
