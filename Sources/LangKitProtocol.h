//
//  LangKitProtocol.h
//  Frame
//
//  Created by 冯汉栩 on 2026/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LangKitProtocol <NSObject>

@property (nonatomic, copy, readonly, nullable) NSString *langKitLocalizationKey;
@property (nonatomic, copy, readonly, nullable) NSString *langKitLocalizationTable;

- (void)setLocalizationKey:(NSString *)localizationKey onUpdate:(nullable void (^)(NSString *key, NSString * _Nullable table, id<LangKitProtocol> object))onUpdate NS_SWIFT_NAME(setLocalization(key:onUpdate:));

- (void)setLocalizationKey:(NSString *)localizationKey table:(nullable NSString *)table onUpdate:(nullable void (^)(NSString *key, NSString * _Nullable table, id<LangKitProtocol> object))onUpdate  NS_SWIFT_NAME(setLocalization(key:table:onUpdate:));;

- (void)removeLocalization;

- (void)dialect_updateLocalization;

@end

NS_ASSUME_NONNULL_END
