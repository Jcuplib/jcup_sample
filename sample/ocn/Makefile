include ../Mkinclude

.SUFFIXES: .f90 .o

MODEL = ocn
TARGET = $(MODEL).exe
OBJS = $(MODEL).o
SRCS = $(OBJS:.o=.f90)
# MODS = $(OBJS:.o=.mod)

all : $(OBJS) $(BINDIR)
	$(CP) $(OBJS) $(BINDIR) 
	$(CP) *.mod $(BINDIR)

clean:
	$(RM) $(TRASH)

$(BINDIR):
	mkdir -p $@

ocn.o : $(BINDIR)/ice.o $(BINDIR)/field_def.o


$(BINDIR)/field_def.o:
	$(MAKE) -C $(COMMONDIR) 

$(BINDIR)/ice.o:
	$(MAKE) -C $(ICEDIR) 

# driver.o:
# 	cd $(DRIVER) ; make $(MODEL)

%.o : %.f90
	$(FC) $(FFLAGS) -I$(JCUPINCDIR) -I$(BINDIR)  -c $<
