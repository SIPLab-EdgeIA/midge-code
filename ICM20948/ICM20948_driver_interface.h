#ifndef ICM20948_DRIVER_INTERFACE_H_
#define ICM20948_DRIVER_INTERFACE_H_

#include "Icm20948.h"

#define AK0991x_DEFAULT_I2C_ADDR	0x0C	/* The default I2C address for AK0991x Magnetometers */
#define AK0991x_SECONDARY_I2C_ADDR  0x0E	/* The secondary I2C address for AK0991x Magnetometers */

#define DEF_ST_ACCEL_FS                 2
#define DEF_ST_GYRO_FS_DPS              250
#define DEF_ST_SCALE                    32768
#define DEF_SELFTEST_GYRO_SENS			(DEF_ST_SCALE / DEF_ST_GYRO_FS_DPS)
#define DEF_ST_ACCEL_FS_MG				2000
#define INV20948_ABS(x) (((x) < 0) ? -(x) : (x))

typedef struct{
	uint64_t timestamp;
	float accel[3];
} accel_sample_t;

extern accel_sample_t accel_sample;

ret_code_t icm20948_init(void);
ret_code_t icm20948_set_fsr(uint16_t acc_fsr, uint16_t gyr_fsr);
ret_code_t icm20948_set_datarate(uint8_t datarate);
ret_code_t icm20948_enable_sensors(void);
ret_code_t icm20948_disable_sensors(void);

#endif /* ICM20948_DRIVER_INTERFACE_H_ */
