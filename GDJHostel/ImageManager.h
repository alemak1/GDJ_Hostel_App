//
//  ImageManager.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ImageManager_h
#define ImageManager_h

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

typedef enum{
    ROOM_NO1 = 1,
    ROOM_NO2,
    ROOM_NO3,
    ROOM_NO4,
    BATHROOMS,
    LOBBY,
    KITCHEN,
    GUESTS,
    OTHER
}SectionKey;



+ (id)sharedManager;

/** Class methods **/

+ (NSString*) getImageNameForIndexPath:(NSIndexPath*)indexPath;
+ (NSInteger) numberOfSections;
+ (NSInteger) numberOfItemsInSection:(NSString*)sectionKeyString;
+ (NSInteger) numberOfItemsInSectionForSectionKeyEnum:(SectionKey)sectionKeyNumber;

/** Image getter methods **/

- (UIImage*) getImageForRoom1ForRow:(NSInteger)row;
- (UIImage*) getImageForRoom2ForRow:(NSInteger)row;
- (UIImage*) getImageForRoom3ForRow:(NSInteger)row;
- (UIImage*) getImageForRoom4ForRow:(NSInteger)row;


- (UIImage*) getImageForRoomNo1:(NSString*)keyRoomNo1;
- (UIImage*) getImageForRoomNo2:(NSString*)keyRoomNo2;
- (UIImage*) getImageForRoomNo3:(NSString*)keyRoomNo3;
- (UIImage*) getImageForRoomNo4:(NSString*)keyRoomNo4;
- (UIImage*) getImageForLobby:(NSString*)keyLobby;
- (UIImage*) getImageForGuests:(NSString*)keyGuests;
- (UIImage*) getImageForKitchen:(NSString*)keyKitchen;
- (UIImage*) getImageForOther:(NSString*)keyOther;

- (UIImage*) getImageForIndexPath:(NSIndexPath*)indexPath;

/** Dictionary cache-loading methods **/

- (void) loadDictForRoomNo1;
- (void) loadDictForRoomNo2;
- (void) loadDictForRoomNo3;
- (void) loadDictForRoomNo4;
- (void) loadDictForLobby;
- (void) loadDictForKitchen;
- (void) loadDictForGuests;
- (void) loadDictForOther;
- (void) loadDictForBathrooms;

- (void) unloadDictForRoomNo1;
- (void) unloadDictForRoomNo2;
- (void) unloadDictForRoomNo3;
- (void) unloadDictForRoomNo4;
- (void) unloadDictForLobby;
- (void) unloadDictForKitchen;
- (void) unloadDictForGuests;
- (void) unloadDictForOther;
- (void) unloadDictForBathrooms;



@end

#endif /* ImageManager_h */
