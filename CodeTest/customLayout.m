//
//  customLayout.m
//  CodeTest
//
//  Created by max blessen on 4/21/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

#import "customLayout.h"

static NSString * const cellType = @"gifCell";
@interface customLayout ()

@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation customLayout



- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.smallSize = [[UIScreen mainScreen] bounds].size.width/3;
    self.bigSize = self.smallSize*2;
    if (self.isDynamicSize == false) {
        self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.bigSize);
        self.interItemSpacingY = 0.0f;
        self.numberOfColumns = 1;
    }
    else {
        self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        self.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.bigSize);
        self.interItemSpacingY = 12.0f;
        self.numberOfColumns = 1;
    }
}


- (void)prepareLayout
{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForGifAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[cellType] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

- (orientationSize)determineOrientationAndSizeForIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    NSInteger modulo = indexPath.section % 2;
    if (modulo == 0 && item == 0) {
        return bigLeft;
    }else if (modulo == 1 && item == 2) {
        return bigRight;
    }else if (modulo == 0 && item != 0){
        return smallRight;
    }else {
        return smallLeft;
    }
}

- (CGRect)frameForGifAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDynamicSize == false) {
        NSInteger column = indexPath.section % self.numberOfColumns;
        
        CGFloat spacingX = self.collectionView.bounds.size.width -
        self.itemInsets.left -
        self.itemInsets.right -
        (self.numberOfColumns * self.itemSize.width);
        
        if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
        
        CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
        
        CGFloat originY = floor(self.itemInsets.top +
                                (self.itemSize.height + self.interItemSpacingY) * (indexPath.section * 3 + indexPath.item));
        
        return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
    }else {
        NSInteger section = indexPath.section;
        NSInteger item = indexPath.item;
        CGFloat originX;
        CGFloat originY;
        CGFloat size;
        orientationSize orientation = [self determineOrientationAndSizeForIndexPath:indexPath];
        switch (orientation) {
        case bigLeft:
                originX = floorf(self.itemInsets.left);
                originY = floor(self.itemInsets.top + (self.bigSize * section));
                size = self.bigSize;
                break;
        case bigRight:
                originX = floorf(self.collectionView.bounds.size.width - self.bigSize);
                originY = floor(self.itemInsets.top + (self.bigSize * section));
                size = self.bigSize;
                break;
        case smallLeft:
                originX = floorf(self.itemInsets.left);
                originY = floor(self.itemInsets.top + (self.bigSize * section) + (self.smallSize * (item)));
                size = self.smallSize;
                break;
        case smallRight:
                originX = floorf(self.bigSize);
                originY = floor(self.itemInsets.top + (self.bigSize * section) + (self.smallSize * (item - 1)));
                size = self.smallSize;
                break;
        }
        
        return CGRectMake(originX, originY, size, size);
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[cellType][indexPath];
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = [self.collectionView numberOfSections];
    
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    CGFloat height;
    if (self.isDynamicSize == true) {
        height = self.itemInsets.top +
        rowCount * self.bigSize + (rowCount - 1) +
        self.itemInsets.bottom;
    }else {
        height = self.itemInsets.top +
        rowCount * 3 * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
        self.itemInsets.bottom;
    }
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

@end
