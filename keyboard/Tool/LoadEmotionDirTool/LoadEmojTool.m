//
//  LoadEmojTool.m
//  keyboard
//
//  Created by 满艺网 on 2017/9/4.
//  Copyright © 2017年 满艺网. All rights reserved.
//

#import "LoadEmojTool.h"
#import "EmotionModel.h"

static NSArray *_defalutEmotions;
static NSArray *_emojEmotions;
static NSArray *_lxhEmotions;

@implementation LoadEmojTool

+ (NSArray *)loadDefaultEmotions {
    if (!_defalutEmotions) {
       NSString *filePath = [[NSBundle mainBundle] pathForResource:@"default.plist" ofType:nil];
        _defalutEmotions = [EmotionModel mj_objectArrayWithFile:filePath];
        
//        [_defalutEmotions makeObjectsPerformSelector:@selector(setDirec:) withObject:@"EmotionIcons/default"];
    }
    return _defalutEmotions;
}

+ (NSArray *)loadEmojEmotions {
    if (!_emojEmotions) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        _emojEmotions = [EmotionModel mj_objectArrayWithFile:filePath];
        //[_emojEmotions makeObjectsPerformSelector:@selector(setDirec:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojEmotions;
}

+ (NSArray *)loadLxhEmotions {
    if (!_lxhEmotions) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        _lxhEmotions = [EmotionModel mj_objectArrayWithFile:filePath];
        //[_lxhEmotions makeObjectsPerformSelector:@selector(setDirec:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

@end
