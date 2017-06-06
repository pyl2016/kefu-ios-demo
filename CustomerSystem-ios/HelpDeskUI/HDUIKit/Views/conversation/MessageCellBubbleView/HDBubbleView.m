/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */


#import "HDBubbleView.h"

#import "HDBubbleView+Text.h"
#import "HDBubbleView+Image.h"
#import "HDBubbleView+Location.h"
#import "HDBubbleView+Voice.h"
#import "HDBubbleView+Video.h"
#import "HDBubbleView+File.h"
#import "HDBubbleView+Track.h"

NSString *const HRouterEventTapMenu = @"HRouterEventTapMenu";
NSString *const HRouterEventTapTransform = @"HRouterEventTapTransform";
NSString *const HRouterEventTapEvaluate = @"HRouterEventTapEvaluate";
NSString *const HRouterEventTextURLTapEventName = @"HRouterEventTextURLTapEventName";

@interface HDBubbleView()

@property (nonatomic) NSLayoutConstraint *marginTopConstraint;
@property (nonatomic) NSLayoutConstraint *marginBottomConstraint;
@property (nonatomic) NSLayoutConstraint *marginLeftConstraint;
@property (nonatomic) NSLayoutConstraint *marginRightConstraint;

@end

@implementation HDBubbleView

@synthesize backgroundImageView = _backgroundImageView;
@synthesize margin = _margin;

- (instancetype)initWithMargin:(UIEdgeInsets)margin
                      isSender:(BOOL)isSender
{
    self = [super init];
    if (self) {
        _isSender = isSender;
        _margin = margin;
        
        _marginConstraints = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Setup Constraints

- (void)_setupBackgroundImageViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
}

#pragma mark - getter

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundImageView];
        [self _setupBackgroundImageViewConstraints];
    }
    
    return _backgroundImageView;
}
// 删除轨迹消息
- (void)sendDeleteTrackMsg:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(deleteTrackMessage:)]) {
        [self.delegate deleteTrackMessage:button];
    }
}

@end
