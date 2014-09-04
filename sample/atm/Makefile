include ../Mkinclude

.SUFFIXES: .f90 .o

MODEL = atm
TARGET = $(MODEL).exe
OBJS = $(MODEL).o
SRCS = $(OBJS:.o=.f90)
# MODS = $(OBJS:.o=.mod)

all : $(OBJS) $(BINDIR)
	$(CP) $(OBJS) $(BINDIR) 
	$(CP) *.mod $(BINDIR)

clean: clean-sub
	$(RM) $(TRASH)

clean-sub:
	$(MAKE) -C $(DYNAMICS) clean

$(BINDIR):
	mkdir -p $@

atm.o : $(BINDIR)/field_def.o $(BINDIR)/land.o  $(BINDIR)/dynamics.o

$(BINDIR)/field_def.o :
	$(MAKE) -C $(COMMONDIR) 

$(BINDIR)/land.o :
	$(MAKE) -C $(LANDDIR) 

$(BINDIR)/dynamics.o :
	$(MAKE) -C $(DYNAMICS)


# driver.o:
# 	cd $(DRIVER) ; make $(MODEL)

%.o : %.f90
	$(FC) $(FFLAGS) -I$(JCUPINCDIR) -I$(BINDIR)  -c $<
