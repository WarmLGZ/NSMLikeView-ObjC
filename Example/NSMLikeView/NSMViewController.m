//
//  NSMViewController.m
//  NSMLikeView
//
//  Created by liguozhi on 01/08/2018.
//  Copyright (c) 2018 liguozhi. All rights reserved.
//

#import "NSMViewController.h"
#import <NSMLikeView/NSMLikeView.h>

@interface NSMViewController ()
    
    @property (nonatomic, strong) NSTimer *burstTimer;
    
    @end

@implementation NSMViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTheLove)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGesture];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)showTheLove {
    
    NSArray *randomImages = @[@"NSMLiveLikeGreenFace", @"NSMLiveLikeGreenHeart", @"NSMLiveLikeGreenStar", @"NSMLiveLikeRedFace", @"NSMLiveLikeRedHeart", @"NSMLiveLikeRedStar", @"NSMLiveLikeYellowFace", @"NSMLiveLikeYellowHeart", @"NSMLiveLikeYellowStar"];
    
    CGFloat heartSize = 32.0;
    NSMLikeView *likeView = [NSMLikeView viewWithRandomImages:randomImages];
    [likeView masterAnimateInView:CGRectMake(CGRectGetWidth(self.view.bounds) - heartSize / 2.0 - 100.0, CGRectGetHeight(self.view.bounds) / 3.0 - heartSize / 2.0, 100.0, CGRectGetHeight(self.view.bounds) / 1.5)];
    [self.view addSubview:likeView];
}
    
- (void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture {
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
        self.burstTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
        break;
        case UIGestureRecognizerStateEnded:
        [self.burstTimer invalidate];
        self.burstTimer = nil;
        break;
        default:
        break;
    }
}
    
@end
