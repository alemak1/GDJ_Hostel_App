//
//  AudioController.h
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef AudioController_h
#define AudioController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AudioController : NSObject

typedef enum AudioSectionKeyEnum{
    TRANSPORTATION = 0,
    HEALTH_MEDICAL,
    DIRECTIONS,
    FUN_PHRASES,
    BANKING,
    RESTAURANTS,
    FOOD,
    BASIC_PHRASES,
    CURRENCY,
    LAST_AUDIO_SECTION_INDEX
    
}AudioSectionKeyEnum;



- (instancetype)init;

- (void)tryPlayMusic;
- (void)playSystemSound;
- (void)setCurrentSoundIndexTo:(NSIndexPath*)indexPath;


@end

#endif /* AudioController_h */
