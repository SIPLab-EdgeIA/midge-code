#ifndef __DRV_AUDIO_PDM_H__
#define __DRV_AUDIO_PDM_H__

#include <stdbool.h>
#include <stdint.h>
#include "sdk_errors.h"

#define PDM_BUF_NUM 	2
#define PDM_BUF_SIZE 	4096

typedef struct {
	int16_t  mic_buf[PDM_BUF_SIZE];
	bool released;
} pdm_buf_t;

extern pdm_buf_t pdm_buf[PDM_BUF_NUM];

ret_code_t drv_audio_init(void);

#endif /* __DRV_AUDIO_PDM_H__ */
