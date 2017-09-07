//
//  EmotionModel.h
//  keyboard
//
//  Created by 满艺网 on 2017/9/4.
//  Copyright © 2017年 满艺网. All rights reserved.
//
/*********          表情模型           *********/

#import <Foundation/Foundation.h>

@interface EmotionModel : NSObject 

@property (nonatomic ,copy) NSString *chs;//简体中文描述
@property (nonatomic ,copy) NSString *cht;//繁体中文描述
@property (nonatomic ,copy) NSString *gif;//gif
@property (nonatomic ,copy) NSString *png;//图片

@property (nonatomic ,copy) NSString *type;//类型
@property (nonatomic ,copy) NSString *code;//Emoj的时候需要用到

@property (nonatomic ,copy) NSString *emoj;//emoj表情

@property (nonatomic ,copy) NSString *direc;

@end
