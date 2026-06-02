//
//  LangKit.m
//  Frame
//
//  Created by fenghanxu on 2026/6/1.
//

#import "LangKit.h"

@implementation LangKit

+ (void)load {
    // 加载默认表格
    NSString *filePath = [self filePathForTable:nil];
    NSLog(@"filePath: %@",filePath);
    //文件管理器是否存在提供给你给路径的文件
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSLog(@"fileExists: %d",fileExists);
    if (fileExists) {
        //读取指定路径的文件，将其解析为字典，并将字典存储在内存中
        NSLog(@"filePath: %@",filePath);
        [self loadFromDiskAtPath:filePath table:nil];
    }
    
    // 加载自定义表格
    NSString *directory = [self directoryForTable:@""];
    NSLog(@"directory: %@",directory);
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
    NSLog(@"directoryContents: %@",directoryContents);
    for (NSString *file in directoryContents) {
        NSLog(@"file: %@",file);
        // 获取文件名（表格名）
        NSString *table = [file stringByDeletingPathExtension];
        NSLog(@"table: %@",table);
        // 获取自定义表格的文件路径
        NSString *filePath = [directory stringByAppendingString:file];
        NSLog(@"filePath: %@",filePath);
        if (table && filePath) {
            //读取指定路径的文件，将其解析为字典，并将字典存储在内存中
            [self loadFromDiskAtPath:filePath table:table];
        }
    }
}

+ (void)loadWithTable:(NSString *)table {
    // 加载默认表格
    NSString *filePath = [self filePathForTable:table];
    //文件管理器是否存在提供给你给路径的文件
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists) {
        //读取指定路径的文件，将其解析为字典，并将字典存储在内存中
        [self loadFromDiskAtPath:filePath table:table];
    }
    
    // 加载自定义表格
    NSString *directory = [self directoryForTable:@""];
    NSArray *directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
    for (NSString *file in directoryContents) {
        // 获取文件名（表格名）
        NSString *table = [file stringByDeletingPathExtension];
        // 获取自定义表格的文件路径
        NSString *filePath = [directory stringByAppendingString:file];
        if (table && filePath) {
            //读取指定路径的文件，将其解析为字典，并将字典存储在内存中
            [self loadFromDiskAtPath:filePath table:table];
        }
    }
}

//读取指定路径的文件，将其解析为字典，并将字典存储在内存中
+ (void)loadFromDiskAtPath:(NSString *)filePath table:(NSString *)table {
    // 从文件路径读取数据
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    // 如果数据存在
    if (data) {
        // 尝试将JSON数据解析为可变容器（NSDictionary）
        NSError *parseError = nil;
        //二进制数据 (NSData) 解析成 JSON对象
        id JSONObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
        
        // 检查解析的对象是否为字典类型
        if ([JSONObject isKindOfClass:[NSDictionary class]]) {
            // 将字典存储在内存中
            if (!table) {
                // 如果表格为空，则更新主表的字典
                _mainTableDictionary = (NSDictionary *)JSONObject;
            } else {
                // 如果表格不为空，则更新自定义表的字典
                NSMutableDictionary *customTableDictionaries = [self customTableDictionaries];
                [customTableDictionaries setObject:(NSDictionary *)JSONObject forKey:table];
            }
        }
    }
}

// MARK: Helper functions
// 获取指定表格的目录路径   路径
+ (NSString *)directoryForTable:(NSString *)table {
    // 获取应用沙盒中的Document目录路径，并拼接上 "/dialect/"，作为默认目录路径
    NSString* directory = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/LangKit/"];
    
    // 如果有指定表格名，则拼接上 "/tables/"，作为自定义表格的目录路径
    if (table) {
        directory = [directory stringByAppendingString:@"tables/"];
    }
    
    // 返回最终目录路径
    return directory;
}

