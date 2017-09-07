//
//  LvChatToolBar.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/5.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LvChatToolBar;
typedef NS_ENUM(NSUInteger , EmotionType){
    EmotionTypeDefault,
    EmotionTypeEmoji,
    EmotionTypeLxh,
};

@protocol LvChatToolBarDelegate <NSObject>

@optional
- (void)chatToolBar:(LvChatToolBar *)toolBar clickButtonType:(EmotionType)emotionType;

@end

@interface LvChatToolBar : UIView


+ (instancetype)toolbar;
@property (nonatomic ,weak) id<LvChatToolBarDelegate> delegate;
@end
