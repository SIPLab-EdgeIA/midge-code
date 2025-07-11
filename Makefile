PROJECT_NAME     := spcl
TARGETS          := nrf52832_xxaa_debug nrf52832_xxaa_release 
OUTPUT_DIRECTORY := _build

SDK_ROOT := $(HOME)/nRF5_SDK_15.3.0
PROJ_DIR := 

$(OUTPUT_DIRECTORY)/nrf52832_xxaa_debug.out: \
  LINKER_SCRIPT  := spcl.ld

$(OUTPUT_DIRECTORY)/nrf52832_xxaa_release.out: \
  LINKER_SCRIPT  := spcl.ld

VERSION := $(shell hatch version)

ifndef VERSION
$(error VERSION is not set, is hatch installed?)
endif

ifeq ($(strip $(VERSION)),)
$(error VERSION is empty, is hatch installed?)
endif

# Source files common to all targets
SRC_FILES += \
  $(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52.S \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_rtt.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
  $(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
  $(SDK_ROOT)/components/boards/boards.c \
  $(SDK_ROOT)/modules/nrfx/mdk/system_nrf52.c \
  $(SDK_ROOT)/components/libraries/button/app_button.c \
  $(SDK_ROOT)/components/libraries/util/app_error_weak.c \
  $(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
  $(SDK_ROOT)/components/libraries/timer/app_timer.c \
  $(SDK_ROOT)/components/libraries/util/app_util_platform.c \
  $(SDK_ROOT)/components/libraries/crc16/crc16.c \
  $(SDK_ROOT)/components/libraries/fds/fds.c \
  $(SDK_ROOT)/components/libraries/util/nrf_assert.c \
  $(SDK_ROOT)/components/libraries/fifo/app_fifo.c \
  $(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
  $(SDK_ROOT)/components/libraries/atomic_flags/nrf_atflags.c \
  $(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
  $(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
  $(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
  $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
  $(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
  $(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
  $(SDK_ROOT)/components/libraries/pwr_mgmt/nrf_pwr_mgmt.c \
  $(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
  $(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
  $(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
  $(SDK_ROOT)/components/libraries/low_power_pwm/low_power_pwm.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_clock.c \
  $(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_clock.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_gpiote.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/prs/nrfx_prs.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_saadc.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
  $(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
  $(SDK_ROOT)/components/ble/common/ble_advdata.c \
  $(SDK_ROOT)/components/ble/ble_advertising/ble_advertising.c \
  $(SDK_ROOT)/components/ble/nrf_ble_scan/nrf_ble_scan.c \
  $(SDK_ROOT)/components/ble/common/ble_conn_params.c \
  $(SDK_ROOT)/components/ble/common/ble_conn_state.c \
  $(SDK_ROOT)/components/ble/common/ble_srv_common.c \
  $(SDK_ROOT)/components/ble/nrf_ble_gatt/nrf_ble_gatt.c \
  $(SDK_ROOT)/components/ble/nrf_ble_qwr/nrf_ble_qwr.c \
    $(SDK_ROOT)/components/ble/ble_services/ble_nus/ble_nus.c \
  $(SDK_ROOT)/components/ble/ble_link_ctx_manager/ble_link_ctx_manager.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
  $(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_twim.c \
  $(SDK_ROOT)/components/libraries/sdcard/app_sdcard.c \
  $(SDK_ROOT)/external/fatfs/port/diskio_blkdev.c \
  $(SDK_ROOT)/external/fatfs/src/ff.c \
  $(SDK_ROOT)/external/fatfs/src/option/unicode.c \
  $(SDK_ROOT)/components/libraries/block_dev/sdc/nrf_block_dev_sdc.c \
  $(SDK_ROOT)/integration/nrfx/legacy/nrf_drv_spi.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_spi.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_spim.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_pdm.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_ppi.c \
  $(SDK_ROOT)/modules/nrfx/drivers/src/nrfx_timer.c \
  $(SDK_ROOT)/components/libraries/util/app_error.c \
  $(SDK_ROOT)/components/libraries/util/app_error_handler_gcc.c \
  $(PROJ_DIR)main.c \
  $(PROJ_DIR)saadc/saadc.c \
  $(PROJ_DIR)twi/twi.c \
  $(PROJ_DIR)sd_card/storage.c \
  $(PROJ_DIR)microphone/drv_audio_pdm.c \
  $(PROJ_DIR)ICM20948/ICM20948_driver_interface.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948Augmented.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948AuxCompassAkm.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948AuxTransport.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948DataBaseControl.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948DataBaseDriver.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948DataConverter.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948Dmp3Driver.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948LoadFirmware.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948MPUFifoControl.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948SelfTest.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948Setup.c \
  $(PROJ_DIR)ICM20948/Driver/ICM20948/Icm20948Transport.c \
  $(PROJ_DIR)rythmbadge/systick_lib.c \
  $(PROJ_DIR)rythmbadge/timeout_lib.c \
  $(PROJ_DIR)rythmbadge/ble_lib.c \
  $(PROJ_DIR)rythmbadge/advertiser_lib.c \
  $(PROJ_DIR)rythmbadge/request_handler_lib.c \
  $(PROJ_DIR)rythmbadge/sender_lib.c \
  $(PROJ_DIR)rythmbadge/sampling_lib.c \
  $(PROJ_DIR)rythmbadge/scanner_lib.c \
  $(PROJ_DIR)rythmbadge/file_download_lib.c \
  $(PROJ_DIR)audio_switch/audio_switch.c \
  $(PROJ_DIR)led/led.c \
  
# Include folders common to all targets
INC_FOLDERS += \
  $(SDK_ROOT)/components \
  $(SDK_ROOT)/modules/nrfx/mdk \
  $(SDK_ROOT)/components/libraries/scheduler \
  $(SDK_ROOT)/modules/nrfx \
  $(SDK_ROOT)/components/toolchain/cmsis/include \
  $(SDK_ROOT)/components/libraries/pwr_mgmt \
  $(SDK_ROOT)/components/libraries/strerror \
  $(SDK_ROOT)/components/softdevice/common \
  $(SDK_ROOT)/components/libraries/crc16 \
  $(SDK_ROOT)/components/libraries/bootloader/dfu \
  $(SDK_ROOT)/components/softdevice/s132/headers/nrf52 \
  $(SDK_ROOT)/components/libraries/util \
  $(SDK_ROOT)/components/ble/common \
  $(SDK_ROOT)/components/libraries/balloc \
  $(SDK_ROOT)/components/ble/peer_manager \
  $(SDK_ROOT)/components/libraries/ringbuf \
  $(SDK_ROOT)/modules/nrfx/hal \
  $(SDK_ROOT)/components/libraries/bsp \
  $(SDK_ROOT)/components/libraries/timer \
  $(SDK_ROOT)/external/segger_rtt \
  $(SDK_ROOT)/external/fatfs/port \
  $(SDK_ROOT)/external/fatfs/src \
  $(SDK_ROOT)/components/libraries/log \
  $(SDK_ROOT)/components/ble/nrf_ble_gatt \
  $(SDK_ROOT)/components/ble/nrf_ble_qwr \
  $(SDK_ROOT)/components/libraries/button \
  $(SDK_ROOT)/components/libraries/bootloader \
  $(SDK_ROOT)/components/libraries/fstorage \
  $(SDK_ROOT)/components/libraries/experimental_section_vars \
  $(SDK_ROOT)/components/softdevice/s132/headers \
  $(SDK_ROOT)/integration/nrfx/legacy \
  $(SDK_ROOT)/components/libraries/mutex \
  $(SDK_ROOT)/components/libraries/delay \
  $(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
  $(SDK_ROOT)/components/libraries/atomic_fifo \
  $(SDK_ROOT)/components/libraries/atomic \
  $(SDK_ROOT)/components/libraries/fifo \
  $(SDK_ROOT)/components/boards \
  $(SDK_ROOT)/components/libraries/memobj \
  $(SDK_ROOT)/integration/nrfx \
  $(SDK_ROOT)/components/libraries/fds \
  $(SDK_ROOT)/components/ble/ble_advertising \
  $(SDK_ROOT)/components/libraries/atomic_flags \
  $(SDK_ROOT)/modules/nrfx/drivers/include \
  $(SDK_ROOT)/components/ble/ble_services/ble_dfu \
  $(SDK_ROOT)/components/ble/ble_services/ble_nus \
  $(SDK_ROOT)/components/ble/ble_link_ctx_manager \
  $(SDK_ROOT)/components/ble/nrf_ble_scan \
  $(SDK_ROOT)/external/fprintf \
  $(SDK_ROOT)/components/libraries/svc \
  $(SDK_ROOT)/components/libraries/log/src \
  $(SDK_ROOT)/components/libraries/low_power_pwm \
  $(SDK_ROOT)/components/libraries/block_dev/sdc \
  $(SDK_ROOT)/components/libraries/block_dev \
  $(SDK_ROOT)/components/libraries/sdcard \
  $(SDK_ROOT)/external/protothreads \
  $(SDK_ROOT)/external/protothreads/pt-1.4 \
  config \
  saadc \
  twi \
  sd_card \
  microphone \
  ICM20948 \
  ICM20948/Driver \
  ICM20948/Driver/ICM20948 \
  rythmbadge \
  audio_switch \
  led \
  . \

  
# Libraries common to all targets
LIB_FILES += \

# Optimization flags for the debug build
OPT_DEBUG = -O0 -g3 -Werror #-Os
# Uncomment the line below to enable link time optimization
#OPT_DEBUG += -flto

# Optimization flags for the release build, O2 and O3 cause crashes
OPT_RELEASE = -O1 -DNDEBUG

# C flags common to all targets
#CFLAGS += -DDEBUG #removed to allow the error handler to reset the MCU
CFLAGS += -DBL_SETTINGS_ACCESS_ONLY
CFLAGS += -DBOARD_CUSTOM
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -DNRF52
CFLAGS += -DNRF52832_XXAA
CFLAGS += -DNRF52_PAN_74
CFLAGS += -DNRF_DFU_SVCI_ENABLED
CFLAGS += -DNRF_DFU_TRANSPORT_BLE=1
CFLAGS += -DNRF_SD_BLE_API_VERSION=6
CFLAGS += -DS132
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DSWI_DISABLE0
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums
CFLAGS += -D__HEAP_SIZE=1024
CFLAGS += -D__STACK_SIZE=4096
CFLAGS += -DVERSION=\"$(VERSION)\"
CFLAGS += -std=gnu23

# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
ASMFLAGS += -DBL_SETTINGS_ACCESS_ONLY
ASMFLAGS += -DBOARD_CUSTOM
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -DNRF52
ASMFLAGS += -DNRF52832_XXAA
ASMFLAGS += -DNRF52_PAN_74
ASMFLAGS += -DNRF_DFU_SVCI_ENABLED
ASMFLAGS += -DNRF_DFU_TRANSPORT_BLE=1
ASMFLAGS += -DNRF_SD_BLE_API_VERSION=6
ASMFLAGS += -DS132
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DSWI_DISABLE0
ASMFLAGS += -D__HEAP_SIZE=1024
ASMFLAGS += -D__STACK_SIZE=4096

# Linker flags
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs
LDFLAGS += --specs=nosys.specs


nrf52832_xxaa_debug: CFLAGS += $(OPT_DEBUG)
nrf52832_xxaa_debug: CXXFLAGS += $(OPT_DEBUG)
nrf52832_xxaa_debug: LDFLAGS += $(OPT_DEBUG)

nrf52832_xxaa_release: CFLAGS += $(OPT_RELEASE)
nrf52832_xxaa_release: CXXFLAGS += $(OPT_RELEASE)
nrf52832_xxaa_release: LDFLAGS += $(OPT_RELEASE)

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help

# Default target - first one defined
default: nrf52832_xxaa_debug

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		nrf52832_xxaa_debug   - build the debug binary
	@echo		openocd               - start the openocd server
	@echo		load_gdb              - load the binary and start a debug session
	@echo		logs                  - start the RTT console to see log messages
	@echo		nrf52832_xxaa_release - build the release binary
	@echo		flash_with_gdb        - flashing the release binary
  

TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc


include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash flash_softdevice erase

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52832_xxaa_debug.hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52832_xxaa_debug.hex --sectorerase
	nrfjprog -f nrf52 --reset

# Flash softdevice
flash_softdevice:
	@echo Flashing: s132_nrf52_6.1.1_softdevice.hex
	nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_6.1.1_softdevice.hex --sectorerase
	nrfjprog -f nrf52 --reset

erase:
	nrfjprog -f nrf52 --eraseall

SDK_CONFIG_FILE := config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)

openocd:
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg
load_gdb: nrf52832_xxaa_debug
	@RTT_ADDR=$$(./get_rtt_address.sh); \
	if [ "$$RTT_ADDR" = "" ]; then \
		echo "Error: Could not find the _SEGGER_RTT address"; \
		exit 1; \
	fi; \
  arm-none-eabi-gdb -se _build/nrf52832_xxaa_debug.out -x _build/debug.gdb
logs: SHELL:=$(shell which bash)   # Use the bash shell for the logs target, as sh does not have the disown command
logs:
	socat pty,link=/tmp/ttyvnrf,waitslave tcp:127.0.0.1:8000 & disown
	picocom /tmp/ttyvnrf -b 115200

# Erases code sectors and user info regs
daplink_erase_flash:
	@echo Erase flash
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg \
  -c "init" -c "reset init" -c "nrf5 mass_erase" \
  -c "reset" -c "exit"

# flash the bluetooth stack using the DAPlink
daplink_flash_softdevice: daplink_erase_flash
	@echo Flashing: s132_nrf52_6.1.1_softdevice.hex
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg \
  -c "init" -c "reset init" \
  -c "program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_6.1.1_softdevice.hex" \
  -c "reset" -c "exit"

daplink_flash_debug_without_building:
	@echo Flashing Debug Firmware, version: $(VERSION)
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg \
  -c "init" -c "reset init" \
  -c "program $(OUTPUT_DIRECTORY)/nrf52832_xxaa_debug.hex" \
  -c "reset" -c "exit"

daplink_flash_debug: nrf52832_xxaa_debug
	$(MAKE) daplink_flash_debug_without_building

daplink_flash_release_without_building: 
	@echo Flashing Debug Firmware, version: $(VERSION)
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg \
  -c "init" -c "reset init" \
  -c "program $(OUTPUT_DIRECTORY)/nrf52832_xxaa_release.hex" \
  -c "reset" -c "exit"

daplink_flash_release: nrf52832_xxaa_release 
	$(MAKE) daplink_flash_release_without_building
