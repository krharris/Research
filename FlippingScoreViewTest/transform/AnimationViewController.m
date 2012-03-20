
/*
 
 File: RootViewController.m
 Abstract: An example of 2 flip views that respond to user input.
 
 
 Copyright (c) 2011 Dillion Tan
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "AnimationViewController.h"
#import "FlipView.h"
#import "AnimationDelegate.h"
#import "NumberFlipView.h"

#import "FlippingScoreView.h"

@implementation AnimationViewController

//@synthesize flipView;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        step = 0;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)dealloc
{
    //[flipView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //for(UIFont *font in [UIFont familyNames])
    //    NSLog(@"font %@", font);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackButtonPressed:)];
    
    numberFlipViews = [[NSMutableArray alloc] init];
    animationDelegates = [[NSMutableArray alloc] init];
     
    score = 12344;
    int startX = 210;
    int startY = 10;

    for (int i = 0; i < 5; ++i)
    //for (int i = 0; i < 1; ++i)
    {
        //for (int j = 0; j < 8; ++j)
        for (int j = 0; j < 1; ++j)
        {
            //NSLog(@"i = %i, j = %i", i*40, j*50);

            NumberFlipView* numberFlipView = [[NumberFlipView alloc] initWithAnimationType:kAnimationFlipVertical frame:CGRectMake(startX-(i*40+(i*2)), startY+(j*50), 40, 50)];
            numberFlipView.fontSize = 36;
            numberFlipView.font = @"Helvetica Neue Bold";
            numberFlipView.fontAlignment = @"center";
            numberFlipView.textOffset = CGPointMake(0.0, 2.0);
            numberFlipView.textTruncationMode = kCATruncationEnd;
            numberFlipView.sublayerCornerRadius = 6.0f;
            [numberFlipView initNumbers];

            [animationDelegates addObject:numberFlipView.animationDelegate];
            [numberFlipViews addObject:numberFlipView];
            
            [self.view addSubview:numberFlipView];
        }
    }
    
    
    
    //CGRect  viewRect = CGRectMake(40, 100, 225, 60);
    //FlippingScoreView* flippingScoreView = [[FlippingScoreView alloc] initWithFrame:viewRect];
    
    CGPoint point = CGPointMake( 40, 100 );
    flippingScoreView = [[FlippingScoreView alloc] initWithPosition:point];

    [self.view addSubview:flippingScoreView];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
    int numSteps = [animationDelegates count] + 1;
    
    for(AnimationDelegate *animationDelegate in animationDelegates)
    {
        --numSteps;

        //if(animationDelegate != numberFlipView.animationDelegate)
            [animationDelegate startAnimation:kDirectionForward numTimes:numSteps];
    }
     */
    
    
    //    int digit1 = score % 10;
    //    int digit2 = score % 100 - digit1;
    //    int digit3 = score % 1000 - digit2 - digit1;
    //    int digit4 = score % 10000 - digit3 - digit2 - digit1;
    
    score += 1;

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
    
    
    flippingScoreView.score = score;
}


- (void)onBackButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for(AnimationDelegate *animationDelegate in animationDelegates)
    {
        if (animationDelegate.repeat)
            [animationDelegate startAnimation:kDirectionNone numTimes:0];
    }
    
    //if (flippingScoreView.animationDelegate.repeat)
    //    [flippingScoreView.animationDelegate startAnimation:kDirectionNone numTimes:0];
    
//    if (animationDelegate.repeat) {
//        [animationDelegate startAnimation:kDirectionNone];
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [animationDelegate resetTransformValues];
//    [NSObject cancelPreviousPerformRequestsWithTarget:animationDelegate];
    
    //[flippingScoreView.animationDelegate resetTransformValues];
    //[NSObject cancelPreviousPerformRequestsWithTarget:flippingScoreView.animationDelegate];
    
    for(AnimationDelegate *animationDelegate in animationDelegates)
    {
        [animationDelegate resetTransformValues];
        [NSObject cancelPreviousPerformRequestsWithTarget:animationDelegate];
    }
}


// use this to trigger events after specific interactions
- (void)animationDidFinish:(int)direction 
{
    switch (step) 
    {
        case 0:
            break;
        case 1:
            break;
        default:break;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
