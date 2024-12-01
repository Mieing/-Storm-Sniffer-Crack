#import <Foundation/Foundation.h>

%hook XMXXTEA
+(id)decryptBase64String:(NSString*)stringData stringKey:(NSString*)key {
    NSData *data = %orig;
    NSError *error = nil;
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"解析JSON出错: %@", error);
        return data; // 返回原始数据以防JSON解析失败
    }
    [result setValue:[NSNumber numberWithInt:1] forKey:@"isVip"];
    [result setValue:[NSNumber numberWithInt:1] forKey:@"is_vip"];
    [result setValue:[NSNumber numberWithInt:3] forKey:@"member_type"];
    [result setValue:[NSNumber numberWithInt:99] forKey:@"auth_quantity"];
    [result setValue:@"1733028680" forKey:@"expire_on"];
    [result setValue:@"STTT" forKey:@"member_title"];
    [result setValue:@"🍟" forKey:@"auth_mail"];
    [result setValue:[NSNumber numberWithBool:YES] forKey:@"can_deauthorize"];
    [result setValue:[NSNumber numberWithInt:1] forKey:@"trail_status"];
    [result setValue:[NSNumber numberWithInt:1] forKey:@"ts"];

    // 处理"function_list"字段
    id functionList = [result objectForKey:@"function_list"];
    if ([functionList isKindOfClass:[NSArray class]]) {
        // 如果 function_list 是数组，则直接修改
        [result setValue:@[@1, @2, @3, @4, @5] forKey:@"function_list"];
    } else if ([functionList isKindOfClass:[NSString class]]) {
        // 如果 function_list 是字符串，则处理字符串值
        NSString *functionListStr = (NSString *)functionList;
        if ([functionListStr isEqualToString:@"[1]"]) {
            [result setValue:@"[1,2,3,4,5]" forKey:@"function_list"];
        } else if ([functionListStr isEqualToString:@"\"[1]\""]) {
            [result setValue:@"[1,2,3,4,5]" forKey:@"function_list"];
        }
    }

    NSData *data_result = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"STTT : %@", data_result);
    return data_result;
}
%end
