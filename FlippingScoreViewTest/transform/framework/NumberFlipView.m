//
//  NumberFlipView.m
//  KnowItAll
//
//  Created by Kevin Harris on 3/20/12.
//  Copyright (c) 2012 Blockdot. All rights reserved.
//

#import "NumberFlipView.h"

@implementation NumberFlipView

@synthesize animationDelegate = _animationDelegate;
@synthesize value = _value;

-(void) setValue: (int) value
{
    if( value == _value)
        return;
        
    int numSteps = 0;
    
    if( value > _value)
        numSteps = value - _value;
    else
    {
        numSteps = 9 - _value;
        numSteps += (value + 1);
    }
        
    [self.animationDelegate startAnimation:kDirectionForward numTimes:numSteps];
    
    _value = value;
}

-(int) value
{
    return _value;
}

- (id)initWithAnimationType:(AnimationType)aType frame:(CGRect)aFrame 
{
    if ((self = [super initWithAnimationType:aType frame:aFrame]))
    {
        self.animationDelegate = [[AnimationDelegate alloc] initWithSequenceType:kSequenceTriggered directionType:kDirectionForward];
        self.animationDelegate.controller = self;
        self.animationDelegate.perspectiveDepth = 200;
        self.animationDelegate.transformView = self;
        
        self.value = 0;
    }
    return self;
    
}

- (void)initNumbers
{
    UIImage *flipImage = [UIImage imageNamed:@"flip_board_bg_timer.png"];
    
    UIColor* text = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    UIColor* backGround = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
     
    [self printText:@"9" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"8" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"7" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"6" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"5" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"4" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"3" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"2" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"1" usingImage:flipImage backgroundColor:backGround textColor:text];
    [self printText:@"0" usingImage:flipImage backgroundColor:backGround textColor:text];
}

@end
