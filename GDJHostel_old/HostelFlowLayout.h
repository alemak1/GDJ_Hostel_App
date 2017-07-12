//
//  HostelFlowLayout.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef HostelFlowLayout_h
#define HostelFlowLayout_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HostelFlowLayout : UICollectionViewFlowLayout

@property (strong, nonatomic) NSIndexPath *currentCellPath;
@property (nonatomic) CGPoint currentCellCenter;
@property (nonatomic) CGFloat currentCellScale;

-(instancetype)initWithPresetVerticalConfigurationA;
-(instancetype)initWithPresetHorizontalConfigurationA;

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection andWithItemSize:(CGSize)itemSize andWithMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing andWithMinimumLineSpacing:(CGFloat)minimumLineSpacing;

@end

#endif /* HostelFlowLayout_h */
