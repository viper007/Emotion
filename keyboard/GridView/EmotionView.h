//
//  EmotionView.h
//  keyboard
//
//  Created by 满艺网 on 2017/8/15.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionView : UIView

/** @property 表情  */
@property (nonatomic ,strong) NSArray *emotions;

@property (nonatomic ,copy) void (^emotionBlock)(NSString *title);
@end
