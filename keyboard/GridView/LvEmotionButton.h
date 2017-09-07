//
//  LvEmotionButton.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/6.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;
@interface LvEmotionButton : UIButton
/**
 *  emotionModel
 */
@property (nonatomic ,strong) EmotionModel *emotion;
@end
