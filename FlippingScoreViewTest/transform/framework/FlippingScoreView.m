//
//  FlippingScoreView.m
//  KnowItAll
//
//  Created by Kevin Harris on 3/20/12.
//  Copyright (c) 2012 Blockdot. All rights reserved.
//

#import "FlippingScoreView.h"
#import "AnimationDelegate.h"
#import "NumberFlipView.h"

@implementation FlippingScoreView

@synthesize score = _score;

-(void) setScore: (int) score
{
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    {
        _score = score;
        
        int digit1 = score % 10;
        int digit2 = score % 100 / 10;
        int digit3 = score % 1000 / 100;
        int digit4 = score % 10000 / 1000;
        int digit5 = score % 100000 / 10000;
        
        NumberFlipView* nfv = [numberFlipViews objectAtIndex:0];
        nfv.value = digit1;
        
        nfv = [numberFlipViews objectAtIndex:1];
        nfv.value = digit2;
        
        nfv = [numberFlipViews objectAtIndex:2];
        nfv.value = digit3;
        
        nfv = [numberFlipViews objectAtIndex:3];
        nfv.value = digit4;
        
        nfv = [numberFlipViews objectAtIndex:4];
        nfv.value = digit5;
        
        //_score = score;
    }
    [lock unlock];
    [lock release], lock = nil;
}

-(int) score
{
    return _score;
}


- (id)initWithPosition:(CGPoint)point
{
    /*
    int numberWidth = 40;
    int numberHeight = 50;
    int numDigits = 5;
    int pixelsBetweenDigits = 2;

    CGRect frame = CGRectMake(point.x, point.y, numberWidth*numDigits+((numDigits-1)*pixelsBetweenDigits), numberHeight);

    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self setBackgroundColor:[UIColor redColor]];
        
        numberFlipViews = [[NSMutableArray alloc] init];
        animationDelegates = [[NSMutableArray alloc] init];
        
        int startX = frame.size.width - numberWidth;
        
        for (int i = 0; i < numDigits; ++i)
        {
            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical 
                                                                                     frame:CGRectMake(startX-(i*numberWidth+(i*pixelsBetweenDigits)), 0, numberWidth, numberHeight)];
            numberFlipView.fontSize = 36;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, 2.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];
            
            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self addSubview:numberFlipView];
        }
    }
    //*/
    
    /*
    int numberWidth = 36;
    int numberHeight = 57;
    int numDigits = 5;
    int pixelsBetweenDigits = 2;
    
    CGRect frame = CGRectMake(point.x, point.y, numberWidth*numDigits+((numDigits-1)*pixelsBetweenDigits), numberHeight);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self setBackgroundColor:[UIColor redColor]];
        
        numberFlipViews = [[NSMutableArray alloc] init];
        animationDelegates = [[NSMutableArray alloc] init];
        
        int startX = frame.size.width - numberWidth;
        
        for (int i = 0; i < numDigits; ++i)
        {
            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical 
                                                                                     frame:CGRectMake(startX-(i*numberWidth+(i*pixelsBetweenDigits)), 0, numberWidth, numberHeight)];
            numberFlipView.fontSize = 50;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, -2.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];
            
            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self addSubview:numberFlipView];
        }
    }
    //*/
    
    /*
    int numberWidth = 27;
    int numberHeight = 42;
    int numDigits = 5;
    int pixelsBetweenDigits = 2;
    
    CGRect frame = CGRectMake(point.x, point.y, numberWidth*numDigits+((numDigits-1)*pixelsBetweenDigits), numberHeight);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self setBackgroundColor:[UIColor redColor]];
        
        numberFlipViews = [[NSMutableArray alloc] init];
        animationDelegates = [[NSMutableArray alloc] init];
        
        int startX = frame.size.width - numberWidth;
        
        for (int i = 0; i < numDigits; ++i)
        {
            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical 
                                                                                     frame:CGRectMake(startX-(i*numberWidth+(i*pixelsBetweenDigits)), 0, numberWidth, numberHeight)];
            numberFlipView.fontSize = 34;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, 1.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];
            
            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self addSubview:numberFlipView];
        }
    }
    //*/
    
    //*
    int numberWidth = 74;
    int numberHeight = 115;
    int numDigits = 5;
    int pixelsBetweenDigits = 2;
    
    CGRect frame = CGRectMake(point.x, point.y, numberWidth*numDigits+((numDigits-1)*pixelsBetweenDigits), numberHeight);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self setBackgroundColor:[UIColor redColor]];
        
        numberFlipViews = [[NSMutableArray alloc] init];
        animationDelegates = [[NSMutableArray alloc] init];
        
        int startX = frame.size.width - numberWidth;
        
        for (int i = 0; i < numDigits; ++i)
        {
            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical 
                                                                                     frame:CGRectMake(startX-(i*numberWidth+(i*pixelsBetweenDigits)), 0, numberWidth, numberHeight)];
            numberFlipView.fontSize = 100;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, -2.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            //numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];
            
            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self addSubview:numberFlipView];
        }
    }
    //*/
    
    /*
    int numberWidth = 54;
    int numberHeight = 84;
    int numDigits = 5;
    int pixelsBetweenDigits = 2;
    
    CGRect frame = CGRectMake(point.x, point.y, numberWidth*numDigits+((numDigits-1)*pixelsBetweenDigits), numberHeight);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        //[self setBackgroundColor:[UIColor redColor]];
        
        numberFlipViews = [[NSMutableArray alloc] init];
        animationDelegates = [[NSMutableArray alloc] init];
        
        int startX = frame.size.width - numberWidth;
        
        for (int i = 0; i < numDigits; ++i)
        {
            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical 
                                                                                     frame:CGRectMake(startX-(i*numberWidth+(i*pixelsBetweenDigits)), 0, numberWidth, numberHeight)];
            numberFlipView.fontSize = 75;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, -3.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];
            
            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self addSubview:numberFlipView];
        }
    }
    //*/
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
