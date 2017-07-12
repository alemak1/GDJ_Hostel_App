//
//  ImageManager.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageManager.h"
#import "ImageKeyConstants.h"

@interface ImageManager ()

+ (NSDictionary<NSNumber*,NSArray<NSString*>*>*) imagePathDictionary;

@end


@implementation ImageManager

#pragma mark **** VALID KEY ARRAYS FOR VALIDATION ACCESSOR FUNCTION ARGUMENTS

static NSArray<NSString*>* _validRoomNo1Keys;
static NSArray<NSString*>* _validRoomNo2Keys;
static NSArray<NSString*>* _validRoomNo3Keys;
static NSArray<NSString*>* _validRoomNo4Keys;

#pragma mark ****** OTHER STATIC CONSTANTS

static ImageManager* _sharedMyManager = nil;

static NSDictionary<NSNumber*,NSArray<NSString*>*>* _imagePathDictionary = nil;

static NSArray<NSString*>* _imageSectionNames = nil;

NSMutableDictionary<NSString*,UIImage*>* _imageCache = nil;

+ (NSArray<NSString*>*) imageSectionNames{
    
    if(_imageSectionNames == nil){
        _imageSectionNames = [[ImageManager imagePathDictionary] allKeys];
    }
    
    return _imageSectionNames;
}

/** The dictionary of image name paths, organized by section, can be accessed as a static property **/

+ (NSDictionary<NSNumber *,NSArray<NSString *> *> *)imagePathDictionary{
    
    
    if(_imagePathDictionary == nil){
    
    _imagePathDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                            
            //Image paths for Room Number 1
            @[kRoomNo1_1,kRoomNo1_2,kRoomNo1_3,kRoomNo1_4,kRoomNo1_5],SECTION_ROOM_NO1,
                            
            //Image paths for Room Number 2
            @[kRoomNo2_1,kRoomNo2_2,kRoomNo2_3,kRoomNo2_4,kRoomNo2_5,kRoomNo2_6,kRoomNo2_7],SECTION_ROOM_NO2,
                
            //Image paths for Room Number 3
            @[kRoomNo3_1,kRoomNo3_2,kRoomNo3_3,kRoomNo3_4,kRoomNo3_5,kRoomNo3_6,kRoomNo3_7,
              kRoomNo3_7,kRoomNo3_8,kRoomNo3_9,kRoomNo3_10,kRoomNo3_11,kRoomNo3_12],SECTION_ROOM_NO3,
                
            //Image paths for Room Number 4
            @[kRoomNo4_1,kRoomNo4_2,kRoomNo4_3,kRoomNo4_4,kRoomNo4_5,kRoomNo4_6,kRoomNo4_7,kRoomNo4_8,kRoomNo4_9,kRoomNo4_9],SECTION_ROOM_NO4,
            
            //Image paths for Bathrooms
            @[kBathRoomNo1_1,kBathRoomNo2_1,kBathRoomNo2_2],SECTION_BATHROOMS,
                            
            //Image paths for Lobby
            @[kLobby_1,kLobby_2],SECTION_LOBBY,
                            
            //Image paths for Guests
            @[kGuests1,kGuests2,kGuests3,kGuests4,kGuests5,kGuests6,kGuests7],SECTION_GUESTS,
                            
            //Image paths for Logo
            /**@[kLogo_1,kLogo_2,kLogo_3,kWallLogo],SECTION_OTHER,**/ nil];
    }
    
    return _imagePathDictionary;
}

/** Total nubmer of section keys **/

+ (NSInteger) numberOfSections{
    
    return [[[ImageManager imagePathDictionary] allKeys] count];
    
}

/** Total number of items in a section **/

+ (NSInteger) numberOfItemsInSection:(NSString*)sectionKeyString{
    
    NSArray* sectionPathArray = [[ImageManager imagePathDictionary] valueForKey:sectionKeyString];
    
    return [sectionPathArray count];
}

+ (NSInteger) numberOfItemsInSectionForSectionKeyEnum:(SectionKey)sectionKeyNumber{
    
    NSString* stringKey = [self getSectionStringKeyForSectionEnumValue:sectionKeyNumber];
    
    NSArray* sectionPathArray = [[ImageManager imagePathDictionary] valueForKey:stringKey];
    
    return [sectionPathArray count];
}




