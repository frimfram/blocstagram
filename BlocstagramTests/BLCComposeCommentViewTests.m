//
//  BLCComposeCommentViewTests.m
//  Blocstagram
//
//  Created by Jean Ro on 12/13/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BLCComposeCommentView.h"

@interface BLCComposeCommentViewTests : XCTestCase

@end

@implementation BLCComposeCommentViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSetTextIsSettingWritingComment {
    BLCComposeCommentView *testCommentView = [[BLCComposeCommentView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    [testCommentView setText:@"some text"];

    XCTAssertTrue([testCommentView isWritingComment]);
}

@end
