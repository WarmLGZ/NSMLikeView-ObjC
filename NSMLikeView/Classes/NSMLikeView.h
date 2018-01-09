//
//  NSMLikeView.h
//  NSMLikeView
//
//  Created by 李国志 on 10/30/2017.
//  Copyright (c) 2017 李国志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMLikeView : UIImageView

- (void)masterAnimateInView:(CGRect)rect;

+ (instancetype)viewWithRandomImages:(NSArray *)randomImages;

@end

