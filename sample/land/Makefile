include ../Mkinclude

.SUFFIXES: .f90 .o

MODEL = land
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

land.o :  $(BINDIR)/field_def.o

$(BINDIR)/field_def.o:
	$(MAKE) -C $(COMMONDIR) 

%.o : %.f90
	$(FC) $(FFLAGS) -I$(JCUPINCDIR) -I$(BINDIR)  -c $<
