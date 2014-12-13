//
//  BLCFilterCollectionViewCell.m
//  Blocstagram
//
//  Created by Jean Ro on 12/12/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import "BLCFilterCollectionViewCell.h"

@interface BLCFilterCollectionViewCell ()

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *label;

@end

@implementation BLCFilterCollectionViewCell

static NSInteger imageViewTag = 1000;
static NSInteger labelTag = 1001;

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self) {
        self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        self.thumbnail.tag = imageViewTag;
        self.thumbnail.clipsToBounds = YES;
        [self.contentView addSubview:self.thumbnail];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        self.label.tag = labelTag;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

-(void) setImage:(UIImage *)image {
    _image = image;
    self.thumbnail.image = image;
}

-(void) setLabelText:(NSString *)labelText {
    _labelText = labelText;
    self.label.text = labelText;
}

-(void) layoutSubviews {
    
}

@end