// 获取指定表格的文件路径(其实就是路径+文件名)
+ (NSString *)filePathForTable:(NSString *)table {
    // 默认文件名为 "main.json"
    NSString *filename = @"main.json";//用于单表格的保存名称
    
    // 如果有指定表格名，则使用表格名替换文件名中的 "main"，并加上 ".json" 后缀
    if (table) {
        filename = [NSString stringWithFormat:@"%@.json", table];
    }
    
    // 拼接目录路径和文件名，得到最终的文件路径
    NSString *filePath = [[self directoryForTable:table] stringByAppendingString:filename];
    NSLog(@"filePath: %@",filePath);
    // 返回最终文件路径
    return filePath;
}




// MARK: Store localization dictionaries
// 静态变量，用于存储主表格的字典数据，默认为nil
static NSDictionary *_mainTableDictionary = nil;

// 获取主表格的字典数据
+ (NSDictionary *)mainTableDictionary {
    return _mainTableDictionary;
}

// 获取自定义表格字典数据的静态方法
+ (NSMutableDictionary *)customTableDictionaries {
    // 静态变量，用于存储自定义表格字典数据，默认为nil
    static NSMutableDictionary *_customTableDictionaries;

    // 使用dispatch_once确保该初始化操作只执行一次，避免多线程问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _customTableDictionaries = [[NSMutableDictionary alloc] init];
    });

    // 返回自定义表格字典数据
    return _customTableDictionaries;
}




// MARK: Store localizable objects

// 获取主表格本地化对象的NSHashTable
+ (NSHashTable *)mainTableLocalizables {
    // 静态变量，用于存储主表格的本地化对象，采用弱引用方式
    static NSHashTable *_mainTableLocalizables;

    // 使用dispatch_once确保该初始化操作只执行一次，避免多线程问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mainTableLocalizables = [NSHashTable weakObjectsHashTable];
    });

    // 返回主表格的本地化对象
    return _mainTableLocalizables;
}

// 获取自定义表格本地化对象的NSMutableDictionary
+ (NSMutableDictionary *)customTableLocalizables {
    // 静态变量，用于存储自定义表格的本地化对象，默认为nil
    static NSMutableDictionary *_customTableLocalizables;

    // 使用dispatch_once确保该初始化操作只执行一次，避免多线程问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _customTableLocalizables = [[NSMutableDictionary alloc] init];
    });

    // 返回自定义表格的本地化对象
    return _customTableLocalizables;
}


// 添加本地化对象到集合中的方法
+ (void)addLocalizable:(id<LangKitProtocol>)localizableObject {
    // 检查本地化对象是否存在
    if (localizableObject) {
        // 获取本地化对象所属的表格名
        NSString *table = localizableObject.langKitLocalizationTable;

        // 获取主表格的本地化对象集合
        NSHashTable *hashTable = [self mainTableLocalizables];
        
        // 如果存在表格名
        if (table) {
            // 获取自定义表格的本地化对象集合
            hashTable = [[self customTableLocalizables] objectForKey:table];
            
            // 如果自定义表格的本地化对象集合不存在，则创建一个弱引用的哈希表
            if (!hashTable) {
                hashTable = [NSHashTable weakObjectsHashTable];
                // 将自定义表格的本地化对象集合存储到静态变量中
                [[self customTableLocalizables] setObject:hashTable forKey:table];
            }
        }
        
        // 将本地化对象添加到对应的本地化对象集合中
        [hashTable addObject:localizableObject];
    }
}

// 从集合中移除本地化对象的方法
+ (void)removeLocalizable:(id<LangKitProtocol>)localizableObject {
    // 检查本地化对象是否存在
    if (localizableObject) {
        // 获取本地化对象所属的表格名
        NSString *table = localizableObject.langKitLocalizationTable;
        
        // 获取主表格的本地化对象集合
        NSHashTable *hashTable = [self mainTableLocalizables];
        
        // 如果存在表格名
        if (table) {
            // 获取自定义表格的本地化对象集合
            hashTable = [[self customTableLocalizables] objectForKey:table];
            
            // 从本地化对象集合中移除指定的本地化对象
            [hashTable removeObject:localizableObject];
            
            // 如果该表格的本地化对象集合为空，则从自定义表格的本地化对象字典中移除该表格
            if (hashTable.count == 0) {
                [[self customTableLocalizables] removeObjectForKey:table];
            }
        } else {
            // 如果不存在表格名，则直接从主表格的本地化对象集合中移除指定的本地化对象
            [hashTable removeObject:localizableObject];
        }
    }
}




