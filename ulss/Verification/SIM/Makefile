# Show available test cases and options
#

run:	info

info:
	@echo "//-------------------------list of alias name available in make file ---------------------//"
	@echo "    along with make pass any of the one parameter to run corresponding test or to open waveform"
	@echo "    all                             ---->   to run all the below test cases use make all command"
	@echo "    ulss_base_test                      ---->   to run the ulss_base_test.sv"
	@echo "    reset_test                    ---->   to run the reset_test.sv"
	@echo "    soft_reset_test                ---->   to run the soft_reset_test.sv"
	@echo "    in_stream_zero_reg_test                ---->   to run the in_stream_zero_reg_test.sv"
	@echo "    out_stream_zero_reg_test                ---->   to run the out_stream_zero_reg_test.sv"
	@echo "    stream_map_test                ---->   to run the stream_map_test.sv"
	@echo "    regression                ---->   to run the regression & source the cmd and open the imc"
	@echo "    waveform                ---->   to open the simvision"
	@echo "    clean                ---->   to delete the previous xrun files and cov files"

	@echo "//---------------------------------------------------------------------------------------//"

# Default target that runs all tests
all: ulss_base_test reset_test soft_reset_test in_stream_zero_reg_test out_stream_zero_reg_test stream_map_test   waveform

# Base test case
ulss_base_test:
	@echo "[makefile]  base test case is running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=ulss_base_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  base test case run is completed successfully"

# reset test case
reset_test:
	@echo "[makefile]  reset test case is running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=reset_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  reset test case run is completed successfully"

# soft reset test case
soft_reset_test:
	@echo "[makefile]  soft_reset_test test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=soft_reset_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  soft_reset_test test case run was successful"

# in stream zero reg test case
in_stream_zero_reg_test:
	@echo "[makefile] in_stream_zero_reg_test test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=in_stream_zero_reg_test  -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  in_stream_zero_reg_test test case run was successful"

# out stream zero reg test case
out_stream_zero_reg_test:
	@echo "[makefile] out_stream_zero_reg_test test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=out_stream_zero_reg_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  out_stream_zero_reg_test  test case run was successful"

# stream map test
stream_map_test:
	@echo "[makefile] stream_map_test test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=stream_map_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  stream_map_test test case run was successful"


# in stream zero to three map test
in_stream_zero_to_three_map_test:
	@echo "[makefile] in_stream_zero_to_three_map test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=in_stream_zero_to_three_map_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  in_stream_zero_to_three_map test case run was successful"


# in stream four to seven map test
in_stream_four_to_seven_map_test:
	@echo "[makefile] in_stream_four_to_seven_map test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=in_stream_four_to_seven_map_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  in_stream_four_to_seven_map test case run was successful"

# in stream eight to eleven map test
in_stream_eight_to_eleven_map_test:
	@echo "[makefile] in_stream_eight_to_eleven_map test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=in_stream_eight_to_eleven_map_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  in_stream_eight_to_eleven_map test case run was successful"

# in stream twelve to fifteen map test
in_stream_twelve_to_fifteen_map_test:
	@echo "[makefile] in_stream_twelve_to_fifteen_map test case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=in_stream_twelve_to_fifteen_map_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  in_stream_twelve_to_fifteen_map test case run was successful"


# concurrent stream test 
concurrent_stream_test:
	@echo "[makefile] concurrent_stream_test  case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=concurrent_stream_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  concurrent_stream_test case run was successful"


# empty packet store test 
empty_packet_store_test:
	@echo "[makefile] empty_packet_store_test  case running"
	xrun -access +rwc -f compile_list.f +UVM_TESTNAME=empty_packet_store_test -uvmhome CDNS-1.1d -seed
	@echo "[makefile]  empty_packet_store_test  case run was successful"








#regression
regression:
	@echo "[makefile]  regression running"
	perl otp_regression.pl test_list.f 1
	source cmd
	imc -exec ./cov_files/cov_merge.cmd
	imc&	
	@echo "[makefile]  regression was successfully completed"

clean :

	rm -rf xrun.log / xrun.history / xcelium.d/ wave.shm/ cov_report.txt / cov_report_html/
	@echo "[makefile]  clean was successfully completed"

# Waveform viewing
waveform:
	simvision wave.shm &

