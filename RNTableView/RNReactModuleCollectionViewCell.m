//
//  RNReactModuleCollectionViewCell.m
//  RNTableView
//
//  Created by Terence Ge on 2018/11/7.
//  Copyright © 2018 Pavlo Aksonov. All rights reserved.
//

#import <React/RCTRootView.h>
#import "RNReactModuleCollectionViewCell.h"
#import "RNTableView.h"

@implementation RNReactModuleCollectionViewCell {
    RCTRootView *_rootView;
}

-(NSDictionary*) toProps:(NSDictionary *)data indexPath:(NSIndexPath*)indexPath reactTag:(NSNumber*)reactTag {
    return @{@"data":data, @"section":[[NSNumber alloc] initWithLong:indexPath.section], @"row":[[NSNumber alloc] initWithLong:indexPath.row], @"tableViewReactTag":reactTag};
}

-(void)setUpAndConfigure:(NSDictionary*)data bridge:(RCTBridge*)bridge indexPath:(NSIndexPath*)indexPath reactModule:(NSString*)reactModule tableViewTag:(NSNumber*)reactTag {
    NSDictionary *props = [self toProps:data indexPath:indexPath reactTag:reactTag];
    if (_rootView == nil) {
        //Create the mini react app that will populate our cell. This will be called from cellForRowAtIndexPath
        _rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:reactModule initialProperties:props];
        [self.contentView addSubview:_rootView];
        _rootView.frame = self.contentView.frame;
        _rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    } else {
        //Ask react to re-render us with new data
        _rootView.appProperties = props;
    }
    //The application will be unmounted in javascript when the cell/rootview is destroyed
}

-(void)prepareForReuse {
    [super prepareForReuse];
    //TODO prevent stale data flickering
}

@end
