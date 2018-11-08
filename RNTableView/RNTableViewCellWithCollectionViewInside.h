//
//  RNTableViewCellWithCollectionViewInside.h
//  RNTableView
//
//  Created by Terence Ge on 2018/11/6.
//  Copyright © 2018 Pavlo Aksonov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
@class RCTBridge;

@interface RNTableViewCellWithCollectionViewInside : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *collectionData;
@property (strong) RCTBridge *bridge;
@property (strong, nonatomic) NSNumber *reactTag;

@end

