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

#import "LangKit.h"
#import "LangKitHeader.h"
#import "LangKitProtocol.h"

FOUNDATION_EXPORT double LangKitVersionNumber;
FOUNDATION_EXPORT const unsigned char LangKitVersionString[];

