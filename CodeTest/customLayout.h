//
//  customLayout.h
//  CodeTest
//
//  Created by max blessen on 4/21/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, orientationSize) {
    bigLeft,
    bigRight,
    smallLeft,
    smallRight
};




@interface customLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) BOOL isDynamicSize;
@property (nonatomic) CGFloat bigSize;
@property (nonatomic) CGFloat smallSize;


@end
