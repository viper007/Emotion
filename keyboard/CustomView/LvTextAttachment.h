//
//  LvTextAttachment.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/20.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;
@interface LvTextAttachment : NSTextAttachment
/**
 *  表情模型，用来记录富文本，当遍历富文本的时候可以得到对应的文本信息
 */
@property (nonatomic ,strong) EmotionModel *emotionModel;
@end