+ (NSString*) getImageNameForIndexPath:(NSIndexPath*)indexPath{
    
    int section = (int)[indexPath section];
    int row = (int)[indexPath row];
    
    NSArray* imagePathArray = [[ImageManager imagePathDictionary] valueForKey:[ImageManager getSectionStringKeyForSectionEnumValue:section]];
    
    if(row >= imagePathArray.count){
        return nil;
    }
    
    return [imagePathArray objectAtIndex:row];
    
}



+ (NSString*) getSectionStringKeyForSectionEnumValue:(SectionKey)sectionKey{
    
    switch (sectionKey) {
        case ROOM_NO1:
            return SECTION_ROOM_NO1;
        case ROOM_NO2:
            return SECTION_ROOM_NO2;
        case ROOM_NO3:
            return SECTION_ROOM_NO3;
        case ROOM_NO4:
            return SECTION_ROOM_NO4;
        case BATHROOMS:
            return SECTION_BATHROOMS;
        case LOBBY:
            return SECTION_LOBBY;
        case KITCHEN:
            return SECTION_KITCHEN;
        case GUESTS:
            return SECTION_GUESTS;
        case OTHER:
            return SECTION_OTHER;
        default:
            break;
    }
    
    return nil;
}


#pragma mark ******** INITIALIZERS 

+(ImageManager*)sharedManager{
    
    if(!_sharedMyManager) {
        _sharedMyManager = [[ImageManager alloc]init];
    }
    
    return _sharedMyManager;
}

-(id)init{
    if(self = [super init]){
        
        _imageCache = [[NSMutableDictionary alloc] init];
        
        for (NSString*sectionName in _imageSectionNames) {
            
            [_imageCache setObject:[[NSMutableDictionary alloc]init] forKey:sectionName];
            
            NSArray* pathNameArray = [[ImageManager imagePathDictionary] valueForKey:sectionName];
            
            for (NSString*imageKeyName in pathNameArray) {
                
                [_imageCache setValue:nil forKey:imageKeyName];

            }
            
            
        }
        
    }
    
    return self;
}

- (void) loadDictForRoomNo1{
    
    NSLog(@"Preparing to load images for Room No 1");
    
    [self loadImagesForSectionKey:ROOM_NO1];
    
}

- (void) loadDictForRoomNo2{
    
    NSLog(@"Preparing to load images for Room No 2");

    [self loadImagesForSectionKey:ROOM_NO2];
   
}

- (void) loadDictForRoomNo3{
    NSLog(@"Preparing to load images for Room No 3");

    [self loadImagesForSectionKey:ROOM_NO3];
    
   }

- (void) loadDictForRoomNo4{
    NSLog(@"Preparing to load images for Room No 4");

    [self loadImagesForSectionKey:ROOM_NO4];
  
}

- (void) loadDictForLobby{
    NSLog(@"Preparing to load images for Lobby");

    [self loadImagesForSectionKey:LOBBY];
    

}

- (void) loadDictForKitchen{
    NSLog(@"Preparing to load images for Kitchen");

    [self loadImagesForSectionKey:KITCHEN];
  

}

- (void) loadDictForGuests{
    NSLog(@"Preparing to load images for Guests");

    [self loadImagesForSectionKey:GUESTS];
    
   
}

- (void) loadDictForOther{
    NSLog(@"Preparing to load images for Others");

    [self loadImagesForSectionKey:OTHER];

   
}

- (void) loadDictForBathrooms{
    NSLog(@"Preparing to load images for Bathrooms");

    [self loadImagesForSectionKey:BATHROOMS];
  
    
}

- (void) loadImagesForSectionKey:(SectionKey)sectionKey{
    NSLog(@"Loading the images for section key: %d", sectionKey);
    
    NSString* sectionStringKey = [ImageManager getSectionStringKeyForSectionEnumValue:sectionKey];
    
    NSArray<NSString*>* pathNames = [[ImageManager imagePathDictionary] valueForKey:sectionStringKey];
    
    
    NSLog(@"The following path names have been loaded for Section Key: %d", sectionKey);
    for (NSString*pathName in pathNames) {
        
        NSLog(@"PathName: %@",pathName);
        
        
        [_imageCache setValue:[UIImage imageNamed:pathName] forKey:pathName];
    }
    
    
}


