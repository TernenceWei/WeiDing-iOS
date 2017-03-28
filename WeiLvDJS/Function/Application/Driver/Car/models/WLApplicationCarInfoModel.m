#import "WLApplicationCarInfoModel.h"

#pragma mark -WLApplicationCarInfoimgsModel
@implementation WLApplicationCarInfoimgsModel

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
	NSLog(@"error: WLApplicationCarInfoimgsModel数据模型中:未找到key = %@",key);
	return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.base_url forKey:@"base_url"];
	[aCoder encodeObject:self.Myid forKey:@"Myid"];
	[aCoder encodeObject:self.path forKey:@"path"];
	[aCoder encodeObject:self.file_type forKey:@"file_type"];
	[aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.base_url = [aDecoder decodeObjectForKey:@"base_url"];
		self.Myid = [aDecoder decodeObjectForKey:@"Myid"];
		self.path = [aDecoder decodeObjectForKey:@"path"];
		self.file_type = [aDecoder decodeObjectForKey:@"file_type"];
		self.name = [aDecoder decodeObjectForKey:@"name"];
	}
	return self;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"base_url=%@,Myid=%@,path=%@,file_type=%@,name=%@",_base_url,_Myid,_path,_file_type,_name];
}

@end

#pragma mark -WLApplicationCarInfocar_infoModel
@implementation WLApplicationCarInfocar_infoModel

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
	NSLog(@"error: WLApplicationCarInfocar_infoModel数据模型中:未找到key = %@",key);
	return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.Myid forKey:@"Myid"];
	[aCoder encodeObject:self.audit_memo forKey:@"audit_memo"];
	[aCoder encodeObject:self.company_id forKey:@"company_id"];
	[aCoder encodeObject:self.driver_user_id forKey:@"driver_user_id"];
	[aCoder encodeObject:self.brand forKey:@"brand"];
	[aCoder encodeObject:self.memo forKey:@"memo"];
	[aCoder encodeObject:self.created_at forKey:@"created_at"];
	[aCoder encodeObject:self.first_enabled_at forKey:@"first_enabled_at"];
	[aCoder encodeObject:self.body_name forKey:@"body_name"];
	[aCoder encodeObject:self.auditor_id forKey:@"auditor_id"];
	[aCoder encodeObject:self.seat_amount forKey:@"seat_amount"];
	[aCoder encodeObject:self.number forKey:@"number"];
	[aCoder encodeObject:self.sj_driver_id forKey:@"sj_driver_id"];
	[aCoder encodeObject:self.audit_status forKey:@"audit_status"];
	[aCoder encodeObject:self.is_disabled forKey:@"is_disabled"];
	[aCoder encodeObject:self.updated_at forKey:@"updated_at"];
	[aCoder encodeObject:self.model forKey:@"model"];
	[aCoder encodeObject:self.audit_at forKey:@"audit_at"];
    [aCoder encodeObject:self.day_pricing forKey:@"day_pricing"];
    [aCoder encodeObject:self.kilometer_pricing forKey:@"kilometer_pricing"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.Myid = [aDecoder decodeObjectForKey:@"Myid"];
		self.audit_memo = [aDecoder decodeObjectForKey:@"audit_memo"];
		self.company_id = [aDecoder decodeObjectForKey:@"company_id"];
		self.driver_user_id = [aDecoder decodeObjectForKey:@"driver_user_id"];
		self.brand = [aDecoder decodeObjectForKey:@"brand"];
		self.memo = [aDecoder decodeObjectForKey:@"memo"];
		self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
		self.first_enabled_at = [aDecoder decodeObjectForKey:@"first_enabled_at"];
		self.body_name = [aDecoder decodeObjectForKey:@"body_name"];
		self.auditor_id = [aDecoder decodeObjectForKey:@"auditor_id"];
		self.seat_amount = [aDecoder decodeObjectForKey:@"seat_amount"];
		self.number = [aDecoder decodeObjectForKey:@"number"];
		self.sj_driver_id = [aDecoder decodeObjectForKey:@"sj_driver_id"];
		self.audit_status = [aDecoder decodeObjectForKey:@"audit_status"];
		self.is_disabled = [aDecoder decodeObjectForKey:@"is_disabled"];
		self.updated_at = [aDecoder decodeObjectForKey:@"updated_at"];
		self.model = [aDecoder decodeObjectForKey:@"model"];
		self.audit_at = [aDecoder decodeObjectForKey:@"audit_at"];
        self.day_pricing = [aDecoder decodeObjectForKey:@"day_pricing"];
        self.kilometer_pricing = [aDecoder decodeObjectForKey:@"kilometer_pricing"];
	}
	return self;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"Myid=%@,audit_memo=%@,company_id=%@,driver_user_id=%@,brand=%@,memo=%@,created_at=%@,first_enabled_at=%@,body_name=%@,auditor_id=%@,seat_amount=%@,number=%@,sj_driver_id=%@,audit_status=%@,is_disabled=%@,updated_at=%@,model=%@,audit_at=%@",_Myid,_audit_memo,_company_id,_driver_user_id,_brand,_memo,_created_at,_first_enabled_at,_body_name,_auditor_id,_seat_amount,_number,_sj_driver_id,_audit_status,_is_disabled,_updated_at,_model,_audit_at];
}

