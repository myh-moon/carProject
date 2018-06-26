#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "EATheme.h"
#import "EAThemesConfiguration.h"
#import "EAThemeManager.h"
#import "EA_metamacros.h"
#import "UIView+EATheme.h"

FOUNDATION_EXPORT double EAThemeVersionNumber;
FOUNDATION_EXPORT const unsigned char EAThemeVersionString[];

