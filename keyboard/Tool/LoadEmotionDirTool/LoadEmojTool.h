//
//  LoadEmojTool.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/4.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadEmojTool : NSObject
/**
 *  @property 默认表情
 */
+ (NSArray *)loadDefaultEmotions;
/**
 *  @property Emoj表情
 */
+ (NSArray *)loadEmojEmotions ;
/**
 *  @property lxh表情
 */
+ (NSArray *)loadLxhEmotions ;
@end