// MARK: Get localization dictionary
// 获取指定表格的本地化字典的方法
+ (NSDictionary<NSString *, NSString *> *)localizationDictionaryForTable:(NSString *)table {
    // 如果表格名为空，则返回主表格的本地化字典
    if (!table) {
        return [self mainTableDictionary];
    } else {
        // 如果表格名不为空，则返回自定义表格字典中对应表格的本地化字典
        NSLog(@"[self customTableDictionaries]: %@",[self customTableDictionaries]);
        return [[self customTableDictionaries] objectForKey:table];
    }
}


// MARK: Set localization dictionary

// 设置本地化字典的方法，用于更新内存中的本地化数据，可选择是否更新和是否存储到磁盘
+ (void)setLocalizationDictionary:(NSDictionary<NSString *, NSString *> *)dictionary table:(NSString *)table update:(BOOL)update storeOnDisk:(BOOL)store {
    // 检查传入的字典是否存在且为NSDictionary类的实例
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {
        
        // 在主线程异步执行
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 存储在内存中
            NSDictionary *previousDictionary = nil;
            if (!table) {
                // 如果表为空，则更新主表的字典
                previousDictionary = _mainTableDictionary;
                _mainTableDictionary = dictionary;
            } else {
                // 如果表不为空，则更新自定义表的字典
                NSMutableDictionary *customTableDictionaries = [self customTableDictionaries];
                previousDictionary = [customTableDictionaries objectForKey:table];
                //[customTableDictionaries setObject:dictionary forKey:table];
                customTableDictionaries = [dictionary mutableCopy];
            }
            
            // 更新本地化对象
            if (update) {
                [self updateLocalizablesForTable:table previousDictionary:previousDictionary newDictionary:dictionary force:NO];
            }
            
            // 存储到磁盘
            if (store) {
                // 在全局队列异步执行
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    // 如果需要，创建目录
                    BOOL* isDirectory = NULL;  // 用于存储是否为目录的指针，初始化为NULL
                    NSString *directory = [self directoryForTable:table];  // 获取指定表的目录路径
                    BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:isDirectory];  // 判断目录是否已存在
                    if (!directoryExists) {  // 如果目录不存在
                        NSError* error = NULL;  // 用于存储错误信息的指针，初始化为NULL
                        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:&error];  // 创建目录，不递归创建中间目录，将错误信息存储在error中
                    }

                    // 写入磁盘
                    NSError *parseError = nil;  // 用于存储解析错误的指针，初始化为NULL
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];  // 将字典转换为JSON格式的NSData数据，使用NSJSONWritingPrettyPrinted选项进行格式化

                    if (data && !parseError) {  // 如果数据不为空且解析无错误
                        NSString *filePath = [self filePathForTable:table];  // 获取指定表的文件路径
                        NSDictionary *attributes = @{  // 文件属性，包括创建日期和文件大小
                            NSFileCreationDate: [NSDate date],  // 当前日期作为文件创建日期
                            NSFileSize: @(data.length)  // 数据长度作为文件大小
                        };
                        NSLog(@"filePath: %@", filePath);
                        [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:attributes];  // 创建文件，写入数据，并设置文件属性
                    }

                });
            }
        });
    }
}

