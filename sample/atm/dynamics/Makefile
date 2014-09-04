include ../../Mkinclude

.SUFFIXES: .f90 .o

OBJS = dynamics.o
SRCS = $(OBJS:.o=.f90)
# MODS = $(OBJS:.o=.mod)

all : $(OBJS) $(BINDIR)
	$(CP) $(OBJS) $(BINDIR) 
	$(CP) *.mod $(BINDIR)

clean:
	$(RM) $(TRASH)

$(BINDIR):
	mkdir -p $@

%.o : %.f90
	$(FC) $(FFLAGS) -I$(JCUPINCDIR) -I$(BINDIR)  -c $<
