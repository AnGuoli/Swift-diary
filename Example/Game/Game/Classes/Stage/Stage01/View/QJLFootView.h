//
//  QJLFootView.h
//  Game
//
//  Created by 金亮齐 on 16/7/14.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJLFootView : UIView

- (void)startAnimation;

- (void)stopFootView;

- (BOOL)attackFootViewAtIndex:(int)index;

- (void)pause;
- (void)continueFootView;
- (void)clean;

@end
