//
//  HostelFlowLayout.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelFlowLayout.h"

@implementation HostelFlowLayout

-(instancetype)init{
    self = [super init];
    
    
    return self;
}

-(instancetype)initWithPresetHorizontalConfigurationA{
    
    self = [self init];
    
    if(self){
        
        [self setItemSize:CGSizeMake(200, 100)];
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self setMinimumLineSpacing:20];
        [self setMinimumInteritemSpacing:20];
        
    }
    
    
    return self;
}

-(instancetype)initWithPresetVerticalConfigurationA{
    
    self = [self init];
    
    if(self){
        
        [self setItemSize:CGSizeMake(200, 100)];
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
        [self setMinimumLineSpacing:20];
        [self setMinimumInteritemSpacing:20];
        
    }
    
    
    return self;
}


- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection andWithItemSize:(CGSize)itemSize andWithMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing andWithMinimumLineSpacing:(CGFloat)minimumLineSpacing
{
    self = [super init];
    if (self) {
        [self setItemSize:itemSize];
        [self setScrollDirection:scrollDirection];
        [self setMinimumInteritemSpacing:minimumInteritemSpacing];
        [self setMinimumLineSpacing:minimumLineSpacing];
    }
    return self;
}



-(void)setCurrentCellScale:(CGFloat)scale;
{
    _currentCellScale = scale;
    [self invalidateLayout];
}

- (void)setCurrentCellCenter:(CGPoint)origin
{
    _currentCellCenter = origin;
    [self invalidateLayout];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the current attributes for the item at the indexPath
    UICollectionViewLayoutAttributes *attributes =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    
    // Modify them to match the pinch values
    [self modifyLayoutAttributes:attributes];
    
    // return them to collection view
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [super
                                    layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *cellAttributes in allAttributesInRect)
    {
        // Modify the attributes for the cells in the frame rect
        [self modifyLayoutAttributes:cellAttributes];
    }
    return allAttributesInRect;
}

-(void)modifyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    // If the indexPath matches the one we have stored
    if ([layoutAttributes.indexPath isEqual:_currentCellPath])
    {
        // Assign the new layout attributes
        layoutAttributes.transform3D =
        CATransform3DMakeScale(_currentCellScale, _currentCellScale, 1.0);
        layoutAttributes.center = _currentCellCenter;
        layoutAttributes.zIndex = 1;
    }
}

@end
