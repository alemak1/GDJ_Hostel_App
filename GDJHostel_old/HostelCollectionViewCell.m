//
//  HostelCollectionViewCell.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelCollectionViewCell.h"

@interface HostelCollectionViewCell ()

@property UIImageView* imageView;

@end

@implementation HostelCollectionViewCell


-(instancetype)init{
    self = [super init];
    
    if(self){
        CGRect imageFrame = self.contentView.frame;
        
        _imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        
        [self.contentView addSubview:_imageView];
        
        [self addObserver:self forKeyPath:@"imageName" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    
    return self;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"imageName"]){
        
        UIImage* newImage = [UIImage imageNamed:self.imageName];
        [self.imageView setImage:newImage];
    }
}

-(void)setHostelImage:(UIImage *)hostelImage{
    
    [self.imageView setImage:hostelImage];
}

-(UIImage *)hostelImage{
    
    return [self.imageView image];
}



@end
