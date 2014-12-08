//
//  BLCComposeCommentView.m
//  Blocstagram
//
//  Created by Jean Ro on 12/7/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import "BLCComposeCommentView.h"

@interface BLCComposeCommentView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BLCComposeCommentView

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.textView = [UITextView new];
        self.textView.delegate = self;
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setAttributedTitle:[self commentAttributedString] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.textView];
        [self.textView addSubview:self.button];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
    
    if (self.isWritingComment) {
        self.textView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
        self.button.backgroundColor = [UIColor colorWithRed:0.345 green:0.318 blue:0.424 alpha:1]; /*#58516c*/
        
        CGFloat buttonX = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.button.frame) - 20;
        self.button.frame = CGRectMake(buttonX, 10, 80, 20);
    } else {
        self.textView.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
        self.button.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]; /*#999999*/
        
        self.button.frame = CGRectMake(10, 10, 80, 20);
    }
    
    CGSize buttonSize = self.button.frame.size;
    buttonSize.height += 20;
    buttonSize.width += 20;
    CGFloat blockX = CGRectGetWidth(self.textView.bounds) - buttonSize.width;
    CGRect areaToBlockText = CGRectMake(blockX, 0, buttonSize.width, buttonSize.height);
    UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRect:areaToBlockText];
    
    self.textView.textContainer.exclusionPaths = @[buttonPath];
}

-(NSAttributedString *) commentAttributedString {
    NSString *baseString = NSLocalizedString(@"COMMENT", @"comment button text");
    NSRange range = [baseString rangeOfString:baseString];
    
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:baseString];
    
    [commentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] range:range];
    [commentString addAttribute:NSKernAttributeName value:@1.3 range:range];
    [commentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1] range:range];
    
    return commentString;
}

-(void) stopComposingComment {
    [self.textView resignFirstResponder];
}


@end










