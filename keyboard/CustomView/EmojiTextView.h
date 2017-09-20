//
//  EmojiTextView.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/19.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "PlaceHolderTextView.h"
@class EmotionModel;
@interface EmojiTextView : PlaceHolderTextView
/**
 *  表情模型
 */
@property (nonatomic ,strong) EmotionModel *emotionModel;
/**
 *  上传服务器的模型
 */
- (NSString *)realText;
@end
