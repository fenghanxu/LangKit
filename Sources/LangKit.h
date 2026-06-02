//
//  LangKit.h
//  Frame
//
//  Created by fenghanxu on 2026/6/1.
//

#import <Foundation/Foundation.h>
#import "LangKitHeader.h"
#import <LangKit/LangKitHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface LangKit : NSObject

+ (void)loadWithTable:(NSString *)table;

// MARK: Get localization dictionary

+ (NSDictionary<NSString *, NSString *> *)localizationDictionaryForTable:(nullable NSString *)table;

// MARK: Set localization dictionary

+ (void)setLocalizationDictionary:(nullable NSDictionary<NSString *, NSString *> *)dictionary table:(nullable NSString *)table update:(BOOL)update storeOnDisk:(BOOL)store NS_SWIFT_NAME(setLocalization(dictionary:table:update:storeOnDisk:));

// (主线程)保存  更新  持久化数据
+ (void)setMainLocalizationDictionary:(nullable NSDictionary<NSString *, NSString *> *)dictionary table:(nullable NSString *)table update:(BOOL)update storeOnDisk:(BOOL)store NS_SWIFT_NAME(setMainLocalization(dictionary:table:update:storeOnDisk:));

+ (void)removeLocalizationDictionaryForTable:(nullable NSString *)table update:(BOOL)update removeFromDisk:(BOOL)removeFromDisk NS_SWIFT_NAME(removeLocalizationDictionary(table:update:removeFromDisk:));

+ (void)removeLocalizationDictionaryForTable:(nullable NSString *)table unlink:(BOOL)unlink removeFromDisk:(BOOL)removeFromDisk NS_SWIFT_NAME(removeLocalizationDictionary(table:unlink:removeFromDisk:));

// MARK: Download localization dictionary

+ (void)downloadLocalizationDictionaryWithURL:(NSURL *)URL table:(nullable NSString *)table;

+ (void)downloadLocalizationDictionaryWithURLRequest:(NSURLRequest *)URLRequest table:(nullable NSString *)table;

// MARK: Get localized string

+ (NSString *)stringFor:(NSString *)localizationKey NS_SWIFT_NAME(stringFor(key:));

+ (NSString *)stringFor:(NSString *)localizationKey table:(nullable NSString *)table NS_SWIFT_NAME(stringFor(key:table:));

+ (NSString *)stringFor:(NSString *)localizationKey replace:(nullable NSDictionary<NSString *, NSString *> *)replace  NS_SWIFT_NAME(stringFor(key:replace:));

+ (NSString *)stringFor:(NSString *)localizationKey table:(nullable NSString *)table replace:(nullable NSDictionary<NSString *, NSString *> *)replace NS_SWIFT_NAME(stringFor(key:table:replace:));

+ (NSString *)stringFor:(NSString *)localizationKey table:(nullable NSString *)table bundle:(nullable NSBundle *)bundle defaultValue:(nullable NSString *)defaultValue replace:(nullable NSDictionary<NSString *, NSString *> *)replace NS_SWIFT_NAME(stringFor(key:table:bundle:defaultValue:replace:));


@end

NS_ASSUME_NONNULL_END
