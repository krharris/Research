//
//  FlippingScoreView.m
//  KnowItAll
//
//  Created by Kevin Harris on 3/20/12.
//  Copyright (c) 2012 Blockdot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberFlipView;
@class AnimationDelegate;

@interface FlippingScoreView : UIView
{
    NSMutableArray* numberFlipViews;
    NSMutableArray* animationDelegates;
}

@property (nonatomic) int score;

- (id)initWithPosition:(CGPoint)point;

@end