// (主线程)设置本地化字典的方法，用于更新内存中的本地化数据，可选择是否更新和是否存储到磁盘
+ (void)setMainLocalizationDictionary:(NSDictionary<NSString *, NSString *> *)dictionary table:(NSString *)table update:(BOOL)update storeOnDisk:(BOOL)store {
    // 检查传入的字典是否存在且为NSDictionary类的实例
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]]) {

        NSDictionary *previousDictionary = nil;//用于更新某个语言列表(例如: 整个日语列表数据)
        if (!table) {//单表格   table为nil
            // 存储旧的表格
            previousDictionary = _mainTableDictionary;
            // 赋值新的表格
            _mainTableDictionary = dictionary;
        } else {//多表格  table不为空
            // 如果表不为空，则更新自定义表的字典
            NSMutableDictionary *customTableDictionaries = [self customTableDictionaries];
            previousDictionary = [customTableDictionaries objectForKey:table];
            [customTableDictionaries setObject:dictionary forKey:table];
            NSLog(@"customTableDictionaries: %@",customTableDictionaries);
        }
        
        // 更新本地化对象
        if (update) {
            [self updateLocalizablesForTable:table previousDictionary:previousDictionary newDictionary:dictionary force:NO];
        }
        
        // 存储到磁盘
        if (store) {
            // 在全局队列异步执行
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                // 如果需要，创建目录
                BOOL* isDirectory = NULL;  // 用于存储是否为目录的指针，初始化为NULL
                NSString *directory = [self directoryForTable:table];  // 获取指定表的目录路径
                BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:isDirectory];  // 判断目录是否已存在
                if (!directoryExists) {  // 如果目录不存在
                    NSError* error = NULL;  // 用于存储错误信息的指针，初始化为NULL
                    
                    
                    if (table) {
                        NSString *directFile = [self directoryForTable:nil];
                        BOOL directFileExists = [[NSFileManager defaultManager] fileExistsAtPath:directFile isDirectory:isDirectory];
                        if (!directFileExists) {
                            NSLog(@"directFile:%@",directFile);
                            BOOL directFileResult = [[NSFileManager defaultManager] createDirectoryAtPath:directFile withIntermediateDirectories:NO attributes:nil error:&error];
                            NSLog(@"directFileResult: %d",directFileResult);
                        }
                    }
                    
                    
                    
                    NSLog(@"directory:%@",directory);
                   BOOL creatFile = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:NO attributes:nil error:&error];  // 创建目录，不递归创建中间目录，将错误信息存储在error中
                    NSLog(@"creatFile: %d",creatFile);
                }

                // 写入磁盘
                NSError *parseError = nil;  // 用于存储解析错误的指针，初始化为NULL
                NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];  // 将字典转换为JSON格式的NSData数据，使用NSJSONWritingPrettyPrinted选项进行格式化

                if (data && !parseError) {  // 如果数据不为空且解析无错误
                    NSString *filePath = [self filePathForTable:table];  // 获取指定表的文件路径
                    NSDictionary *attributes = @{  // 文件属性，包括创建日期和文件大小
                        NSFileCreationDate: [NSDate date],  // 当前日期作为文件创建日期
                        NSFileSize: @(data.length)  // 数据长度作为文件大小
                    };
                    NSLog(@"filePath: %@",filePath);
                    BOOL relust = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:attributes];  // 创建文件，写入数据，并设置文件属性
                    NSLog(@"relust: %d",relust);
                }

            });
        }
    }
}

// 移除指定表格的本地化字典的方法，可选择是否更新本地化对象和从磁盘中移除
+ (void)removeLocalizationDictionaryForTable:(NSString *)table update:(BOOL)update removeFromDisk:(BOOL)removeFromDisk {
    // 调用方法，移除指定表格的本地化字典，选择不解除链接，可选择是否更新本地化对象和从磁盘中移除
    [self removeLocalizationDictionaryForTable:table update:update unlink:NO removeFromDisk:removeFromDisk];
}

// 移除指定表格的本地化字典的方法，可选择是否解除链接和从磁盘中移除
+ (void)removeLocalizationDictionaryForTable:(NSString *)table unlink:(BOOL)unlink removeFromDisk:(BOOL)removeFromDisk {
    // 调用方法，移除指定表格的本地化字典，选择不更新本地化对象，可选择是否解除链接和从磁盘中移除
    [self removeLocalizationDictionaryForTable:table update:NO unlink:unlink removeFromDisk:removeFromDisk];
}