- (void) unloadDictForRoomNo1{
    [self unloadImagesForSectionKey:ROOM_NO1];
}

- (void) unloadDictForRoomNo2{
    [self unloadImagesForSectionKey:ROOM_NO2];

}

- (void) unloadDictForRoomNo3{
    [self unloadImagesForSectionKey:ROOM_NO3];

}

- (void) unloadDictForRoomNo4{
    [self unloadImagesForSectionKey:ROOM_NO4];

}

- (void) unloadDictForLobby{
    [self unloadImagesForSectionKey:LOBBY];

}

- (void) unloadDictForKitchen{
    [self unloadImagesForSectionKey:KITCHEN];

}

- (void) unloadDictForGuests{
    [self unloadImagesForSectionKey:GUESTS];

}

- (void) unloadDictForOther{
    [self unloadImagesForSectionKey:OTHER];

}

- (void) unloadDictForBathrooms{
    [self unloadImagesForSectionKey:ROOM_NO1];

}


- (void) unloadImagesForSectionKey:(SectionKey)sectionKey{
    NSLog(@"Loading the images for section key: %d", sectionKey);
    
    NSString* sectionStringKey = [ImageManager getSectionStringKeyForSectionEnumValue:sectionKey];
    
    NSArray<NSString*>* pathNames = [[ImageManager imagePathDictionary] valueForKey:sectionStringKey];
    
    
    NSLog(@"The following path names have been loaded for Section Key: %d", sectionKey);
    for (NSString*pathName in pathNames) {
        
        NSLog(@"PathName: %@",pathName);
        
        [_imageCache setValue:nil forKey:pathName];
    }
    
}


- (UIImage*) getImageForRoom1ForRow:(NSInteger)row{
    
    
    NSArray* imageNames = [_imagePathDictionary valueForKey:SECTION_ROOM_NO1];
    
    NSString* imageName = [imageNames objectAtIndex:row];
    
    return [_imageCache valueForKey:imageName];
    
}

- (UIImage*) getImageForRoom2ForRow:(NSInteger)row{
    
    
    NSArray* imageNames = [_imagePathDictionary valueForKey:SECTION_ROOM_NO2];
    
    NSString* imageName = [imageNames objectAtIndex:row];
    
    return [_imageCache valueForKey:imageName];
    
}

- (UIImage*) getImageForRoom3ForRow:(NSInteger)row{
    
    
    NSArray* imageNames = [_imagePathDictionary valueForKey:SECTION_ROOM_NO3];
    
    NSString* imageName = [imageNames objectAtIndex:row];
    
    return [_imageCache valueForKey:imageName];
    
}

- (UIImage*) getImageForRoom4ForRow:(NSInteger)row{
    
    
    NSArray* imageNames = [_imagePathDictionary valueForKey:SECTION_ROOM_NO4];
    
    NSString* imageName = [imageNames objectAtIndex:row];
    
    return [_imageCache valueForKey:imageName];
    
}

- (UIImage*) getImageForRoomNo1:(NSString*)keyRoomNo1{
    
    if(![[ImageManager validRoomNo1Keys] containsObject:keyRoomNo1]){
        NSException* invalidRoomNo1KeyException = [NSException exceptionWithName:@"InvalidRoomNo1KeyException" reason:@"Invalid string provided as an argument; Only valid RoomNo2 keys may be passed as valid arguments to the function" userInfo:nil];
        @throw invalidRoomNo1KeyException;
        
        
    }
    
   
    return [_imageCache valueForKey:keyRoomNo1];
 
}

- (UIImage*) getImageForRoomNo2:(NSString*)keyRoomNo2{
    
    if(![[ImageManager validRoomNo2Keys] containsObject:keyRoomNo2]){
        NSException* invalidRoomNo1KeyException = [NSException exceptionWithName:@"InvalidRoomNo1KeyException" reason:@"Invalid string provided as an argument; Only valid RoomNo2 keys may be passed as valid arguments to the function" userInfo:nil];
        @throw invalidRoomNo1KeyException;
        
    }
    
    return [_imageCache valueForKey:keyRoomNo2];

}

