//
//  NSMLikeView.m
//  NSMLikeView
//
//  Created by 李国志 on 10/30/2017.
//  Copyright (c) 2017 李国志. All rights reserved.
//

#import "NSMLikeView.h"

static const  CGFloat  ALPHA_DURATION_START = 0.5; //alpha 0 ~ 1 duration
static const  CGFloat  ALPHA_DURATION_END = 0.6;   //alpha 1 ~ 0 duration
static const  CGFloat  MIN_DURATION = 2.0;         //最小的动画时间
//static const  CGFloat  MAX_DURATION = 2.5;       //最大的动画时间
static const  CGFloat  MIN_HEIGHT_RATIO = 0.7f;    //最小的高度比
//static const  CGFloat  MAX_HEIGHT_RATIO = 1.0f;    //最大的高度比
static const  CGFloat  MIN_PERIOD_RATIO = 0.7f;    //最小的周期比
//static const  CGFloat  MAX_PERIOD_RATIO = 1.2f;    //最大的周期比

@interface NSMLikeView ()<CAAnimationDelegate>

@end

@implementation NSMLikeView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)masterAnimateInView:(CGRect)rect {
    CGFloat totalAnimationDuration = arc4random_uniform(6)/10.0 + MIN_DURATION;
//    CGFloat amplitudeRatio = arc4random_uniform(11)/10.0;
    CGFloat distanceRatio = arc4random_uniform(3)/10.0 + MIN_HEIGHT_RATIO;
    CGFloat periodRatio = arc4random_uniform(6)/10.0 + MIN_PERIOD_RATIO;
    
    NSInteger emitDirection = 1 - (2 * (NSInteger)arc4random_uniform(2));// -1 OR 1
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    animations.duration = totalAnimationDuration;
    
    // Alpha
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.duration = totalAnimationDuration;
    alphaAnimation.values = @[@(.0), @(1),@(1), @(0)];
    alphaAnimation.keyTimes = @[@(.0), @(ALPHA_DURATION_START / alphaAnimation.duration), @((alphaAnimation.duration - ALPHA_DURATION_END) / alphaAnimation.duration), @(1)];
    alphaAnimation.removedOnCompletion = YES;
    
    // Scale
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = ALPHA_DURATION_START;
    scaleAnimation.removedOnCompletion = YES;

    // Path
    CGSize itemSize = self.bounds.size;
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat xOffset = CGRectGetMidX(rect);
    
    CGFloat distance = maxY - minY - itemSize.height;
    CGFloat amplitude = (maxX - minX - itemSize.width) / 2.0;
    
    NSMutableArray *positionValues = [NSMutableArray array];
    NSMutableArray *transformValues = [NSMutableArray array];
    
    NSInteger frames = 60 * animations.duration;
    for (int i = 0; i<= frames; i++) {
//        CGFloat x = sin(M_PI * 2 / frames * i) * amplitude + xOffset;
//        CGFloat y = maxY - (distance / frames) * i - itemSize.height / 2.0;
        //此处引入振幅随时间帧数的变大而变大
        CGFloat x1 = emitDirection * sin(2 * M_PI * periodRatio / frames * i) * (amplitude / frames * i );
        CGFloat y1 = (distance / frames) * i * distanceRatio;
        CGFloat angle = atan2(x1, y1);
//        CGFloat xx = 2 * M_PI / frames * i;
//        CGFloat yy = emitDirection * sin(xx);
//        CGFloat angle = atan2(yy, xx);

//        CGFloat xx = M_PI * 2 / frames * i;
//        NSInteger direction = xx < M_PI ? 1 : -1;
//        NSInteger k = xx < M_PI ? 1 : 3;
//        CGFloat angle = direction * (k * M_PI_2 - xx);
        [transformValues addObject:@(angle)];
        
        //转换成手机坐标系下的(x,y)
        CGFloat x = x1 + xOffset;
        CGFloat y = maxY - y1 - itemSize.height / 2.0;
       
        [positionValues addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    
    // Position
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animations.duration = totalAnimationDuration;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.05 :.0 :.0 :.29];
    positionAnimation.values = positionValues;
    
    // Transform
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    transformAnimation.values = transformValues;
    animations.duration = totalAnimationDuration;
    
    animations.animations = @[alphaAnimation, scaleAnimation, positionAnimation, transformAnimation];
    animations.delegate = self;
    animations.fillMode = kCAFillModeForwards;
    animations.removedOnCompletion = NO;
    [self.layer addAnimation:animations forKey:@"animation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeFromSuperview];
    [self.layer removeAllAnimations];
}

+ (instancetype)viewWithRandomImages:(NSArray *)randomImages {
    static NSArray *images = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        images = randomImages;
    });
    
    uint32_t count = (uint32_t)images.count;
    NSInteger index = arc4random_uniform(count);
    
    NSMLikeView *likeView = [[NSMLikeView alloc] initWithImage:[UIImage imageNamed:images[index]]];
    return likeView;
}

@end
