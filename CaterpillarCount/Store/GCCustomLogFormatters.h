//
//  GCCustomLogFormatters.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface CustomLogFormatters : NSObject <DDLogFormatter>


@end


//Add other custom formatters if you want the messages displayed differently in say the console vs. the log file