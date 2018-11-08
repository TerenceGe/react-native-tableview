//
//  RNTableViewCellWithCollectionViewInside.m
//  RNTableView
//
//  Created by Terence Ge on 2018/11/6.
//  Copyright © 2018 Pavlo Aksonov. All rights reserved.
//

#import "RNTableViewCellWithCollectionViewInside.h"
#import "RNReactModuleCollectionViewCell.h"
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>

@implementation RNTableViewCellWithCollectionViewInside

-(void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [_collectionView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}

- (void)reloadInputViews
{
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionData.count;
}

-(UICollectionViewCell*)setupReactModuleCell:(UICollectionView *)collectionView data:(NSDictionary*)data indexPath:(NSIndexPath *)indexPath reactModuleForCell:(NSString *)reactModuleForCell {
    RCTAssert(_bridge, @"Must set global bridge in AppDelegate, e.g. \n\
              #import <RNTableView/RNAppGlobals.h>\n\
              [[RNAppGlobals sharedInstance] setAppBridge:rootView.bridge]");
    RNReactModuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReactModuleCollectionViewCell" forIndexPath:indexPath];
    // if (cell == nil) {
        [cell setUpAndConfigure:data bridge:self.bridge indexPath:indexPath reactModule:reactModuleForCell tableViewTag:self.reactTag];
        
        // cell.layer.borderColor = [UIColor greenColor].CGColor;
        // cell.layer.borderWidth = 1.0f;
    // }
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    NSMutableDictionary *itemData = [self.collectionData objectAtIndex: indexPath.item];
    if (itemData[@"reactModuleForCollectionViewCell"] != nil && ![itemData[@"reactModuleForCollectionViewCell"] isEqualToString:@""]) {
        cell = [self setupReactModuleCell:collectionView data:itemData indexPath:indexPath reactModuleForCell:itemData[@"reactModuleForCollectionViewCell"]];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReactModuleCollectionViewCell" forIndexPath:indexPath];
    }
    
    //    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *itemData = [self.collectionData objectAtIndex: indexPath.item];
    return CGSizeMake(self.frame.size.width - 32, [itemData[@"height"] intValue]);
}

@end
