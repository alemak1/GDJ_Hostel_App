//
//  ImageManagerB.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/26/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageManagerB.h"
#import "ImageKeyConstants.h"

@interface ImageManagerB ()

@property NSMutableArray<UIImage*>* imagesForRoomNo1;
@property NSMutableArray<UIImage*>* imagesForRoomNo2;
@property NSMutableArray<UIImage*>* imagesForRoomNo3;
@property NSMutableArray<UIImage*>* imagesForRoomNo4;


@property (readonly) NSArray<NSString*>* roomNo1Names;
@property (readonly) NSArray<NSString*>* roomNo2Names;
@property (readonly) NSArray<NSString*>* roomNo3Names;
@property (readonly) NSArray<NSString*>* roomNo4Names;


@end

@implementation ImageManagerB


static ImageManagerB* _sharedMyManager = nil;


#pragma mark ******** INITIALIZERS

+(ImageManagerB*)sharedManager{
    
    if(!_sharedMyManager) {
        _sharedMyManager = [[ImageManagerB alloc]init];
    }
    
    return _sharedMyManager;
}

-(id)init{
    if(self = [super init]){
        
        _imagesForRoomNo1 = nil;
        _imagesForRoomNo2 = nil;
        _imagesForRoomNo3 = nil;
        _imagesForRoomNo4 = nil;
        
    }
    
    return self;
}

-(UIImage*)getImageForIndexPath:(NSIndexPath*)indexPath{
    
    if(indexPath.section >= ROOM_CATEGORY_END_INDEX){
        return nil;
    }
    
    NSMutableArray<UIImage*>* imagesArray = [self getImagesForRoomCategory:indexPath.section];
    
    
    NSInteger numberOfImagesLoaded = [imagesArray count];
    
    switch (indexPath.section) {
        case ROOM_NO1:
            numberOfImagesLoaded = [self numberOfImagesLoadedForRoom1];
            break;
        case ROOM_NO2:
            numberOfImagesLoaded = [self numberOfImagesLoadedForRoom2];
            break;
        case ROOM_NO3:
            numberOfImagesLoaded = [self numberOfImagesLoadedForRoom3];
            break;
        case ROOM_NO4:
            numberOfImagesLoaded = [self numberOfImagesLoadedForRoom4];
            break;
        default:
            numberOfImagesLoaded = [imagesArray count];
            break;
    }
    
    NSInteger maxRow = numberOfImagesLoaded < [imagesArray count] ? numberOfImagesLoaded : [imagesArray count];
    
    if(indexPath.row >= maxRow){
        return nil;
    }
    
    return [imagesArray objectAtIndex:indexPath.row];
}

-(NSInteger)getNumberOfItemsInSection:(NSInteger)section{
    
    RoomCategory roomCategory = section;
    
    switch (roomCategory) {
        case ROOM_NO1:
            return [self.roomNo1Names count];
        case ROOM_NO2:
            return [self.roomNo2Names count];
        case ROOM_NO3:
            return [self.roomNo3Names count];
        case ROOM_NO4:
            return [self.roomNo4Names count];
        default:
            return 0;
    }
    
    return 0;
}

-(NSMutableArray<UIImage*>*) getImagesForRoomCategory:(RoomCategory)roomCategory{
    
    switch (roomCategory) {
        case ROOM_NO1:
            return [self imagesForRoomNo1];
        case ROOM_NO2:
            return [self imagesForRoomNo2];
        case ROOM_NO3:
            return [self imagesForRoomNo3];
        case ROOM_NO4:
            return [self imagesForRoomNo4];
        default:
            return nil;
    }
    
    return nil;
}
-(void) loadImageForRoomNo1{
    
    
    if(_imagesForRoomNo1 != nil){
        return;
    }
    
    _imagesForRoomNo1 = [[NSMutableArray alloc] init];
    
    for (NSString* imagePath in [self roomNo1Names]) {
        
        UIImage* image = [UIImage imageNamed:imagePath];
        
        if(image){
            [_imagesForRoomNo1 addObject:image];

        }
    }
    
}


-(void) loadImageForRoomNo2{
    
    
    if(_imagesForRoomNo2 != nil){
        return;
    }
    
    _imagesForRoomNo2 = [[NSMutableArray alloc] init];
    
    for (NSString* imagePath in [self roomNo2Names]) {
        UIImage* image = [UIImage imageNamed:imagePath];
        
        if(image){
            [_imagesForRoomNo2 addObject:image];
            
        }
    }
    
}

-(void) loadImageForRoomNo3{
    
    
    if(_imagesForRoomNo3 != nil){
        return;
    }
    
    _imagesForRoomNo3 = [[NSMutableArray alloc] init];
    
    for (NSString* imagePath in [self roomNo3Names]) {
        UIImage* image = [UIImage imageNamed:imagePath];
        
        if(image){
            [_imagesForRoomNo3 addObject:image];
            
        }
    }
    
}


-(void) loadImageForRoomNo4{
    
    
    if(_imagesForRoomNo4 != nil){
        return;
    }
    
    _imagesForRoomNo4 = [[NSMutableArray alloc] init];
    
    for (NSString* imagePath in [self roomNo4Names]) {
        UIImage* image = [UIImage imageNamed:imagePath];
        
        if(image){
            [_imagesForRoomNo4 addObject:image];
            
        }
    }
    
}

-(void)unloadImagesForRoomNo1{
    _imagesForRoomNo1 = nil;
}

-(void)unloadImagesForRoomNo2{
    _imagesForRoomNo2 = nil;
}

-(void)unloadImagesForRoomNo3{
    _imagesForRoomNo3 = nil;
}

-(void)unloadImagesForRoomNo4{
    _imagesForRoomNo4 = nil;
}

-(NSArray<NSString *> *)roomNo1Names{
    
    return @[kRoomNo1_1,kRoomNo1_2,kRoomNo1_3,kRoomNo1_4,kRoomNo1_5];
}

-(NSArray<NSString *> *)roomNo2Names{
    
    return @[kRoomNo2_1,kRoomNo2_2,kRoomNo2_3,kRoomNo2_4];
}

-(NSArray<NSString *> *)roomNo3Names{
    return @[kRoomNo3_1,kRoomNo3_2,kRoomNo3_3,kRoomNo3_4,kRoomNo3_5,kRoomNo3_6,kRoomNo3_7,kRoomNo3_8,kRoomNo3_9,kRoomNo3_10,kRoomNo3_11,kRoomNo3_12];
}

-(NSArray<NSString *> *)roomNo4Names{
    return @[kRoomNo4_1,kRoomNo4_2,kRoomNo4_3,kRoomNo4_4,kRoomNo4_5,kRoomNo4_6,kRoomNo4_7,kRoomNo4_8,kRoomNo4_9,kRoomNo4_10,kRoomNo4_11,kRoomNo4_12];
    
}

- (NSInteger)numberOfImagesLoadedForRoom1{
    
    if(_imagesForRoomNo1 == nil){
        return 0;
    }
    
    return [_imagesForRoomNo1 count];
}

- (NSInteger)numberOfImagesLoadedForRoom2{
    
    if(_imagesForRoomNo2 == nil){
        return 0;
    }

    return [_imagesForRoomNo2 count];
}

- (NSInteger)numberOfImagesLoadedForRoom3{
    
    if(_imagesForRoomNo3 == nil){
        return 0;
    }

    return [_imagesForRoomNo3 count];
}

-(NSInteger)numberOfImagesLoadedForRoom4{
    
    if(_imagesForRoomNo4 == nil){
        return 0;
    }

    return [_imagesForRoomNo4 count];
}
@end