- (UIImage*) getImageForRoomNo3:(NSString*)keyRoomNo3{

    if(![[ImageManager validRoomNo1Keys] containsObject:keyRoomNo3]){
        NSException* invalidRoomNo1KeyException = [NSException exceptionWithName:@"InvalidRoomNo1KeyException" reason:@"Invalid string provided as an argument; Only valid RoomNo3 keys may be passed as valid arguments to the function" userInfo:nil];
        @throw invalidRoomNo1KeyException;
        
        
    }
    
    return [_imageCache valueForKey:keyRoomNo3];

    
}

- (UIImage*) getImageForRoomNo4:(NSString*)keyRoomNo4{
    
    if(![[ImageManager validRoomNo1Keys] containsObject:keyRoomNo4]){
        NSException* invalidRoomNo1KeyException = [NSException exceptionWithName:@"InvalidRoomNo1KeyException" reason:@"Invalid string provided as an argument; Only valid RoomNo4 keys may be passed as valid arguments to the function" userInfo:nil];
        @throw invalidRoomNo1KeyException;
        
        
    }
    return [_imageCache valueForKey:keyRoomNo4];

}

- (UIImage*) getImageForLobby:(NSString*)keyLobby{
    return [_imageCache valueForKey:keyLobby];

}

- (UIImage*) getImageForGuests:(NSString*)keyGuests{
    return [_imageCache valueForKey:keyGuests];
}

- (UIImage*) getImageForKitchen:(NSString*)keyKitchen{
    return [_imageCache valueForKey:keyKitchen];

}


- (UIImage*) getImageForOther:(NSString*)keyOther{
    return [_imageCache valueForKey:keyOther];

}

- (UIImage*) getImageForBathrooms:(NSString*)keyBathrooms{
    return [_imageCache valueForKey:keyBathrooms];

}

-(UIImage*) getImageForIndexPath:(NSIndexPath*)indexPath{
    
    NSString* imageName = [ImageManager getImageNameForIndexPath:indexPath];
    
    return [_imageCache valueForKey:imageName];
}


+(NSArray<NSString*>*) validRoomNo1Keys{
    
    if(!_validRoomNo1Keys){
        _validRoomNo1Keys = @[kRoomNo1_1,kRoomNo1_2,kRoomNo1_3,kRoomNo1_4,kRoomNo1_5];
    }
    
    return _validRoomNo1Keys;
}

+(NSArray<NSString*>*) validRoomNo2Keys{
    
    if(!_validRoomNo2Keys){
        _validRoomNo2Keys = @[kRoomNo2_1,kRoomNo2_2,kRoomNo2_3,kRoomNo2_4,kRoomNo2_5,kRoomNo2_6,kRoomNo2_7];
    }
    
    return _validRoomNo2Keys;
}

+(NSArray<NSString*>*) validRoomNo3Keys{
 
    if(!_validRoomNo3Keys){
        _validRoomNo3Keys = @[kRoomNo3_1,kRoomNo3_2,kRoomNo3_3,kRoomNo3_4,kRoomNo3_5,kRoomNo3_6, kRoomNo3_7,kRoomNo3_8,kRoomNo3_9,kRoomNo3_10,kRoomNo3_11,kRoomNo3_12];
    }
    
    return _validRoomNo3Keys;
}

+(NSArray<NSString*>*) validRoomNo4Keys{
    
    if(!_validRoomNo4Keys){
        _validRoomNo4Keys = @[kRoomNo4_1,kRoomNo4_2,kRoomNo4_3,kRoomNo4_4,kRoomNo4_5,kRoomNo4_5,kRoomNo4_6,kRoomNo4_7,kRoomNo4_8,kRoomNo4_9,kRoomNo4_9,kRoomNo4_10,kRoomNo4_11,kRoomNo4_12];
    }
    
    return _validRoomNo4Keys;
    
}



@end
