#import "WL_MessageList_Model.h"

#pragma mark -WL_MessageList_itemsModel
@implementation WL_MessageList_itemsModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"Myid"];
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList_itemsModel数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.relation_id forKey:@"relation_id"];
    [aCoder encodeObject:self.Myid forKey:@"Myid"];
    [aCoder encodeObject:self.to_user_id forKey:@"to_user_id"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.from_user_id forKey:@"from_user_id"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.msg_type forKey:@"msg_type"];
    [aCoder encodeObject:self.role_type forKey:@"role_type"];
    [aCoder encodeObject:self.is_deleted forKey:@"is_deleted"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.relation_id = [aDecoder decodeObjectForKey:@"relation_id"];
        self.Myid = [aDecoder decodeObjectForKey:@"Myid"];
        self.to_user_id = [aDecoder decodeObjectForKey:@"to_user_id"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.from_user_id = [aDecoder decodeObjectForKey:@"from_user_id"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.msg_type = [aDecoder decodeObjectForKey:@"msg_type"];
        self.role_type = [aDecoder decodeObjectForKey:@"role_type"];
        self.is_deleted = [aDecoder decodeObjectForKey:@"is_deleted"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"status=%@,relation_id=%@,Myid=%@,to_user_id=%@,title=%@,from_user_id=%@,message=%@,msg_type=%@,role_type=%@,is_deleted=%@,created_at=%@",_status,_relation_id,_Myid,_to_user_id,_title,_from_user_id,_message,_msg_type,_role_type,_is_deleted,_created_at];
}

@end

#pragma mark -WL_MessageList_selfModel
@implementation WL_MessageList_selfModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList_selfModel数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.href forKey:@"href"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.href = [aDecoder decodeObjectForKey:@"href"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"href=%@",_href];
}

@end

#pragma mark -WL_MessageList__linksModel
@implementation WL_MessageList__linksModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"self"]) {
        WL_MessageList_selfModel *model = [WL_MessageList_selfModel new];
        [model setValuesForKeysWithDictionary:value];
        self.Myself = model;
    }else if ([key isEqualToString:@"last"]) {
        WL_MessageList_selfModel *model = [WL_MessageList_selfModel new];
        [model setValuesForKeysWithDictionary:value];
        self.Mylast = model;
    }else if ([key isEqualToString:@"next"]) {
        WL_MessageList_selfModel *model = [WL_MessageList_selfModel new];
        [model setValuesForKeysWithDictionary:value];
        self.MyNext = model;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList__linksModel数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Myself forKey:@"Myself"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.Myself = [aDecoder decodeObjectForKey:@"Myself"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Myself=%@",_Myself];
}

@end

#pragma mark -WL_MessageList__metaModel
@implementation WL_MessageList__metaModel

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList__metaModel数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.currentPage forKey:@"currentPage"];
    [aCoder encodeObject:self.totalCount forKey:@"totalCount"];
    [aCoder encodeObject:self.perPage forKey:@"perPage"];
    [aCoder encodeObject:self.pageCount forKey:@"pageCount"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.currentPage = [aDecoder decodeObjectForKey:@"currentPage"];
        self.totalCount = [aDecoder decodeObjectForKey:@"totalCount"];
        self.perPage = [aDecoder decodeObjectForKey:@"perPage"];
        self.pageCount = [aDecoder decodeObjectForKey:@"pageCount"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"currentPage=%@,totalCount=%@,perPage=%@,pageCount=%@",_currentPage,_totalCount,_perPage,_pageCount];
}

@end

#pragma mark -WL_MessageList_dataModel
@implementation WL_MessageList_dataModel

- (NSMutableArray *)Myitems{
    if(!_Myitems){
        _Myitems=[[NSMutableArray alloc]init];
    }
    return _Myitems;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"items"]) {
        for (NSDictionary *dic in value) {
            WL_MessageList_itemsModel *model = [WL_MessageList_itemsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.Myitems addObject:model];
        }
    }
    else if ([key isEqualToString:@"_links"]) {
        WL_MessageList__linksModel *model = [WL_MessageList__linksModel new];
        [model setValuesForKeysWithDictionary:value];
        self.My_links = model;
    }
    else if ([key isEqualToString:@"_meta"]) {
        WL_MessageList__metaModel *model = [WL_MessageList__metaModel new];
        [model setValuesForKeysWithDictionary:value];
        self.My_meta = model;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList_dataModel数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Myitems forKey:@"Myitems"];
    [aCoder encodeObject:self.My_links forKey:@"My_links"];
    [aCoder encodeObject:self.My_meta forKey:@"My_meta"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.Myitems = [aDecoder decodeObjectForKey:@"Myitems"];
        self.My_links = [aDecoder decodeObjectForKey:@"My_links"];
        self.My_meta = [aDecoder decodeObjectForKey:@"My_meta"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Myitems=%@,My_links=%@,My_meta=%@",_Myitems,_My_links,_My_meta];
}

@end

#pragma mark -WL_MessageList_Model
@implementation WL_MessageList_Model

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"data"]) {
        WL_MessageList_dataModel *model = [WL_MessageList_dataModel new];
        [model setValuesForKeysWithDictionary:value];
        self.Mydata = model;
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
//    NSLog(@"error: WL_MessageList_Model数据模型中:未找到key = %@",key);
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.Mydata forKey:@"Mydata"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.Mydata = [aDecoder decodeObjectForKey:@"Mydata"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"status=%@,message=%@,Mydata=%@",_status,_message,_Mydata];
}

@end