// 移除指定表格的本地化字典的方法，可选择是否更新本地化对象、解除链接和从磁盘中移除
+ (void)removeLocalizationDictionaryForTable:(NSString *)table update:(BOOL)update unlink:(BOOL)unlink removeFromDisk:(BOOL)removeFromDisk {
    // 在主线程异步执行
    dispatch_async(dispatch_get_main_queue(), ^{
        // 从内存中移除本地化字典
        NSDictionary *previousDictionary = nil;
        if (!table) {
            // 如果表格名为空，则移除主表格的本地化字典
            previousDictionary = _mainTableDictionary;
            _mainTableDictionary = nil;
        } else {
            // 如果表格名不为空，则移除自定义表格字典中对应表格的本地化字典
            NSMutableDictionary *customTableDictionaries = [self customTableDictionaries];
            previousDictionary = [customTableDictionaries objectForKey:table];
            [customTableDictionaries removeObjectForKey:table];
        }
        
        // 更新本地化对象
        if (update) {
            // 调用方法以更新本地化对象，将之前的字典、新字典设置为空，并强制更新
            [self updateLocalizablesForTable:table previousDictionary:previousDictionary newDictionary:nil force:YES];
        }
        
        // 解除本地化对象的链接
        if (unlink) {
            NSHashTable *hashTable = nil;
            if (!table) {
                // 如果表格名为空，则获取主表格的本地化对象集合
                hashTable = [self mainTableLocalizables];
            } else {
                // 如果表格名不为空，则获取自定义表格字典中对应表格的本地化对象集合，并从字典中移除该表格
                hashTable = [[self customTableLocalizables] objectForKey:table];
                [[self customTableLocalizables] removeObjectForKey:table];
            }
            
            // 遍历本地化对象集合，调用移除本地化方法，并移除所有对象
            for (id<LangKitProtocol> localizableObject in hashTable) {
                [localizableObject removeLocalization];
            }
            [hashTable removeAllObjects];
        }
        
        // 从磁盘中移除本地化字典
        if (removeFromDisk) {
            // 在全局队列异步执行
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                // 获取指定表格的文件路径，并移除该文件
                NSString *filePath = [self filePathForTable:table];
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            });
        }
    });
}

// MARK: Download localization dictionary
// 从给定的URL下载本地化字典并更新本地化数据的方法
+ (void)downloadLocalizationDictionaryWithURL:(NSURL *)URL table:(NSString *)table {
    // 创建URL请求对象
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    
    // 调用方法，使用创建的URL请求对象下载本地化字典并更新本地化数据
    [self downloadLocalizationDictionaryWithURLRequest:URLRequest table:table];
}


// 从给定的URL请求下载本地化字典并更新本地化数据的方法
+ (void)downloadLocalizationDictionaryWithURLRequest:(NSURLRequest *)URLRequest table:(NSString *)table {
    
    // 创建提供的URL请求的可变副本以进行定制
    NSMutableURLRequest *request = [URLRequest mutableCopy];
    
    // 将缓存策略设置为NSURLRequestReloadIgnoringCacheData，以确保获取新鲜数据
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;

    // 创建一个用于进行异步HTTP请求的数据任务
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:URLRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 检查接收到的数据是否非空
        if (data.length > 0) {
            
            // 尝试将接收到的JSON数据解析为可变容器（NSDictionary）
            NSError *parseError = nil;
            id JSONObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
            
            // 检查解析的对象是否为字典
            if ([JSONObject isKindOfClass:[NSDictionary class]]) {
                
                // 调用一个方法以设置本地化字典、更新它，并可选择将其存储到磁盘上
                [self setLocalizationDictionary:JSONObject table:table update:YES storeOnDisk:YES];
            }
        }
    }];
    
    // 启动数据任务
    [task resume];
}

// MARK: Get localized string
// 获取指定本地化键的本地化字符串，使用默认的表格、bundle、默认值和替换字典
+ (NSString *)stringFor:(NSString *)localizationKey {
    return [self stringFor:localizationKey table:nil bundle:nil defaultValue:nil replace:nil];
}

