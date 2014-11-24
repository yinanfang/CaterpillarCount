//
//  GCAppConfig.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// Theme Color
#define ThemeColor01                0x355D3DFF  // Green
#define ThemeColor01_Variation01    0x113C1BFF
#define WhiteFading                 0xFFFFFF45  //

// Font and Size
#define Font_Logo                   @"Chalkduster"
#define Font_Title                  @"AppleGothic"
#define Font_Paragraph              @"AppleGothic"
#define FontSize_H1                 18.0f
#define FontSize_H2                 16.0f
#define FontSize_P1                 14.0f
#define WidthForEntryfieldBorder    1.0f
#define CornerRadius_General        10.0f

// Animation
#define AnimationDuration_Short     0.25
#define AnimationDelay_Short        0

// General Layout Metrics
// For MASConstraintMaker
#define mas_Padding_Page_Large          UIEdgeInsetsMake(20, 20, -20, -20)
#define mas_Padding_Page_Small          UIEdgeInsetsMake(5, 5, -5, -5)
#define mas_Padding_Page_Default          UIEdgeInsetsMake(8, 8, -8, -8)
// For UIKit
#define Insets_Default              UIEdgeInsetsMake(8, 8, 8, 8)
#define Insets_Small               UIEdgeInsetsMake(5, 5, 5, 5)

// Table View Configuration
#define CellIdentifierForOrderTableViewCell @"OrderTableViewCellIdentifier"

// Don't change this
#pragma mark - CocoaLumberjack Logging Constant
#import <CocoaLumberjack/CocoaLumberjack.h>
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif
// Add a testing color for XcodeColors
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background
#define DDLogTest(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

@interface GCAppConfig : NSObject

#pragma mark - Domain
FOUNDATION_EXPORT NSString *const DevelopmentDomain;
FOUNDATION_EXPORT NSString *const ProductionDomain;
FOUNDATION_EXPORT NSString *const URIPathToUsersPHP;
FOUNDATION_EXPORT NSString *const URIPathToSitesPHP;
FOUNDATION_EXPORT NSString *const URIPathToSubmissionPHP;
FOUNDATION_EXPORT NSString *const URLPathToImageSubmissionPHP;

#pragma mark - NSUserDefaults values
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForDidShownTour;
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForDidRunAppBefore;
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForAppData;

#pragma mark - Default Value

#pragma mark - General
@property CGFloat PixelAdjustForHorizontalGap;
typedef NS_ENUM(NSInteger, PagePaddingOption) {
    PagePaddingSmall,
    PagePaddingLarge,
};

typedef NS_ENUM(NSInteger, PickerType) {
    PickerType_Temperature,
    PickerType_Site,
    PickerType_Circle,
    PickerType_Survey,
    PickerType_Herbivory,
    PickerType_Order,
};


//@property StoryDisplayStyleMode storyDisplayStyleMode;














@end
