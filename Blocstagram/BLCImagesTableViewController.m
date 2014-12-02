//
//  BLCImagesTableViewController.m
//  Blocstagram
//
//  Created by Jean Ro on 11/23/14.
//  Copyright (c) 2014 Jean Ro. All rights reserved.
//

#import "BLCImagesTableViewController.h"
#import "BLCDatasource.h"
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"
#import "BLCMediaTableViewCell.h"
#import "BLCMediaFullScreenViewController.h"
#import "BLCMediaFullScreenAnimator.h"

@interface BLCImagesTableViewController () <BLCMediaTableViewCellDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, weak) UIImageView *lastTappedImageView;
@end

@implementation BLCImagesTableViewController

-(id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tableLongPressed:)];
        [self.tableView addGestureRecognizer:self.longPressGesture];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[BLCDatasource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
 
    //self.tableView.contentInset = UIEdgeInsetsMake(66, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void) dealloc {
    [[BLCDatasource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object == [BLCDatasource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        int kindOfChange = [change[NSKeyValueChangeKindKey] intValue];
        if(kindOfChange == NSKeyValueChangeSetting) {
            [self.tableView reloadData];
        }else if( kindOfChange == NSKeyValueChangeInsertion ||
                 kindOfChange == NSKeyValueChangeRemoval ||
                 kindOfChange == NSKeyValueChangeReplacement) {
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            [self.tableView beginUpdates];
            
            if(kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }else if(kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            [self.tableView endUpdates];
        }
    }
}

-(void) refreshControlDidFire:(UIRefreshControl *)sender {
    [[BLCDatasource sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
}

-(NSArray *) items {
    return [BLCDatasource sharedInstance].mediaItems;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

-(void)tableLongPressed:(UILongPressGestureRecognizer *)recognizer {
    if(recognizer.state == UIGestureRecognizerStateRecognized) {
        
        [self setEditing:(!self.editing) animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self items].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BLCMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *item = [self items][indexPath.row];
    CGFloat newHeight = [BLCMediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    return newHeight;
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *item = [self items][indexPath.row];
    if(item.image) {
        return 350;
    }else {
        return 150;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        BLCMedia *item = self.items[indexPath.row];
        [[BLCDatasource sharedInstance] deleteMediaItem:item];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - BLCMediaTableViewCellDelegate

-(void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView {
    self.lastTappedImageView = imageView;
    BLCMediaFullScreenViewController *fullScreenVC = [[BLCMediaFullScreenViewController alloc] initWithMedia:cell.mediaItem];
    
    fullScreenVC.transitioningDelegate = self;
    fullScreenVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (cell.mediaItem.caption.length > 0) {
        [itemsToShare addObject:cell.mediaItem.caption];
    }
    
    if (cell.mediaItem.image) {
        [itemsToShare addObject:cell.mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.presenting = YES;
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

#pragma mark - UIScrollViewDelegate

/*
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if([scrollView.panGestureRecognizer translationInView:scrollView.superview].y < 0) {
        //scrolling down
        [self infiniteScrollIfNecessary];
    }
}
 */

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}

- (void) infiniteScrollIfNecessary {
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [BLCDatasource sharedInstance].mediaItems.count - 1) {
        // The very last cell is on screen
        [[BLCDatasource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}


@end