// 获取指定本地化键在指定表格中的本地化字符串，使用默认的bundle、默认值和替换字典
+ (NSString *)stringFor:(NSString *)localizationKey table:(NSString *)table {
    return [self stringFor:localizationKey table:table bundle:nil defaultValue:nil replace:nil];
}

// 获取指定本地化键的本地化字符串，使用默认的表格、bundle和替换字典，指定默认值
+ (NSString *)stringFor:(NSString *)localizationKey replace:(NSDictionary *)replace {
    return [self stringFor:localizationKey table:nil bundle:nil defaultValue:nil replace:replace];
}

// 获取指定本地化键在指定表格中的本地化字符串，使用默认的bundle和替换字典，指定默认值
+ (NSString *)stringFor:(NSString *)localizationKey table:(NSString *)table replace:(NSDictionary *)replace {
    return [self stringFor:localizationKey table:table bundle:nil defaultValue:nil replace:replace];
}

// 获取指定本地化键在指定表格中的本地化字符串，指定bundle、默认值和替换字典
+ (NSString *)stringFor:(NSString *)localizationKey table:(NSString *)table defaultValue:(NSString *)defaultValue replace:(NSDictionary *)replace {
    return [self stringFor:localizationKey table:table bundle:nil defaultValue:defaultValue replace:replace];
}


// 根据本地化键获取本地化字符串的方法，支持指定表格、bundle、默认值和替换字典
+ (NSString *)stringFor:(NSString *)localizationKey table:(NSString *)table bundle:(NSBundle *)bundle defaultValue:(NSString *)defaultValue replace:(NSDictionary *)replace {
    NSString *string = nil;
    
    // 如果未指定bundle，则使用主bundle
    NSBundle *selectedBundle = bundle ?: [NSBundle mainBundle];
    
    // 获取指定表格的本地化字典
    NSDictionary *localizationDictionary = [self localizationDictionaryForTable:table];
    NSLog(@"localizationDictionary: %@",localizationDictionary);
    
    // 在Dialect字典中查找键
    if (localizationDictionary) {
        string = [localizationDictionary objectForKey:localizationKey];//通过key拿到字典中的值
        NSLog(@"string: %@",string);
    }
    
    // 如果在Dialect字典中未找到，则从指定bundle中获取本地化字符串
    if (!string) {
        string = [selectedBundle localizedStringForKey:localizationKey value:nil table:table];
        NSLog(@"string: %@",string);
    }
    
    // 如果仍未找到，则使用指定的默认值
    if (!string) {
        string = defaultValue;
    }
    
    // 如果存在替换字典，进行替换操作
    if (string && replace.count > 0) {
        for (NSString *key in replace.allKeys) {
            string = [string stringByReplacingOccurrencesOfString:key withString:replace[key]];
        }
    }
    
     return string;
}

// MARK: Update localizable objects
// 更新指定表格的本地化对象方法，根据先前和新的本地化字典，可选择是否强制更新
+ (void)updateLocalizablesForTable:(NSString *)table previousDictionary:(NSDictionary *)previousDictionary newDictionary:(NSDictionary *)newDictionary force:(BOOL)force {
    // 获取包含此表格的本地化对象的正确哈希表
    NSHashTable *hashTable = [self mainTableLocalizables];
    if (table) {
        hashTable = [[self customTableLocalizables] objectForKey:table];
    }
    
    // 检查哈希表中是否有本地化对象
    if (hashTable.count > 0) {
        for (id<LangKitProtocol> localizableObject in hashTable) {
            // 检查键是否发生了变化
            NSString *localizationKey = localizableObject.langKitLocalizationKey;
            NSString *previousValue = [previousDictionary objectForKey:localizationKey];
            NSString *newValue = [newDictionary objectForKey:localizationKey];
            
            // 如果强制更新或者键的先前值或新值不为nil且不相等，则调用更新本地化方法
            if (force || ((previousValue != nil || newValue != nil) && ![previousValue isEqual:newValue])) {
                [localizableObject dialect_updateLocalization];
            }
        }
    }
}

@end
