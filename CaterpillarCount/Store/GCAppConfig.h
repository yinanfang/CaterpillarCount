//
//  GCAppConfig.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// Theme Color
#define ThemeColor01                0x355D3DFF
#define ThemeColor01_Variation01    0x113C1BFF

// Font and Size
#define FontSize_h1                 18.0f
#define FontSize_h2                 16.0f
#define FontSize_p1                 16.0f
#define WidthForEntryfieldBorder    1.0f
#define CornerRadius_General        10.0f

// General Layout Metrics
#define Padding_Page_Large          UIEdgeInsetsMake(20, 20, -20, -20)
#define Padding_Page_Small          UIEdgeInsetsMake(5, 5, -5, -5)
#define Insets_Button               UIEdgeInsetsMake(8, 10, 8, 10)

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
FOUNDATION_EXPORT NSString *const URIPathToSubmissionPHP;

#pragma mark - NSUserDefaults values
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForDidShownTour;
FOUNDATION_EXPORT NSString *const NSUserDefaultsKeyForUserInfo;

#pragma mark - Default Value
@property NSNumber *defaultStoryCount, *defaultBookCount;

#pragma mark - Book Specific
//@property NSInteger bookCurrentPageNumber;
@property CGRect PageControlRect, BookTitleViewRect;

#pragma mark - Story Specific
@property CGFloat WidthForSmallStory, HeightForSmallStory;
@property CGFloat WidthForCurrentStory, HeightForCurrentStory;
@property CGRect BoundsForStoryCollectionController;

#pragma mark - General
@property CGFloat PixelAdjustForHorizontalGap;
@property CGFloat HeightDeterminant_FloatVSFullScreen;
typedef NS_ENUM(NSInteger, PagePaddingOption) {
    PagePaddingSmall,
    PagePaddingLarge,
};
//@property StoryDisplayStyleMode storyDisplayStyleMode;














@end