@end

#pragma mark -WLApplicationCarInfodataModel
@implementation WLApplicationCarInfodataModel

- (NSMutableArray *)Myimgs{
	if(!_Myimgs){
		_Myimgs=[[NSMutableArray alloc]init];
	}
	return _Myimgs;
}

- (void)setValue:(id)value forKey:(NSString *)key{
	if ([value isKindOfClass:[NSNumber class]]) {
		[self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
	}else{
		[super setValue:value forKey:key];
	}
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
	if ([key isEqualToString:@"imgs"]) {
		for (NSDictionary *dic in value) {
			WLApplicationCarInfoimgsModel *model = [WLApplicationCarInfoimgsModel new];
			[model setValuesForKeysWithDictionary:dic];
			[self.Myimgs addObject:model];
		}
	}
	else if ([key isEqualToString:@"car_info"]) {
		WLApplicationCarInfocar_infoModel *model = [WLApplicationCarInfocar_infoModel new];
		[model setValuesForKeysWithDictionary:value];
		self.Mycar_info = model;
	}
}

-(id)valueForUndefinedKey:(NSString *)key{
	NSLog(@"error: WLApplicationCarInfodataModel数据模型中:未找到key = %@",key);
	return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.opt_status forKey:@"opt_status"];
	[aCoder encodeObject:self.Myimgs forKey:@"Myimgs"];
	[aCoder encodeObject:self.Mycar_info forKey:@"Mycar_info"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.opt_status = [aDecoder decodeObjectForKey:@"opt_status"];
		self.Myimgs = [aDecoder decodeObjectForKey:@"Myimgs"];
		self.Mycar_info = [aDecoder decodeObjectForKey:@"Mycar_info"];
	}
	return self;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"opt_status=%@,Myimgs=%@,Mycar_info=%@",_opt_status,_Myimgs,_Mycar_info];
}

@end

#pragma mark -WLApplicationCarInfoModel
@implementation WLApplicationCarInfoModel

- (void)setValue:(id)value forKey:(NSString *)key{
	if ([value isKindOfClass:[NSNumber class]]) {
		[self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
	}else{
		[super setValue:value forKey:key];
	}
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
	if ([key isEqualToString:@"data"]) {
		WLApplicationCarInfodataModel *model = [WLApplicationCarInfodataModel new];
		[model setValuesForKeysWithDictionary:value];
		self.Mydata = model;
	}
}

-(id)valueForUndefinedKey:(NSString *)key{
	NSLog(@"error: WLApplicationCarInfoModel数据模型中:未找到key = %@",key);
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

