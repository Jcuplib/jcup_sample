all:
	@echo '% make {compile|run|clean}'
run:
	./mpich2_go 
clean:
	rm -f *.log *.log.* fort.* Stdout Stderr atm_driver ocn_driver chm_driver
compile:
	make -C ../ all
