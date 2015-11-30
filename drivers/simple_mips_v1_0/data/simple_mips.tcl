

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "simple_mips" "NUM_INSTANCES" "DEVICE_ID"  "C_S_BASEADDR" "C_S_HIGHADDR"
}
