//
//  PlaceHolderTextView.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/7.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView

@property (nonatomic ,strong) PlaceHolderTextView *(^placeholderColorBlock) (UIColor *placeholderColor);
@property (nonatomic ,strong) PlaceHolderTextView *(^placeholderTextBlock) (NSString *text);
@end
