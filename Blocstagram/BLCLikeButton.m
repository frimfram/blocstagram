//
//  BLCLikeButton.m
//  Blocstagram
//
//  Created by Jean Ro on 12/6/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import "BLCLikeButton.h"
#import "BLCCircleSpinnerView.h"

#define kLikedStateImage @"heart-full"
#define kUnlikedStateImage @"heart-empty"

@interface BLCLikeButton ()

@property (nonatomic, strong) BLCCircleSpinnerView *spinnerView;

@end

@implementation BLCLikeButton

- (instancetype) init {
    self = [super init];
    
    if(self) {
        self.spinnerView = [[BLCCircleSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self addSubview: self.spinnerView];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.likeButtonState = BLCLikeStateNotLiked;
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.spinnerView.frame = self.imageView.frame;
}

-(void) setLikeButtonState:(BLCLikeState)likeButtonState {
    _likeButtonState = likeButtonState;
    
    NSString *imageName;
    
    switch (_likeButtonState) {
        case BLCLikeStateLiked:
        case BLCLikeStateUnliking:
            imageName = kLikedStateImage;
            break;
            
        case BLCLikeStateNotLiked:
        case BLCLikeStateLiking:
            imageName = kUnlikedStateImage;
    }
    
    switch (_likeButtonState) {
        case BLCLikeStateLiking:
        case BLCLikeStateUnliking:
            self.spinnerView.hidden = NO;
            self.userInteractionEnabled = NO;
            break;
            
        case BLCLikeStateLiked:
        case BLCLikeStateNotLiked:
            self.spinnerView.hidden = YES;
            self.userInteractionEnabled = YES;
    }
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
