//
//  NumberFlipView.h
//  KnowItAll
//
//  Created by Kevin Harris on 3/20/12.
//  Copyright (c) 2012 Blockdot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlipView.h"

@interface NumberFlipView : FlipView
{

}

@property (nonatomic, strong) AnimationDelegate *animationDelegate;
@property (nonatomic) int value;

- (void)initNumbers;

@end
