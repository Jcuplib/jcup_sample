# JCUPDIR	= $(HOME)/Jcup
JCUPINCDIR	= $(JCUPDIR)/include
JCUPLIBDIR	= $(JCUPDIR)/lib
JCUPLIB		= $(JCUPLIBDIR)/libjcup.a

FC = mpif90 
LD = mpif90

# 32-bit mode
# DEFMPI = MPI2
# #FFLAGS = -c -O2 -KV8PLUS -Am -Ay
# FFLAGS = -cpp -mcmodel medium -shared-intel -O1 -debug all -check all -g
# #FFLAGS = -c -g -cpp -ladebug 

FFLAGS	= -O -cpp

# do NOT forget to add '-assume byterecl' for INTEL fortran
# FFLAGS += -assume byterecl


.SUFFIXES: .f90 .o

OBJS = jcup_interpolation_sample.o common.o 
SRCS = $(OBJS:.o=.f90)
MODS = $(OBJS:.o=.mod)

TARGET1 = comp1
TARGET2 = comp2

all : mapping_table $(TARGET1) $(TARGET2)

$(TARGET1) : $(OBJS) comp1.o
	$(FC) $(LDFLAGS) -o $@ $^ $(JOBJ) $(LIBS) $(JCUPLIB)

$(TARGET2) : $(OBJS) comp2.o
	$(FC) $(LDFLAGS) -o $@ $^ $(JOBJ) $(LIBS) $(JCUPLIB)

mapping_table : common.o cal_mappingtable.o
	$(FC) $(LDFLAGS) -o $@ $^ $(JOBJ) $(LIBS) $(JCUPLIB)

clean:
	-rm -f *.mod *.o

.f90.o:	
	$(FC) $(FFLAGS) -I$(JCUPINCDIR) -c $< 
