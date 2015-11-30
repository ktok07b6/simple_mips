# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_HIGHADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_S_BASEADDR { PARAM_VALUE.C_S_BASEADDR } {
	# Procedure called to update C_S_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_BASEADDR { PARAM_VALUE.C_S_BASEADDR } {
	# Procedure called to validate C_S_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_HIGHADDR { PARAM_VALUE.C_S_HIGHADDR } {
	# Procedure called to update C_S_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_HIGHADDR { PARAM_VALUE.C_S_HIGHADDR } {
	# Procedure called to validate C_S_HIGHADDR
	return true
}


